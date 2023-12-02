//Copyright © 2023 Charles Kerr. All rights reserved.

import Foundation



//==========================================================================================
enum TileFlagBitType :Int, CaseIterable {
    case background
    case weapon
    case transparent
    case translucent
    case wall
    case damaging
    case impassable
    case wet
    case bit8
    case surface
    case climbable
    case stackable
    case window
    case noShoot
    case articleA
    case articleAn
    case articleThe
    case foilage
    case partialHue
    case noHouse
    case map
    case container
    case wearable
    case lightSource
    case animated
    case hoverOver
    case noDiagnol
    case armor
    case roof
    case door
    case stairBack
    case stairRight
    case alphaBlend
    case useNewArt
    case artUsed
    case bit35
    case noShadow
    case pixelBleed
    case playAnimOnce
    case bit39
    case bit40
    case bit41
    case bit42
    case bit43
    case bit44
    case bit45
    case bit46
    case bit47
    case bit48
    case bit49
    case bit50
    case bit51
    case bit52
    case bit53
    case bit54
    case bit55
    case bit56
    case bit57
    case bit58
    case bit59
    case bit60
    case bit61
    case bit62
    case bit63
    
    static public let TILEFLAGNAME = ["background","weapon","transparent","translucent",
                               "wall","damaging","impassable","wet","bit8","surface","climbable",
                               "stackable","window","noShoot","articleA","articleAn","articleThe",
                               "foilage","partialHue","noHouse","map","container","wearable","lightSource",
                               "animated","hoverOver","noDiagnol","armor","roof","door",
                               "stairBack","stairRight","alphaBlend","useNewArt","artUsed",
                               "bit35","noShadow","pixelBleed","playAnimOnce","bit39","bit40",
                               "bit41","bit42","bit43","bit44","bit45","bit46","bit47","bit48",
                               "bit49","bit50","bit51","bit52","bit53","bit54","bit55","bit56","bit57",
                               "bit58","bit59","bit60","bit61","bit62","bit63"]
    
    public func name() -> String {
        return TileFlagBitType.TILEFLAGNAME[self.rawValue]
    }
    
}
//==========================================================================================
// Define the protocol for a flag
protocol UOTileFlag {
    var flag:UInt64 { get set }
    func getFlagValue(forFlag bit:TileFlagBitType) -> Bool ;
    mutating func setFlagValue(forFlag bit:TileFlagBitType, state:Bool)
    var background:Bool { get set }
    var weapon:Bool { get set }
    var transparent:Bool { get set }
    var translucent:Bool { get set }
    var wall:Bool { get set }
    var damaging:Bool { get set }
    var impassable:Bool { get set }
    var wet:Bool { get set }
    var bit8:Bool { get set }
    var surface:Bool { get set }
    var climbable:Bool { get set }
    var stackable:Bool { get set }
    var window:Bool { get set }
    var noShoot:Bool { get set }
    var articleA:Bool { get set }
    var articleAn:Bool { get set }
    var articleThe:Bool { get set }
    var foilage:Bool { get set }
    var partialHue:Bool { get set }
    var noHouse:Bool { get set }
    var map:Bool { get set }
    var container:Bool { get set }
    var wearable:Bool { get set }
    var lightSource:Bool { get set }
    var animated:Bool { get set }
    var hoverOver:Bool { get set }
    var noDiagnol:Bool { get set }
    var armor:Bool { get set }
    var roof:Bool { get set }
    var door:Bool { get set }
    var stairBack:Bool { get set }
    var stairRight:Bool { get set }
    var alphaBlend:Bool { get set }
    var useNewArt:Bool { get set }
    var artUsed:Bool { get set }
    var bit35:Bool { get set }
    var noShadow:Bool { get set }
    var pixelBleed:Bool { get set }
    var playAnimOnce:Bool { get set }
    var bit39:Bool { get set }
    var bit40:Bool { get set }
    var bit41:Bool { get set }
    var bit42:Bool { get set }
    var bit43:Bool { get set }
    var bit44:Bool { get set }
    var bit45:Bool { get set }
    var bit46:Bool { get set }
    var bit47:Bool { get set }
    var bit48:Bool { get set }
    var bit49:Bool { get set }
    var bit50:Bool { get set }
    var bit51:Bool { get set }
    var bit52:Bool { get set }
    var bit53:Bool { get set }
    var bit54:Bool { get set }
    var bit55:Bool { get set }
    var bit56:Bool { get set }
    var bit57:Bool { get set }
    var bit58:Bool { get set }
    var bit59:Bool { get set }
    var bit60:Bool { get set }
    var bit61:Bool { get set }
    var bit62:Bool { get set }
    var bit63:Bool { get set }
    
}

