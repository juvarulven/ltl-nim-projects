import
    nimgame2/nimgame,
    nimgame2/settings,
    nimgame2/types,
    data,
    title,
    main


game = newGame()
if game.init(GameWidth, GameHeight, title=GameTitle, integerScale = false):
    loadData()
    
    game.setResizable(true)
    game.minSize = (GameWidth, GameHeight)
    game.windowSize = (800, 600)
    game.centrify()

    titleScene = newTitleScene()
    mainScene = newMainScene()

    game.scene=titleScene
    game.run()
