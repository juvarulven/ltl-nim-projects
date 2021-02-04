import
    nimgame2/nimgame,
    nimgame2/scene,
    nimgame2/types,
    data,
    paddle,
    ball


type
    MainScene = ref object of Scene
        paddle: Paddle
        ball: Ball


proc init*(scene: MainScene) =
    initScene(Scene(scene))
    scene.paddle = newPaddle()
    scene.add(scene.paddle)
    scene.ball = newBall()
    scene.add(scene.ball)


proc free*(scene: MainScene) =
    discard


proc newMainScene*(): MainScene =
    new result, free
    init(result)


method show*(scene: MainScene) =
    echo("Let's go")
    scene.paddle.reset()
    scene.ball.reset()