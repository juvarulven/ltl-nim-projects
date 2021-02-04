import 
    nimgame2/assets,
    nimgame2/input,
    nimgame2/entity,
    nimgame2/nimgame,
    nimgame2/graphic,
    data


const
    SPEED = 500.0


type 
    Paddle* = ref object of Entity
        level*: range[0..4]


proc reset*(paddle: Paddle) =
    paddle.pos = (game.size.w/2, float(game.size.h - paddle.graphic.h))


proc initPaddle*(paddle: Paddle) =
    paddle.initEntity()
    paddle.tags.add("paddle")
    paddle.graphic = gfxData["paddle-0"]
    paddle.centrify()
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