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


proc newText(text: string, font: TrueTypeFont, color: Color, coord: Coord): Entity =
    let textgraphic = newTextGraphic(font)
    textgraphic.setText(text)
    textgraphic.color = color
    result = newEntity()
    result.graphic = textgraphic
    result.centrify()
    result.pos = coord

proc init*(scene: TitleScene) =
    initScene(Scene(scene))

    let title = newText(GameTitle, bigFont, ColorDarkOrange, (GameWidth/2, GameHeight/3))
    scene.add(title)
    let message = newText("Press any key to continue", defaultFont, ColorWhite, (GameWidth/2, GameHeight/2))
    scene.add(message)




proc free*(scene: TitleScene) =
    discard


proc newTitleScene*(): TitleScene =
    new result, free
    init(result)


method event*(scene: TitleScene, event: Event) =
    if event.kind == KeyDown:
        game.scene = mainScene
