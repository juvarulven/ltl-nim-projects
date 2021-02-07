import 
    nimgame2/assets,
    nimgame2/input,
    nimgame2/entity,
    nimgame2/nimgame,
    nimgame2/graphic,
    data


const
    SPEED = 1000.0


type 
    Paddle* = ref object of Entity
        level*: range[0..4]


proc reset*(paddle: Paddle) =
    paddle.pos = (game.size.w/2, float(game.size.h - paddle.graphic.h))


proc initPaddle*(paddle: Paddle) =
    paddle.initEntity()
    paddle.graphic = gfxData["paddle-0"]
    paddle.centrify()

    paddle.tags.add("paddle")
    paddle.collider = paddle.newBoxCollider((0.0, 0.0), paddle.graphic.dim)
    paddle.collider.tags.add("ball")

    paddle.level = 0
    paddle.reset()


proc newPaddle*(): Paddle =
    new result
    result.initPaddle()


method update*(paddle: Paddle, elapsed: float) =
    var movement = SPEED * elapsed

    if ScancodeLeft.down or ScancodeA.down:
        paddle.pos.x -= movement
    if ScancodeRight.down or ScancodeD.down:
        paddle.pos.x += movement

    paddle.pos.x = clamp(paddle.pos.x, paddle.center.x, game.size.w.float-paddle.center.x)