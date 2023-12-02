//Copyright © 2023 Charles Kerr. All rights reserved.

import Foundation

//==========================================================================================
protocol Information : UOTileFlag {
   var name:String {get set}
}


//==========================================================================================
// Terrain Information
//==========================================================================================
//==========================================================================================
struct TerrainInformation {
    static public let RECORDSIZE = 30
    public let type:TileType = .terrain
    public var flag:UInt64 = 0
    public var name:String = ""
    public var textureID:Int = 0
}

//==========================================================================================
extension TerrainInformation : Information {
    init(uoData data:Data){
        self.init()
        guard data.count >= TerrainInformation.RECORDSIZE - 4 else {
            return
        }
        let flagLength = data.count >= TerrainInformation.RECORDSIZE ? 8 : 4
        var offset = 0
        if (flagLength == 8) {
            flag = data.withUnsafeBytes { ptr in
                ptr.loadUnaligned(fromByteOffset: 0, as: UInt64.self)
            }
        }
        else {
            flag = data.withUnsafeBytes { ptr in
                UInt64(truncatingIfNeeded: ptr.loadUnaligned(fromByteOffset: 0, as: UInt32.self))
            }
        }
        offset += flagLength
        textureID = data.withUnsafeBytes { ptr in
            Int(truncatingIfNeeded:ptr.loadUnaligned(fromByteOffset: offset, as: UInt16.self))
        }
        offset += 2
        name = data[data.startIndex+offset..<data.startIndex+offset+20].nonNullAsciiString
    }
    //==========================================================================================
    public func toData(useLargeFlag:Bool) ->Data {
        var rvalue = Data()
        if (useLargeFlag){
            rvalue.append(flag.data)
        }
        else {
            rvalue.append(UInt32(truncatingIfNeeded: flag).data)
        }
        rvalue.append(UInt16(truncatingIfNeeded: textureID).data)
        rvalue.append(name.fixedData(size: 20))
        return rvalue
    }
}

