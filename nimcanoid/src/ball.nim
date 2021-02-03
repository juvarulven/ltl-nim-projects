import
    nimgame2/assets,
    nimgame2/entity,
    nimgame2/graphic,
    nimgame2/nimgame,
    data

const
    SPEED = 500.0


type
    Ball* = ref object of Entity
    

proc initBall*(ball: Ball) =
    ball.initEntity()
    ball.graphic = gfxData["ball"]
    ball.centrify()
    ball.pos = (game.size.w/2, game.size.h/2)


proc newBall*(): Ball =
    new result
    result.initBall()