import
    nimgame2/nimgame,
    nimgame2/settings,
    nimgame2/types,
    data,
    title,
    main


game = newGame()
if game.init(GAME_WIDTH, GAME_HEIGHT, title=GAME_TITLE, integerScale = false):
    loadData()
    
    game.setResizable(true)
    updateInterval = UPDATE_INTERVAL
    fpsLimit = FPS_LIMIT
    game.minSize = (GAME_WIDTH, GAME_HEIGHT)
    game.windowSize = (800, 600)
    game.centrify()

    titleScene = newTitleScene()
    mainScene = newMainScene()

    game.scene=titleScene
    game.run()
