import
    nimgame2/nimgame,
    nimgame2/scene,
    nimgame2/types,
    data,
    paddle,
    ball


type
    MainScene = ref object of Scene


proc init*(scene: MainScene) =
    initScene(Scene(scene))
    let paddle = newPaddle()
    scene.add(paddle)
    let ball = newBall()
    scene.add(ball)


proc free*(scene: MainScene) =
    discard


proc newMainScene*(): MainScene =
    new result, free
    init(result)


method show*(scene: MainScene) =
    echo("Let's go")