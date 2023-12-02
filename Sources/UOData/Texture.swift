//Copyright © 2023 Charles Kerr. All rights reserved.

import Foundation
import ImageIO

struct Texture {
    
    static public let IDXFILENAME = "texidx.mul"
    static public let MULFILENAME = "texmaps.mul"
    static public let SIZEFOR64 = 8192

    var entries = [Data]()
}

extension Texture {
    public var count:Int {
        return entries.count
    }
    public mutating func loadTexture(idxURL:URL,mulURL:URL){
        entries = [Data]()
        let idxOffsets = idxURL.idxEntries
        guard let data = try? Data(contentsOf: mulURL) else { return }
        entries.reserveCapacity(idxOffsets.count)
        for entry in idxOffsets {
            if (!entry.isValid) {
                entries.append(Data())
                continue
            }
            if (data.count < entry.fileOffset + entry.length ) {
                entries.append(Data())
                continue
            }
            entries.append(data[entry.fileOffset..<entry.fileOffset+entry.length])
         }
        
    }
    init(uoURL: URL) {
        self.init()
        loadTexture(idxURL: uoURL.appending(path: Texture.IDXFILENAME), mulURL: uoURL.appending(path: Texture.MULFILENAME))
    }
    init(idxURL: URL, mulURL: URL){
        self.init()
        loadTexture(idxURL: idxURL, mulURL: mulURL)
    }
    public func saveTo(uoURL url:URL){
        saveTo(idxURL: url.appending(path: Texture.IDXFILENAME), mulURL: url.appending(path: Texture.MULFILENAME))
    }
    public func saveTo(idxURL:URL,mulURL:URL) {
        guard let idx = try? FileHandle(forWritingTo: idxURL) else { return }
        guard let mul = try? FileHandle(forWritingTo: mulURL) else { return }
        for data in entries {
            var entry = IDXEntry()
            if (data.isEmpty) {
                try! idx.write(contentsOf: entry.data)
            }
            else {
                entry.fileOffset = Int(truncatingIfNeeded:  try! mul.offset())
                entry.length = data.count
                entry.extra = data.count == Texture.SIZEFOR64 ? 0 : 1
                try! idx.write(contentsOf: entry.data)
                try! mul.write(contentsOf: data)
            }
        }
    }
    
    public func dataFor(tileID:Int) -> Data {
        guard tileID >= 0 && tileID < entries.count else { return Data() }
        return entries[tileID]
    }
    public func imageFor(tileID:Int) -> CGImage? {
        guard tileID >= 0 && tileID < entries.count else { return nil }
        var data = entries[tileID]
        guard !data.isEmpty else { return nil }
        var pixels = data.uInt16Array
        for (index,pixel) in pixels.enumerated() {
            pixels[index] = pixel.withAlpha
        }
        data = pixels.data
        let size = data.count == Texture.SIZEFOR64 ? 64 : 128
        return data.createImage(width: size, height: size,hasAlpha: true,pixelDepth: 16)
    }
}
