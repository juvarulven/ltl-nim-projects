import
    math,
    nimgame2/assets,
    nimgame2/entity,
    nimgame2/graphic,
    nimgame2/nimgame,
    nimgame2/scene,
    nimgame2/input,
    nimgame2/audio,
    nimgame2/types,
    data,
    bricks,
    paddle


const
    MIN_SPEED = 500.0
 #   MAX_SPEED = 1250.0
    ANGLE_LIMITATION = (degToRad(20.0), degToRad(160.0))
    START_ANGLE = degToRad(240.0)
    ANGLE_STEP = degToRad(10.0)    
#    CLONE_ANGLE = degToRad(15.0)

type
    Ball* = ref object of Entity
        flying: bool
        vector: Coord
        speed: float


    BounceDirection = enum
        verticalBounce
        horisontalBounce
    
    Limitation = tuple
        f: float
        t: float


proc bounce(ball: Ball, direction: BounceDirection) =
    case direction
    of verticalBounce:
        ball.vector.x = -ball.vector.x
    of horisontalBounce:
        ball.vector.y = -ball.vector.y



proc reset*(ball: Ball) =
    ball.flying = false
    ball.vector = (cos(START_ANGLE), sin(START_ANGLE))
    ball.speed = MIN_SPEED
    

proc initBall*(ball: Ball) =
    ball.initEntity()
    ball.graphic = gfxData["ball"]
    ball.centrify()
    ball.tags.add("ball")
    ball.collider = ball.newCircleCollider((0.0, 0.0), ball.graphic.h/2)
    ball.collider.tags.add(@["paddle", "brick"])
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
    ##  While ball flying
    if ball.pos.x - ball.graphic.w / 2 <= 0 or ball.pos.x + ball.graphic.w / 2 >= game.size.w.float:
        ball.bounce(verticalBounce)
        discard sfxData["bounce"].play()
    if ball.pos.y - ball.graphic.h / 2 <= 0:
        ball.bounce(horisontalBounce)
        discard sfxData["bounce"].play()
    if ball.pos.y >= game.size.h.float:
        ball.reset()
    else:
        ball.pos += ball.speed * ball.vector * elapsed
   


method update*(ball: Ball, elapsed: float) =
    if not ball.flying:
        if ScancodeSpace.down:
            ball.flying = true
        ball.staticUpdate()
    else:
        ball.flyingUpdate(elapsed)


proc changeAngle(ball: Ball, angle: float, limit: Limitation = (0.0, 360.0)) =
    var resultAngle: float
    let currentAngle = arccos(ball.vector.x)
    resultAngle = currentAngle + angle
    if limit == (0.0, 360.0):
        resultAngle = currentAngle + angle
        if resultAngle >= 360.0:
            resultAngle -= 360.0
        elif resultAngle < 0:
            resultAngle = 360.0 - resultAngle
    else:
        resultAngle = clamp(resultAngle, limit.f, limit.t)
    ball.vector = (cos(resultAngle), sin(resultAngle))


proc paddleBounce(ball: Ball, target: Paddle) =
    if ball.pos.x < target.pos.x - target.graphic.w/4: # hit left fourth
        ball.changeAngle(ANGLE_STEP, ANGLE_LIMITATION)
    elif ball.pos.x > target.pos.x + target.graphic.w/4: # hit right fourth
        ball.changeAngle(-ANGLE_STEP, ANGLE_LIMITATION)
    ball.bounce(horisontalBounce) 
    discard sfxData["bounce"].play() 


proc brickBounce(ball: Ball, target: Brick) =
    var  
        ballXDistance = abs(target.pos.x-ball.pos.x) - BRICKDIM.w/2
        ballYDistance = abs(target.pos.y-ball.pos.y) - BRICKDIM.h/2
    if ballXDistance >= ballYDistance:
        ball.bounce(verticalBounce)
    else:
        ball.bounce(horisontalBounce)
    discard sfxData["bounce"].play()
    
method onCollide*(ball: Ball, target: Brick) =
    ball.brickBounce(target)

method onCollide*(ball: Ball, target: Paddle) =
    ball.paddleBounce(target)
