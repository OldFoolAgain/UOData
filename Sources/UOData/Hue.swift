//Copyright © 2023 Charles Kerr. All rights reserved.

import Foundation

/*
 HueEntry
 WORD ColorTable[32];
 WORD TableStart;
 WORD TableEnd;
 CHAR Name[20];
 
 HueGroup
 DWORD Header;
 HueEntry Entries[8];

 */



//=======================================================================================================
// HueEntry
//=======================================================================================================
struct HueEntry {
    static public let RECORDSIZE = 88
    public var colors = [UInt16](repeating: 0, count: 32)
    public var nameData = [UInt8](repeating: 0, count: 20)
}
extension HueEntry {
    init(data:Data) {
        self.init()
        guard data.count >= HueEntry.RECORDSIZE else {
            return
        }
        colors = data.subdata(in: data.startIndex..<data.startIndex+64).uInt16Array
        for (index,pixel) in colors.enumerated() {
            colors[index] = pixel.withAlpha
        }
        nameData = data.subdata(in: data.startIndex+68..<data.startIndex+88).uInt8Array
    }
    public var data:Data {
        var rvalue = colors.data
        rvalue.append(colors[0].data)
        rvalue.append(colors[31].data)
        rvalue.append(nameData.data)
        return rvalue
    }
    public var name:String {
        nameData.data.nonNullAsciiString
    }
}

struct Hue {
    static public let MULFILENAME = "hues.mul"
    static public let GROUPENTRY = 8
    static public let GROUPSIZE = GROUPENTRY * HueEntry.RECORDSIZE + 4
    
    public var entries = [HueEntry]()
}

extension Hue {
    init(hueURL url:URL) {
        self.init()
        guard let exists = try? url.checkResourceIsReachable() else { return }
        guard exists else { return }
        guard let data = try? Data(contentsOf: url) else { return }
        let count = data.count / Hue.GROUPSIZE
        entries.reserveCapacity(count * Hue.GROUPENTRY)
        for index  in 0..<count {
            let groupData = data[index*Hue.GROUPSIZE..<(index+1) * Hue.GROUPSIZE]
            for groupEntry in 0..<Hue.GROUPENTRY {
                entries.append(HueEntry(data: groupData[groupData.startIndex+4 + (groupEntry*HueEntry.RECORDSIZE)..<groupData.startIndex+4 + ((groupEntry+1)*HueEntry.RECORDSIZE)]))
            }
        }
    }
    public var data:Data {
        var rvalue = Data()
        let groupCount = entries.count / Hue.GROUPENTRY // Yes, this means the count must be multiple of "groups"
        for groupIndex in 0..<groupCount {
            rvalue.append(UInt32(0).data)
            for entryIndex in 0..<Hue.GROUPENTRY {
                rvalue.append(entries[(groupIndex * Hue.GROUPENTRY) + entryIndex].data)
            }
        }
        return rvalue
    }
    
    public var count:Int {
        return entries.count
    }
}
