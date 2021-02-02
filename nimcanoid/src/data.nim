import
    nimgame2/nimgame,
    nimgame2/assets,
    nimgame2/scene,
    nimgame2/types,
    nimgame2/font,
    nimgame2/truetypefont,
    nimgame2/texturegraphic


const
    GameWidth* = 640
    GameHeight* = 480
    GameTitle* = "Arcanoid on nim"


var
    titleScene*, mainScene*: Scene
    defaultFont*, bigFont*: TrueTypeFont
    gfxData*: Assets[TextureGraphic]


proc newFont(size: int, path: string = "res/fnt/outline_inverkrug.otf"): TrueTypeFont =
    result = newTrueTypeFont()
    discard result.load(path, size)


proc loadData*() =
    defaultFont = newFont(16)
    bigFont = newFont(32)
    gfxData = newAssets[TextureGraphic]("res/gfx", proc(file: string): TextureGraphic = newTextureGraphic(file))


proc freeData*() =
    defaultFont.free()
    bigFont.free()
    for graphic in gfxData.values():
        graphic.free()
