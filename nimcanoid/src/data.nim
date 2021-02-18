import
    nimgame2/nimgame,
    nimgame2/assets,
    nimgame2/scene,
    nimgame2/types,
    nimgame2/font,
    nimgame2/truetypefont,
    nimgame2/texturegraphic,
    nimgame2/audio


const
    GameWidth* = 640
    GameHeight* = 480
    GameTitle* = "Arcanoid on nim"


var
    titleScene*, mainScene*: Scene
    defaultFont*, bigFont*: TrueTypeFont
    gfxData*: Assets[TextureGraphic]
    sfxData*: Assets[Sound]
    paddleSprites*: seq[TextureGraphic]


proc newFont(size: int, path: string = "res/fnt/outline_inverkrug.otf"): TrueTypeFont =
    result = newTrueTypeFont()
    discard result.load(path, size)


proc loadData*() =
    defaultFont = newFont(16)
    bigFont = newFont(32)
    gfxData = newAssets[TextureGraphic]("res/gfx", proc(file: string): TextureGraphic = newTextureGraphic(file))
    sfxData = newAssets[Sound]("res/sfx", proc(file: string): Sound = newSound(file))
    for i in 0..3:
        paddleSprites.add(gfxData[$i&"-paddle-sprite"])


proc freeData*() =
    defaultFont.free()
    bigFont.free()
    for graphic in gfxData.values():
        graphic.free()
    for sound in sfxData.values():
        sound.free()