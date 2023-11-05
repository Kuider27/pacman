class Game
{
  Board _board;
  Hero _hero;
  Menu _menu = new Menu() ;
  Fantome _pokey ;
  Fantome _inky ;
  Fantome _blinky ;
  Fantome _pinky ;

  String _levelName;

  Game(String boardPath) {
    PVector boardPosition = new PVector(width/20, height/20);
    _board = new Board (boardPosition, 23, 22, CELL_SIZE, boardPath );
    PVector pos = _board.getPos();
    _hero = new Hero(new PVector(pos.x*CELL_SIZE, pos.y*CELL_SIZE), new PVector(pos.x*CELL_SIZE, pos.y*CELL_SIZE), (int) pos.x, (int)pos.y, CELL_SIZE);
    _pokey = new Fantome (new PVector(10*CELL_SIZE, 10*CELL_SIZE), 10, 10, CELL_SIZE, "images/ghost.gif");
    _inky =  new Fantome (new PVector(9*CELL_SIZE, 10*CELL_SIZE), 9, 10, CELL_SIZE, "images/inky.png");
    _blinky =  new Fantome (new PVector(9*CELL_SIZE, 10*CELL_SIZE), 9, 10, CELL_SIZE, "images/blinky.png");
    _pinky = new Fantome (new PVector(10*CELL_SIZE, 10*CELL_SIZE), 10, 10, CELL_SIZE, "images/pinky.png");
    eatAll = false ;
  }

  void update() {
    _hero.update(_board);
    _hero.Bonus(_board);
    _pokey.movePokey(_board, _hero);
    _pinky.movePokey(_board, _hero);
    _inky.moveInky(_board, _hero);
    _pokey.update();
    _pinky.update();
    _blinky.moveBlinky(_board, _hero);
    _pokey.frightMod( );
    _inky.frightMod( );
    _blinky.frightMod( );
    _pinky.frightMod( );
    _menu.Score();
  }

  void drawIt() {
    if (_menu._draw == false ) {
      _board.drawIt();
      _hero.drawIt();
      _pokey.drawIt();
      _inky.drawIt();
      _blinky.drawIt();
      _pinky.drawIt();
    } else {
      _menu.drawIt() ;
      _menu.cursorForm();
      _menu.exitGame();
      _menu.Restart();
      _menu.saveGame(_board);
      _menu.loadGame();
    }
  }
  //Si le joueur a 10000 pts il va gagné une vie 
  void addLife() {
    if (score > 10000 && !addLife) {
      _life ++ ;
      addLife = true ;
    }
  }


  void handleKey(int k) {
    if ((key == CODED && keyCode == UP ) || (k == int('Z'))) {
      _hero._direction.x = 0 ;
      _hero._direction.y = -1 ;
    } else if ((key == CODED && keyCode == DOWN ) || (k == int('S'))) {
      _hero._direction.x = 0;
      _hero._direction.y = 1 ;
    } else if ((key == CODED && keyCode == RIGHT ) || (k == int('D'))) {
      _hero._direction.x = 1 ;
      _hero._direction.y = 0 ;
    } else if ((key == CODED && keyCode == LEFT ) || (k == int('Q'))) {
      _hero._direction.x = -1 ;
      _hero._direction.y = 0 ;
    }
    //la touche echap
    if (key == 27 ) {
      _menu._draw = true ;
      key=0;
    } else  _menu._draw = false ;
  }
}
