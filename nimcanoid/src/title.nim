import
    nimgame2/nimgame,
    nimgame2/entity,
    nimgame2/scene,
    nimgame2/font,
    nimgame2/truetypefont,
    nimgame2/textgraphic,
    nimgame2/types,
    data


type
    TitleScene = ref object of Scene


proc newText(text: string, font: TrueTypeFont, coord: Coord): Entity =
    let textgraphic = newTextGraphic(font)
    textgraphic.setText(text)
    result = newEntity()
    result.graphic = textgraphic
    result.centrify()
    result.pos = coord

proc init*(scene: TitleScene) =
    initScene(Scene(scene))

    let title = newText(GameTitle, bigFont, (GameWidth/2, GameHeight/3))
    scene.add(title)




proc free*(scene: TitleScene) =
    discard


proc newTitleScene*(): TitleScene =
    new result, free
    init(result)


method event*(scene: TitleScene, event: Event) =
    if event.kind == KeyDown:
        game.scene = mainScene