//==========================================================================================
// Give it default implementations for the protocol
extension UOTileFlag {
    public func getFlagValue(forFlag bit:TileFlagBitType) ->Bool {
        return flag & (UInt64(1) << (bit.rawValue)) != 0
    }
    public mutating func setFlagValue(forFlag bit:TileFlagBitType, state:Bool) {
        if (state) {
            flag |= (UInt64(1) << bit.rawValue)
        }
        else {
            flag &= (~(UInt64(1) << bit.rawValue))
        }
    }
    
    public var background:Bool {
        get{
            getFlagValue(forFlag: .background)
        }
        set {
            setFlagValue(forFlag: .background,state:newValue)
        }
    }
    public var weapon:Bool {
        get{
            getFlagValue(forFlag: .weapon)
        }
        set {
            setFlagValue(forFlag: .weapon,state:newValue)
        }
    }
    public var transparent:Bool {
        get{
            getFlagValue(forFlag: .transparent)
        }
        set {
            setFlagValue(forFlag: .transparent,state:newValue)
        }
    }
    public var translucent:Bool {
        get{
            getFlagValue(forFlag: .translucent)
        }
        set {
            setFlagValue(forFlag: .translucent,state:newValue)
        }
    }
    public var wall:Bool {
        get{
            getFlagValue(forFlag: .wall)
        }
        set {
            setFlagValue(forFlag: .wall,state:newValue)
        }
    }
    public var damaging:Bool {
        get{
            getFlagValue(forFlag: .damaging)
        }
        set {
            setFlagValue(forFlag: .damaging,state:newValue)
        }
    }
    public var impassable:Bool {
        get{
            getFlagValue(forFlag: .impassable)
        }
        set {
            setFlagValue(forFlag: .impassable,state:newValue)
        }
    }
    public var wet:Bool {
        get{
            getFlagValue(forFlag: .wet)
        }
        set {
            setFlagValue(forFlag: .wet,state:newValue)
        }
    }
    public var bit8:Bool {
        get{
            getFlagValue(forFlag: .bit8)
        }
        set {
            setFlagValue(forFlag: .bit8,state:newValue)
        }
    }
    public var surface:Bool {
        get{
            getFlagValue(forFlag: .surface)
        }
        set {
            setFlagValue(forFlag: .surface,state:newValue)
        }
    }
    public var climbable:Bool {
        get{
            getFlagValue(forFlag: .climbable)
        }
        set {
            setFlagValue(forFlag: .climbable,state:newValue)
        }
    }
    public var stackable:Bool {
        get{
            getFlagValue(forFlag: .stackable)
        }
        set {
            setFlagValue(forFlag: .stackable,state:newValue)
        }
    }
    public var window:Bool {
        get{
            getFlagValue(forFlag: .window)
        }
        set {
            setFlagValue(forFlag: .window,state:newValue)
        }
    }
    public var noShoot:Bool {
        get{
            getFlagValue(forFlag: .noShoot)
        }
        set {
            setFlagValue(forFlag: .noShoot,state:newValue)
        }
    }
    public var articleA:Bool {
        get{
            getFlagValue(forFlag: .articleA)
        }
        set {
            setFlagValue(forFlag: .articleA,state:newValue)
        }
    }
    public var articleAn:Bool {
        get{
            getFlagValue(forFlag: .articleAn)
        }
        set {
            setFlagValue(forFlag: .articleAn,state:newValue)
        }
    }
    public var articleThe:Bool {
        get{
            getFlagValue(forFlag: .articleThe)
        }
        set {
            setFlagValue(forFlag: .articleThe,state:newValue)
        }
    }
    public var foilage:Bool {
        get{
            getFlagValue(forFlag: .foilage)
        }
        set {
            setFlagValue(forFlag: .foilage,state:newValue)
        }
    }
    public var partialHue:Bool {
        get{
            getFlagValue(forFlag: .partialHue)
        }
        set {
            setFlagValue(forFlag: .partialHue,state:newValue)
        }
    }
    public var noHouse:Bool {
        get{
            getFlagValue(forFlag: .noHouse)
        }
        set {
            setFlagValue(forFlag: .noHouse,state:newValue)
        }
    }
    public var map:Bool {
        get{
            getFlagValue(forFlag: .map)
        }
        set {
            setFlagValue(forFlag: .map,state:newValue)
        }
    }
    public var container:Bool {
        get{
            getFlagValue(forFlag: .container)
        }
        set {
            setFlagValue(forFlag: .container,state:newValue)
        }
    }
    public var wearable:Bool {
        get{
            getFlagValue(forFlag: .wearable)
        }
        set {
            setFlagValue(forFlag: .wearable,state:newValue)
        }
    }
    public var lightSource:Bool {
        get{
            getFlagValue(forFlag: .lightSource)
        }
        set {
            setFlagValue(forFlag: .lightSource,state:newValue)
        }
    }
    public var animated:Bool {
        get{
            getFlagValue(forFlag: .animated)
        }
        set {
            setFlagValue(forFlag: .animated,state:newValue)
        }
    }
    public var hoverOver:Bool {
        get{
            getFlagValue(forFlag: .hoverOver)
        }
        set {
            setFlagValue(forFlag: .hoverOver,state:newValue)
        }
    }
    public var noDiagnol:Bool {
        get{
            getFlagValue(forFlag: .noDiagnol)
        }
        set {
            setFlagValue(forFlag: .noDiagnol,state:newValue)
        }
    }
    public var armor:Bool {
        get{
            getFlagValue(forFlag: .armor)
        }
        set {
            setFlagValue(forFlag: .armor,state:newValue)
        }
    }
    public var roof:Bool {
        get{
            getFlagValue(forFlag: .roof)
        }
        set {
            setFlagValue(forFlag: .roof,state:newValue)
        }
    }
    public var door:Bool {
        get{
            getFlagValue(forFlag: .door)
        }
        set {
            setFlagValue(forFlag: .door,state:newValue)
        }
    }
    public var stairBack:Bool {
        get{
            getFlagValue(forFlag: .stairBack)
        }
        set {
            setFlagValue(forFlag: .stairBack,state:newValue)
        }
    }
    public var stairRight:Bool {
        get{
            getFlagValue(forFlag: .stairRight)
        }
        set {
            setFlagValue(forFlag: .stairRight,state:newValue)
        }
    }
    public var alphaBlend:Bool {
        get{
            getFlagValue(forFlag: .alphaBlend)
        }
        set {
            setFlagValue(forFlag: .alphaBlend,state:newValue)
        }
    }
    public var useNewArt:Bool {
        get{
            getFlagValue(forFlag: .useNewArt)
        }
        set {
            setFlagValue(forFlag: .useNewArt,state:newValue)
        }
    }
    public  var artUsed:Bool {
        get{
            getFlagValue(forFlag: .artUsed)
        }
        set {
            setFlagValue(forFlag: .artUsed,state:newValue)
        }
    }
    public var bit35:Bool {
        get{
            getFlagValue(forFlag: .bit35)
        }
        set {
            setFlagValue(forFlag: .bit35,state:newValue)
        }
    }
    public var noShadow:Bool {
        get{
            getFlagValue(forFlag: .noShadow)
        }
        set {
            setFlagValue(forFlag: .noShadow,state:newValue)
        }
    }
    public var pixelBleed:Bool {
        get{
            getFlagValue(forFlag: .pixelBleed)
        }
        set {
            setFlagValue(forFlag: .pixelBleed,state:newValue)
        }
    }
    public var playAnimOnce:Bool {
        get{
            getFlagValue(forFlag: .playAnimOnce)
        }
        set {
            setFlagValue(forFlag: .playAnimOnce,state:newValue)
        }
    }
    public var bit39:Bool {
        get{
            getFlagValue(forFlag: .bit39)
        }
        set {
            setFlagValue(forFlag: .bit39,state:newValue)
        }
    }
    public var bit40:Bool {
        get{
            getFlagValue(forFlag: .bit40)
        }
        set {
            setFlagValue(forFlag: .bit40,state:newValue)
        }
    }
    public var bit41:Bool {
        get{
            getFlagValue(forFlag: .bit41)
        }
        set {
            setFlagValue(forFlag: .bit41,state:newValue)
        }
    }
    public var bit42:Bool {
        get{
            getFlagValue(forFlag: .bit42)
        }
        set {
            setFlagValue(forFlag: .bit42,state:newValue)
        }
    }
    public var bit43:Bool {
        get{
            getFlagValue(forFlag: .bit43)
        }
        set {
            setFlagValue(forFlag: .bit43,state:newValue)
        }
    }
    public var bit44:Bool {
        get{
            getFlagValue(forFlag: .bit44)
        }
        set {
            setFlagValue(forFlag: .bit44,state:newValue)
        }
    }
    public var bit45:Bool {
        get{
            getFlagValue(forFlag: .bit45)
        }
        set {
            setFlagValue(forFlag: .bit45,state:newValue)
        }
    }
    public var bit46:Bool {
        get{
            getFlagValue(forFlag: .bit46)
        }
        set {
            setFlagValue(forFlag: .bit46,state:newValue)
        }
    }
    public var bit47:Bool {
        get{
            getFlagValue(forFlag: .bit47)
        }
        set {
            setFlagValue(forFlag: .bit47,state:newValue)
        }
    }
    public var bit48:Bool {
        get{
            getFlagValue(forFlag: .bit48)
        }
        set {
            setFlagValue(forFlag: .bit48,state:newValue)
        }
    }
    public var bit49:Bool {
        get{
            getFlagValue(forFlag: .bit49)
        }
        set {
            setFlagValue(forFlag: .bit49,state:newValue)
        }
    }
    public var bit50:Bool {
        get{
            getFlagValue(forFlag: .bit50)
        }
        set {
            setFlagValue(forFlag: .bit50,state:newValue)
        }
    }
    public var bit51:Bool {
        get{
            getFlagValue(forFlag: .bit51)
        }
        set {
            setFlagValue(forFlag: .bit51,state:newValue)
        }
    }
    public var bit52:Bool {
        get{
            getFlagValue(forFlag: .bit52)
        }
        set {
            setFlagValue(forFlag: .bit52,state:newValue)
        }
    }
    public var bit53:Bool {
        get{
            getFlagValue(forFlag: .bit53)
        }
        set {
            setFlagValue(forFlag: .bit53,state:newValue)
        }
    }
    public var bit54:Bool {
        get{
            getFlagValue(forFlag: .bit54)
        }
        set {
            setFlagValue(forFlag: .bit54,state:newValue)
        }
    }
    public var bit55:Bool {
        get{
            getFlagValue(forFlag: .bit55)
        }
        set {
            setFlagValue(forFlag: .bit55,state:newValue)
        }
    }
    public var bit56:Bool {
        get{
            getFlagValue(forFlag: .bit56)
        }
        set {
            setFlagValue(forFlag: .bit56,state:newValue)
        }
    }
    public var bit57:Bool {
        get{
            getFlagValue(forFlag: .bit57)
        }
        set {
            setFlagValue(forFlag: .bit57,state:newValue)
        }
    }
    public var bit58:Bool {
        get{
            getFlagValue(forFlag: .bit58)
        }
        set {
            setFlagValue(forFlag: .bit58,state:newValue)
        }
    }
    public var bit59:Bool {
        get{
            getFlagValue(forFlag: .bit59)
        }
        set {
            setFlagValue(forFlag: .bit59,state:newValue)
        }
    }
    public  var bit60:Bool {
        get{
            getFlagValue(forFlag: .bit60)
        }
        set {
            setFlagValue(forFlag: .bit60,state:newValue)
        }
    }
    public  var bit61:Bool {
        get{
            getFlagValue(forFlag: .bit61)
        }
        set {
            setFlagValue(forFlag: .bit61,state:newValue)
        }
    }
    public var bit62:Bool {
        get{
            getFlagValue(forFlag: .bit62)
        }
        set {
            setFlagValue(forFlag: .bit62,state:newValue)
        }
    }
    public var bit63:Bool {
        get{
            getFlagValue(forFlag: .bit63)
        }
        set {
            setFlagValue(forFlag: .bit63,state:newValue)
        }
    }
}
