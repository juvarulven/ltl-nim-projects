import
    nimgame2/nimgame,
    nimgame2/assets,
    nimgame2/scene,
    nimgame2/types


const
    GameWidth* = 640
    GameHeight* = 480
    GameTitle* = "Arcanoid on nim"


var
    titleScene*, mainScene*: Scene
    