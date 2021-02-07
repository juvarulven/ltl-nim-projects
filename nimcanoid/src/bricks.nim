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
    data


const
    TILEDIM = (48, 16)


type
    Brick = ref object of Entity
        hp: int


proc initBrick*(brick: Brick, coord: Coord, hp: int) =
    brick.initEntity()
    brick.hp = hp
    brick.graphic = gfxData["bricks"]
    brick.initSprite(TILEDIM)
    discard brick.addAnimation("3", [3], 999.0)
    discard brick.addAnimation("2", [2], 999.0)
    discard brick.addAnimation("1", [1], 999.0)
    brick.centrify()
    brick.pos = (coord.x + TILEDIM[0] / 2, coord.y + TILEDIM[1] / 2)
    brick.tags.add("brick")
    brick.collider = brick.newBoxCollider((0, 0), TILEDIM)
    brick.collider.tags.add("ball")


proc newBrick*(coord: Coord, hp: int): Brick =
    new result
    result.initBrick(coord, hp)


proc newBricks*(level: int): seq[Brick] =
    let filename = "res/csv/map" & $level & ".csv"
    let rawData = loadCSV[int](
    filename,
    proc(input: string): int = discard parseInt(input, result))
    let 
        left = game.size.w / 2 - rawData[0].len * TILEDIM[0] / 2
    var y = TILEDIM[1].toFloat() * 2.0
    for row in rawData:
        var x = left
        for hp in row:
            if hp == 0:
                x += TILEDIM[0].toFloat()
                continue
            result.add(newBrick((x, y), hp))
            x += TILEDIM[0].toFloat()
        y += TILEDIM[1].toFloat()
        

method update*(brick: Brick, elapsed: float) =
    brick.play($brick.hp, 1)

method onCollide(brick: Brick, target: Entity) =
    if "ball" in target.tags:
        brick.hp -= 1
    if brick.hp == 0:
        discard game.scene.del(brick)
        discard sfxData["hit"].play()