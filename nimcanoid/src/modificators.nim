import 
    nimgame2/assets,
    nimgame2/entity,
    nimgame2/nimgame,
    nimgame2/graphic,
    nimgame2/types,
    nimgame2/scene,
    random,
    data,
    paddle


const
    MODDIM*:Dim = (48, 16)
    MODSPEED* = 100.0


type
    ModType* = enum
        modSpeedUp, modSpeedDown, modPaddleReduce, modPaddleEnlarge, modDoubleBall, modShooter

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
    discard modificator.addAnimation("image", [ord(modificator.modType)], 999.0)
    modificator.centrify()
    modificator.pos = (coord.x, coord.y+MODDIM.h.toFloat())
    modificator.tags.add("modificator")
    modificator.collider = newModificatorCollider(modificator)


proc newModificator*(coord: Coord): Modificator =
    new result
    result.initModificator(coord)


proc applyModificator(modificator: Modificator, paddle: Paddle) =
    case modificator.modType
    of modPaddleEnlarge: 
        paddle.enlarge()
    of modPaddleReduce: 
        paddle.reduce()
    of modSpeedUp:
        ballSpeed += 100.0
        if ballSpeed > MAX_BALL_SPEED: ballSpeed = MAX_BALL_SPEED
    of modSpeedDown:
        ballSpeed -= 100.0
        if ballSpeed < MIN_BALL_SPEED: ballSpeed = MIN_BALL_SPEED
    else: echo(modificator.modType)

    
method update*(modificator: Modificator, elapsed: float) =
    modificator.updateEntity(elapsed)
    modificator.pos.y += MODSPEED * elapsed
    if modificator.pos.y > game.size.h.float:
        discard game.scene.del(modificator)
    modificator.play("image", 1)

method onCollide*(modificator: Modificator, paddle: Paddle) =
    applyModificator(modificator, paddle)
    discard game.scene.del(modificator)