//Copyright © 2023 Charles Kerr. All rights reserved.

import Foundation
import ImageIO

struct Artwork {
    static public let ARTUOPFILE = "artLegacyMUL.uop"
    static public let ARTIDXFILE = "artidx.mul"
    static public let ARTMULFILE = "art.mul"
    static public let UOPHASHFORMAT = "build/artlegacymul/%08u.tga"
    
    public var terrainData = [Data]()
    public var artData = [Data]()
}
extension Artwork {
    //===================================================================================================================
    public mutating func loadArtwork(uopURL: URL) {
        terrainData = [Data]()
        artData = [Data]()
        if (uopURL.exist && uopURL.validUOP) {
            let offsets = uopURL.gatherUOPOffsets(formatString: Artwork.UOPHASHFORMAT, maxIndex: 0xFFFF + 0x3FFF)
            let uopdata = try! Data(contentsOf: uopURL)
            // gather the terrain data
            for index in 0..<0x4000 {
                let  entryIndex = offsets.index(forKey: index)
                if entryIndex == nil {
                    terrainData.append(Data())
                }
                else {
                    let entry = offsets[index]!
                    if (entry.isValid) {
                        terrainData.append(uopdata[(entry.fileOffset + entry.headerLength)..<(entry.fileOffset + entry.headerLength + entry.decompressedLength)])
                    }
                    else {
                        terrainData.append(Data())
                    }
                }
            }
            for index in 0..<0xFFFF {
                let  entryIndex = offsets.index(forKey: index + 0x4000)
                if entryIndex == nil {
                    artData.append(Data())
                }
                else {
                    let entry = offsets[index + 0x4000]!
                    if (entry.isValid) {
                        artData.append(uopdata[(entry.fileOffset + entry.headerLength)..<(entry.fileOffset + entry.headerLength + entry.decompressedLength)])
                    }
                    else {
                        artData.append(Data())
                    }
                }
                
            }
        }
    }
    //===================================================================================================================
    public mutating func loadArtwork(idxURL:URL,mulURL:URL) {
        terrainData = [Data]()
        artData = [Data]()
        if (idxURL.exist && mulURL.exist){
            let offsets = idxURL.idxEntries
            let artdata = try! Data(contentsOf: mulURL)
            for index in 0..<0x4000 {
                
                if index < offsets.count {
                    terrainData.append(Data())
                }
                else {
                    
                    let entry = offsets[index]
                    if (entry.isValid) {
                        terrainData.append(artdata[entry.fileOffset..<(entry.fileOffset + entry.length)])
                    }
                    else {
                        terrainData.append(Data())
                    }
                }
            }
            for index in 0..<0xFFFF {
                if (index + 0x4000) < offsets.count {
                    artData.append(Data())
                }
                else {
                    
                    let entry = offsets[index + 0x4000]
                    if (entry.isValid) {
                        artData.append(artdata[entry.fileOffset..<(entry.fileOffset + entry.length)])
                    }
                    else {
                        artData.append(Data())
                    }
                }
            }
        }
    }
    
    //===================================================================================================================
    public mutating func loadArtwork(uoURL: URL) {
        let idxurl = uoURL.appending(path: Artwork.ARTIDXFILE)
        let mulurl = uoURL.appending(path: Artwork.ARTMULFILE)
        let uopurl = uoURL.appending(path: Artwork.ARTUOPFILE)
        
        if (uopurl.exist && uopurl.validUOP) {
            loadArtwork(uopURL: uopurl)
        }
        else if (idxurl.exist && mulurl.exist){
            loadArtwork(idxURL: idxurl, mulURL: mulurl)
        }
    }
    
    //===================================================================================================================
    init(uoURL url:URL) {
        self.init()
        loadArtwork(uoURL: url)
    }
    //===================================================================================================================
    init(uopURL url:URL) {
        self.init()
        loadArtwork(uopURL: url)
    }
    //===================================================================================================================
    init(idxURL:URL,mulURL:URL) {
        self.init()
        loadArtwork(idxURL: idxURL, mulURL: mulURL)
    }
    
    //=================================================================================================================
    public func artImage(forData data:Data) -> CGImage? {
        
        guard data.count > 8 else {
            return nil
        }
        let width = Int( truncatingIfNeeded:data.withUnsafeBytes({ ptr in
            ptr.loadUnaligned(fromByteOffset: 4, as: UInt16.self)
        }))
        let height = Int( truncatingIfNeeded:data.withUnsafeBytes({ ptr in
            ptr.loadUnaligned(fromByteOffset: 6, as: UInt16.self)
        }))

        if height >= 1024 || height == 0 || width == 0 || width >= 1024 {
            return nil
        }
        // We have a valid size
        var imageData = [UInt16](repeating: 0, count: Int(width * height))
        // the offset for each row
        
        let tableData =  data.subdata(in: data.startIndex + 8..<(data.startIndex+8)+(height*2)).uInt16Array
        let pixelData = data.subdata(in: data.startIndex + 8 + (height*2)..<data.endIndex).uInt16Array
        var X = 0
        var Y = 0
        var index = Int( truncatingIfNeeded: tableData[Y] )
        
        while Y < height {
            let xoff = Int( truncatingIfNeeded: pixelData[index] )
            let run =  Int( truncatingIfNeeded: pixelData[index+1])
            index += 2
            if ( (xoff + run) >= 2048) {
                break
            }
            else if ((xoff + run) != 0){
                X += xoff
                for j in 0..<run {
                    imageData[Y * width + X + j] = pixelData[index].withAlpha
                    index += 1
                }
                X += run
            }
            else {
                X = 0
                Y += 1
                if ( Y < height){
                    index = Int(tableData[Y])
                }
            }
        }
        return imageData.withUnsafeBufferPointer({ ptr in
            Data(buffer: ptr)
        }).createImage(width: width, height: height, hasAlpha: true , pixelDepth: 16)
    }
    //=================================================================================================================
    public func terrainImage(forData data:Data) -> CGImage? {
        guard data.count == 2048 else {
            return nil
        }
        let terrainData = data.subdata(in: data.startIndex..<data.endIndex)
        // we now have an array of encoded pixel data
        // make a contiguous array of what we want
        let pixelData = terrainData.uInt16Array
        var imageData = [UInt16](repeating: 0, count: 44*44)
        // Make the first half
        var index = 0
        var run = 2
        var xloc = 21
        for height in 0..<22 {
            for offset in 0..<run {
                imageData[ height*44 + xloc + offset] = pixelData[index].withAlpha
                index += 1
            }
            xloc -= 1
            run += 2
        }
        run = 44
        xloc = 0
        for height in 22..<44 {
            for offset in 0..<run {
                imageData[ height*44 + xloc + offset] = pixelData[index].withAlpha
                index += 1
            }
            xloc += 1
            run -= 2
        }
        return imageData.withUnsafeBufferPointer({ ptr in
            Data(buffer: ptr)
        }).createImage(width:44, height:44, hasAlpha: true , pixelDepth: 16)


     }

}
