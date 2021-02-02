import
    nimgame2/nimgame,
    nimgame2/assets,
    nimgame2/scene,
    nimgame2/types,
    nimgame2/font,
    nimgame2/truetypefont


const
    GameWidth* = 640
    GameHeight* = 480
    GameTitle* = "Arcanoid on nim"


var
    titleScene*, mainScene*: Scene
    defaultFont*, bigFont*: TrueTypeFont


proc newFont*(size: int, path: string = "data/fnt/outline_inverkrug.otf"): TrueTypeFont =
    result = newTrueTypeFont()
    if not result.load(path, size):
        echo("ERROR: Can't load font")


proc loadData*() =
    defaultFont = newFont(16)
    bigFont = newFont(32)


proc freeData*() =
    defaultFont.free()
    bigFont.free()