//==========================================================================================
// Art Information
//==========================================================================================
//==========================================================================================
struct ArtInformation {
    static public let RECORDSIZE = 41
    public let type:TileType = .art
    public var flag:UInt64 = 0
    public var weight:Int = 0
    public var quality:Int = 0
    public var miscData:Int = 0
    public var unknown2:Int = 0
    public var quantity:Int = 0
    public var animID:Int = 0
    public var unknown3:Int = 0
    public var hue:Int = 0
    public var stackingOffset:Int = 0
    public var height:Int = 0
    public var name:String = ""
}
//==========================================================================================
extension ArtInformation : Information {
    init(uoData data:Data){
        self.init()
        guard data.count >= (ArtInformation.RECORDSIZE - 4) else {
            return
        }
        let flagLength = data.count >= TerrainInformation.RECORDSIZE ? 8 : 4
        var offset = 0
        if (flagLength == 8) {
            flag = data.withUnsafeBytes { ptr in
                ptr.loadUnaligned(fromByteOffset: 0, as: UInt64.self)
            }
        }
        else {
            flag = data.withUnsafeBytes { ptr in
                UInt64(truncatingIfNeeded: ptr.loadUnaligned(fromByteOffset: 0, as: UInt32.self))
            }
        }
        offset += flagLength
        
        weight = data.withUnsafeBytes{ ptr in
            Int(truncatingIfNeeded: ptr.loadUnaligned(fromByteOffset: offset, as: UInt8.self))
        }
        offset += 1
        
        quality = data.withUnsafeBytes{ ptr in
            Int(truncatingIfNeeded: ptr.loadUnaligned(fromByteOffset: offset, as: UInt8.self))
        }
        offset += 1
        
        miscData = data.withUnsafeBytes{ ptr in
            Int(truncatingIfNeeded: ptr.loadUnaligned(fromByteOffset: offset, as: UInt16.self))
        }
        offset += 2
        
        unknown2 = data.withUnsafeBytes{ ptr in
            Int(truncatingIfNeeded: ptr.loadUnaligned(fromByteOffset: offset, as: UInt8.self))
        }
        offset += 1
        
        quantity = data.withUnsafeBytes{ ptr in
            Int(truncatingIfNeeded: ptr.loadUnaligned(fromByteOffset: offset, as: UInt8.self))
        }
        offset += 1
        
        animID = data.withUnsafeBytes{ ptr in
            Int(truncatingIfNeeded: ptr.loadUnaligned(fromByteOffset: offset, as: UInt16.self))
        }
        offset += 2
        
        unknown3 = data.withUnsafeBytes{ ptr in
            Int(truncatingIfNeeded: ptr.loadUnaligned(fromByteOffset: offset, as: UInt8.self))
        }
        offset += 1
        
        hue = data.withUnsafeBytes{ ptr in
            Int(truncatingIfNeeded: ptr.loadUnaligned(fromByteOffset: offset, as: UInt8.self))
        }
        offset += 1
        
        stackingOffset = data.withUnsafeBytes{ ptr in
            Int(truncatingIfNeeded: ptr.loadUnaligned(fromByteOffset: offset, as: UInt16.self))
        }
        offset += 2
        
        height = data.withUnsafeBytes{ ptr in
            Int(truncatingIfNeeded: ptr.loadUnaligned(fromByteOffset: offset, as: UInt8.self))
        }
        offset += 1
        name = data[data.startIndex+offset..<data.startIndex+offset+20].nonNullAsciiString
    }
    //==========================================================================================
    public func toData(useLargeFlag:Bool) ->Data {
        var rvalue = Data()
        if (useLargeFlag){
            rvalue.append(flag.data)
        }
        else {
            rvalue.append(UInt32(truncatingIfNeeded: flag).data)
        }
        rvalue.append(UInt8(truncatingIfNeeded: weight).data)
        rvalue.append(UInt8(truncatingIfNeeded: quality).data)
        rvalue.append(UInt16(truncatingIfNeeded: miscData).data)
        rvalue.append(UInt8(truncatingIfNeeded: unknown2).data)
        rvalue.append(UInt8(truncatingIfNeeded: quantity).data)
        rvalue.append(UInt16(truncatingIfNeeded: animID).data)
        rvalue.append(UInt8(truncatingIfNeeded: unknown3).data)
        rvalue.append(UInt8(truncatingIfNeeded: hue).data)
        rvalue.append(UInt16(truncatingIfNeeded: stackingOffset).data)
        rvalue.append(UInt8(truncatingIfNeeded: height).data)
        rvalue.append(name.fixedData(size: 20))
        return rvalue
    }
}
//==========================================================================================
// TileInformation (the container for "tiledata.mul"
struct TileInformation {
    static public let MULFILENAME = "tiledata.mul"
    static public let HSSize = 3188736
    public var terrainInfo:[TerrainInformation] = [TerrainInformation]()
    public var artInfo:[ArtInformation] = [ArtInformation]()
}
extension TileInformation {
    init(uoURL:URL) {
        loadTileInformation(uoURL: uoURL)
    }
    public mutating func loadTileInformation(uoURL: URL) {
        let url = uoURL.appending(path: TileInformation.MULFILENAME)
        loadTileInformation(tileDataURL: url)
    }
    public mutating func loadTileInformation(tileDataURL: URL) {
        terrainInfo = [TerrainInformation]()
        artInfo = [ArtInformation]()
        
        guard let data = try? Data(contentsOf: tileDataURL) else {
            return
        }
        guard !data.isEmpty else {
            return
        }
        let largeFlag = data.count >= TileInformation.HSSize
        var recordSize = largeFlag ? 30 : 26
        var offset = 0
        for i in 0..<0x4000 {
            if (largeFlag) {
                if(((( i & 0x1F ) == 0 ) && ( i > 0 )) || ( i == 1 )) {
                    offset += 4
                }
            }
            else {
                if ( (i & 0x1f) == 0) {
                    offset += 4
                }
            }
            terrainInfo.append(TerrainInformation(uoData: data[offset..<offset+recordSize]))
            offset += recordSize
        }
        recordSize = largeFlag ? 41 : 37
        var index = 0
        while (offset < data.count) {
            if ( (index & 0x1f) == 0) {
                offset += 4
            }
            if (offset+recordSize <= data.count){
                artInfo.append(ArtInformation(uoData: data[offset..<offset+recordSize]))
                offset += recordSize
            }
            else {
                break
            }
            index += 1
       }
    }
}
