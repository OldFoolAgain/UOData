//Copyright © 2023 Charles Kerr. All rights reserved.

import Foundation

//==========================================================================================
extension Data {
    public  var nonNullAsciiString:String {
        var name =  String(data: self, encoding: .ascii)!
        // We need to strip off the nulls
        let nullstart = name.firstIndex { value in
            return (value.asciiValue ?? 0) == 0
        }
        if  nullstart != nil {
            // So there was some null characters
            name.removeSubrange(nullstart!..<name.endIndex)
        }
        return name
    }
    
    /*
     0-31
    < (less than)
    > (greater than)
    : (colon - sometimes works, but is actually NTFS Alternate Data Streams)
    " (double quote)
    / (forward slash)
    \ (backslash)
    | (vertical bar or pipe)
    ? (question mark)
    * (asterisk)
     */
    /*
    func cleanAsciiString(subsitute:Character) ->String {
        var firstEndNonNul = self.startIndex
        for i in (self.startIndex..<self.endIndex).reversed() {
            firstEndNonNul = i
            if self[i] != 0 {
                break
            }
        }
        print(firstEndNonNul)
    }
     */
}
