import
    nimgame2/assets,
    nimgame2/entity,
    nimgame2/graphic,
    nimgame2/nimgame,
    nimgame2/scene,
    main,
    data

const
    SPEED = 500.0


type
    Ball* = ref object of Entity
        flying: bool


proc reset*(ball: Ball) =
    ball.flying = false

    

proc initBall*(ball: Ball) =
    ball.initEntity()
    ball.graphic = gfxData["ball"]
    ball.centrify()
    ball.reset()


proc newBall*(): Ball =
    new result
    result.initBall()


proc staticUpdate(ball: Ball) =
    let paddle = game.scene.find("paddle")
    ball.pos.x = paddle.pos.x
    ball.pos.y = paddle.pos.y - paddle.graphic.h/2 - ball.graphic.h/2

method update*(ball: Ball, elapsed: float) =
    if not ball.flying:
        ball.staticUpdate()