//Copyright © 2023 Charles Kerr. All rights reserved.

import Foundation

//========================================================================================
// UO IDX files contain records that point to data in another file ("MUL" file)
// The record is 3 32 bit values, but we use Int and handle the size on I/O
//=========================================================================================

//=========================================================================================
struct IDXEntry {
    public static let RECORDSIZE = 12
    public var fileOffset:Int = 0xFFFFFFFF
    public var length:Int = 0
    public var extra:Int = 0
}

//=========================================================================================
extension IDXEntry {
    init(idxData:Data) {
        self.init()
        guard idxData.count >= IDXEntry.RECORDSIZE else {
            return
        }
        fileOffset =  idxData.withUnsafeBytes { ptr in
            Int(truncatingIfNeeded:ptr.loadUnaligned(fromByteOffset: 0, as: UInt32.self))
        }
        length = idxData.withUnsafeBytes { ptr in
            Int(truncatingIfNeeded: ptr.loadUnaligned(fromByteOffset: 4, as: UInt32.self))
        }
        extra = idxData.withUnsafeBytes { ptr in
            Int(truncatingIfNeeded: ptr.loadUnaligned(fromByteOffset: 8, as: UInt32.self))
        }
    }

    public var data:Data {
        var temp = UInt32(truncatingIfNeeded: fileOffset).data
        temp.append(UInt32(truncatingIfNeeded: length).data)
        temp.append(UInt32(truncatingIfNeeded: extra).data)
        return temp
    }
    
    public var isValid:Bool {
        return fileOffset != 0xFFFFFFFF && length != 0
    }
    //====================================================================
    public  var textureSize:Int {
        return extra == 1 ? 128 : 64
    }
    
    //===================================================================
    public var gumpWidth:Int {
        return extra & 0xFFFF
    }
    //===================================================================
    public var gumpHeight:Int {
        return (extra >> 16) & 0xFFFF
    }
    //===================================================================
    public var soundIndex:Int {
        return extra & 0xFFFF
    }
}

