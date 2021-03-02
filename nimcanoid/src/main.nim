import
    nimgame2/nimgame,
    nimgame2/scene,
    nimgame2/types,
    nimgame2/input,
    nimgame2/settings,
    nimgame2/tilemap,
    nimgame2/entity,
    data,
    paddle,
    ball,
    bricks


type
    MainScene = ref object of Scene
        paddle: Paddle
        ball: Ball


proc initMainScene*(scene: MainScene) =
    initScene(Scene(scene))
    scene.paddle = newPaddle()
    scene.add(scene.paddle)
    scene.ball = newBall()
    scene.add(scene.ball)
    for brick in newBricks(0):
        scene.add(brick)


proc free*(scene: MainScene) =
    discard


proc newMainScene*(): MainScene =
    new result, free
    initMainScene(result)


method show*(scene: MainScene) =
    echo("Let's go")
    scene.paddle.reset()
    scene.ball.reset()
    echo(updateInterval)


method update*(scene: MainScene, elapsed: float) =
    scene.updateScene(elapsed)
    scene.paddle.speed = scene.ball.speed + 100.0
    if ScancodeF10.pressed: colliderOutline = not colliderOutline
    if ScancodeF11.pressed: showInfo = not showInfo
