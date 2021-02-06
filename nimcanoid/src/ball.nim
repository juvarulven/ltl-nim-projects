import
    math,
    nimgame2/assets,
    nimgame2/entity,
    nimgame2/graphic,
    nimgame2/nimgame,
    nimgame2/scene,
    nimgame2/input,
    main,
    data

const
    SPEED = 500.0


type
    Ball* = ref object of Entity
        flying: bool
        angle: float


    BounceDirection = enum
        leftBounce
        rightBounce
        upBounce
        downBounce


proc bounce(ball: Ball, direction: BounceDirection) =
    var angle = ball.angle - 180.0
    case direction
    of leftBounce:
        angle = 360.0 - angle
        if angle >= 360.0:
            angle -= 360.0
    of rightBounce:
        angle = 180.0 - angle
        if angle > 90.0:
            angle -= 180.0
        else:
            angle += 180.0
    of upBounce:
        angle = 90.0 - angle + 90.0
    of downBounce:
        angle = 270.0 - angle
        if angle == 450.0:
            angle = 0.0
        else:
            angle -= 90.0
    ball.angle = angle


proc reset*(ball: Ball) =
    ball.flying = false
    ball.angle = 210.0


    

proc initBall*(ball: Ball) =
    ball.initEntity()
    ball.graphic = gfxData["ball"]
    ball.centrify()
    ball.reset()


proc newBall*(): Ball =
    new result
    result.initBall()


proc staticUpdate(ball: Ball) =
    ##  While ball not flying
    let paddle = game.scene.find("paddle")
    ball.pos.x = paddle.pos.x
    ball.pos.y = paddle.pos.y - paddle.graphic.h/2 - ball.graphic.h/2


proc flyingUpdate(ball: Ball, elapsed: float) =
    if ball.pos.x <= 0:
        ball.bounce(leftBounce)
    if ball.pos.x >= game.size.w.float:
        ball.bounce(rightBounce)
    if ball.pos.y <= 0:
        ball.bounce(upBounce)
    if ball.pos.y >= game.size.h.float:
        ball.reset()
    ball.pos.x += SPEED * cos(degToRad(ball.angle)) * elapsed
    ball.pos.y += SPEED * sin(degToRad(ball.angle)) * elapsed


method update*(ball: Ball, elapsed: float) =
    if not ball.flying:
        if ScancodeSpace.down:
            ball.flying = true
        ball.staticUpdate()
    else:
        ball.flyingUpdate(elapsed)