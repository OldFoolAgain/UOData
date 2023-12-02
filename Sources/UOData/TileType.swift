//Copyright © 2023 Charles Kerr. All rights reserved.

import Foundation

//==========================================================================================
// Define the types of tiles
enum TileType {
    case none
    case terrain
    case art
    case multi
    
    public func name() -> String {
        switch (self) {
            case .none:
                return "none"
            case .terrain:
                return "terrain"
            case .art:
                return "art"
            case .multi:
                return "multi"
        }
        
    }

}
