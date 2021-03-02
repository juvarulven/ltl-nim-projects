import 
    nimgame2/assets,
    nimgame2/input,
    nimgame2/entity,
    nimgame2/nimgame,
    nimgame2/graphic,
    nimgame2/types,
    data


const
    PADDLEDIMS*: array[4, Dim] = [(64, 16), (80, 16), (96, 16), (112, 16)] ## Dimensions of paddle sprites



type 
    Paddle* = ref object of Entity
        speed*: float
        level*: range[0..3]
        cannons*: range[0..3]


proc changeSprite*(paddle: Paddle) =
    paddle.graphic = paddleSprites[paddle.level]
    paddle.initSprite(PADDLEDIMS[paddle.level])
    for i in 0..<PADDLEDIMS.len:
        discard paddle.addAnimation($i, [i], 999.0)
    paddle.centrify()
    paddle.collider = paddle.newBoxCollider((0, 4), (PADDLEDIMS[paddle.level].w, 10))
    paddle.collider.tags.add("ball")


proc reset*(paddle: Paddle) =
    paddle.level = 0
    paddle.cannons = 0
    paddle.changeSprite()
    paddle.pos = (game.size.w/2, float(game.size.h)-PADDLEDIMS[paddle.level].w/2)
    

proc initPaddle*(paddle: Paddle) =
    paddle.initEntity()
    paddle.tags.add("paddle")
    paddle.reset()


proc newPaddle*(): Paddle =
    new result
    result.initPaddle()


method update*(paddle: Paddle, elapsed: float) =
    paddle.updateEntity(elapsed)
    var movement = paddle.speed * elapsed

    if ScancodeLeft.down or ScancodeA.down:
        paddle.pos.x -= movement
    if ScancodeRight.down or ScancodeD.down:
        paddle.pos.x += movement

    paddle.pos.x = clamp(paddle.pos.x, paddle.center.x, game.size.w.float-paddle.center.x)
    paddle.play($paddle.level, 1)
