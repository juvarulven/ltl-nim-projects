import
    nimgame2/nimgame,
    nimgame2/scene,
    nimgame2/types,
    nimgame2/input,
    nimgame2/settings,
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


method update*(scene: MainScene, elapsed: float) =
    scene.updateScene(elapsed)
    if ScancodeF10.pressed: colliderOutline = not colliderOutline
    if ScancodeF11.pressed: showInfo = not showInfo