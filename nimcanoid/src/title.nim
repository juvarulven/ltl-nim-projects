import
    nimgame2/nimgame,
    nimgame2/scene,
    nimgame2/types,
    data


type
    TitleScene = ref object of Scene


proc init*(scene: TitleScene) =
    initScene(Scene(scene))


proc free*(scene: TitleScene) =
    discard


proc newTitleScene*(): TitleScene =
    new result, free
    init(result)


method event*(scene: TitleScene, event: Event) =
    if event.kind == KeyDown:
        game.scene = mainScene
