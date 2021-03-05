import 
    nimgame2/assets,
    nimgame2/entity,
    nimgame2/nimgame,
    nimgame2/graphic,
    nimgame2/types,
    random,
    data


const
    MODDIM*:Dim = (48, 16)


type
    ModType* = enum
        modSpeedUp, modSpeedDown, modPaddleReduse, modPaddleEnlarge, modDoubleBall, modShooter

    Modificator* = ref object of Entity
        modType*: ModType


proc newModificatorCollider(modificator: Modificator): BoxCollider =
    result = newBoxCollider(modificator, (0, 0), (float(MODDIM.w), float(MODDIM.h)))
    result.tags.add("paddle")


proc initModificator*(modificator: Modificator, coord: Coord) =
    modificator.initEntity()
    modificator.modType = ModType(rand(ord(ModType.high())))
    modificator.graphic = gfxData["modificators"]
    modificator.initSprite(MODDIM)
    modificator.addAnimation("image", [ord(modificator.modType)], 999.0)
    modificator.centrify()
    modificator.pos = (coord.x+MODDIM.w.toFloat(), coord.y+MODDIM.h.toFloat())
    modificator.tags.add("modificator")
    modificator.collider = newModificatorCollider(modificator)


proc newModificator*(coord: Coord): Modificator =
    new result
    result.initModificator(coord)

    

