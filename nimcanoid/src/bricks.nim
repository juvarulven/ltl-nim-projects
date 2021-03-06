import
    parseutils,
    streams,
    nimgame2/nimgame,
    nimgame2/assets,
    nimgame2/entity,
    nimgame2/types,
    nimgame2/utils,
    nimgame2/scene,
    nimgame2/audio,
    data,
    modificators


const
    BRICKDIM*: Dim = (48, 16)

type 
    Brick* = ref object of Entity
        hp: int


proc newBrickCollider(brick: Brick): BoxCollider =
    result = newBoxCollider(brick, (1, 1), (float(BRICKDIM.w-2), float(BRICKDIM.h-2)))
    result.tags.add("ball")


proc initBrick*(brick: Brick, coord: Coord, hp: int) =
    brick.initEntity()
    brick.hp = hp
    brick.graphic = gfxData["bricks"]
    brick.initSprite(BRICKDIM)
    for i in 0..3:
        discard brick.addAnimation($i, [i], 999.0)
    brick.centrify()
    brick.pos = (coord.x+BRICKDIM.w/2, coord.y+BRICKDIM.h/2)
    brick.tags.add("brick")
    brick.collider = newBrickCollider(brick)


proc newBrick*(coord: Coord, hp: int): Brick =
    new result
    result.initBrick(coord, hp)


proc newBricks*(level: int): seq[Brick] =
    let filename = "res/csv/map" & $level & ".csv"
    let rawData = loadCSV[int](
    filename,
    proc(input: string): int = discard parseInt(input, result))
    let 
        left = game.size.w / 2 - rawData[0].len * BRICKDIM.w / 2
    var y = BRICKDIM.h.toFloat() * 2.0
    for row in rawData:
        var x = left
        for hp in row:
            if hp == 0:
                x += BRICKDIM.w.toFloat()
                continue
            result.add(newBrick((x, y), hp))
            x += BRICKDIM.w.toFloat()
        y += BRICKDIM.h.toFloat()
        

method update*(brick: Brick, elapsed: float) =
    brick.play($brick.hp, 1)


method onCollide(brick: Brick, target: Entity) =
    if "ball" in target.tags:
        brick.hp -= 1
    if brick.hp < 0:
        game.scene.add(newModificator(brick.pos))
        discard game.scene.del(brick)
        discard sfxData["hit"].play()