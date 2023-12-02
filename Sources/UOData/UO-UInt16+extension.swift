//Copyright © 2023 Charles Kerr. All rights reserved.

import Foundation

extension UInt16 {
    public var withAlpha :UInt16 {
        return self & 0x7FFF == 0 ? 0 : self|0x8000
    }
}
