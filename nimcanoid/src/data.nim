import
    nimgame2/nimgame,
    nimgame2/assets,
    nimgame2/scene,
    nimgame2/types,
    nimgame2/font,
    nimgame2/truetypefont,
    nimgame2/texturegraphic,
    nimgame2/audio,
    random


const
    GAME_WIDTH* = 640
    GAME_HEIGHT* = 480
    GAME_TITLE* = "Arcanoid on nim"
    UPDATE_INTERVAL* = 4
    FPS_LIMIT* = 60
    MIN_BALL_SPEED* = 200.0
    MAX_BALL_SPEED* = 700.0


var
    titleScene*, mainScene*: Scene
    defaultFont*, bigFont*: TrueTypeFont
    gfxData*: Assets[TextureGraphic]
    sfxData*: Assets[Sound]
    paddleSprites*: seq[TextureGraphic]
    ballSpeed*: float


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
    randomize()


proc freeData*() =
    defaultFont.free()
    bigFont.free()
    for graphic in gfxData.values():
        graphic.free()
    for sound in sfxData.values():
        sound.free()