class Fantome {
  // position on screen
  PVector _position;
  // position on board
  int _cellX, _cellY;
  // display size
  float _size;
  // move data
  PVector _direction;
  PImage _ghost ;
  // pour gérer le déplacement en fonction de temps
  int debut = 0 ;
  int temps = 300 ;
  
  String _dirInky ="null" ;// direction suivante
  int _dirInk ;//direction de inky 
  
  //ghoste Mode
  boolean _chase  ;
  boolean _frightened  ;

  // coordonnée de départ
  int _cellXi, _cellYi;

  Fantome (PVector position, int cellX, int cellY, float size, String path) {
    _position = new PVector(position.x, position.y);
    _cellX = cellX ;
    _cellY = cellY ;
    _size = size ;
    _direction = new PVector(0, 0);
    _ghost = loadImage(path) ;
    _chase = true ;
    _frightened = false ;

    _cellXi = cellX ;
    _cellYi = cellY ;
  }

  void launchMove(PVector _dir) {

    _position.x+=_dir.x*CELL_SIZE;
    _position.y+=_dir.y*CELL_SIZE ;
  }
  void movePokey(Board _board, Hero _hero) {
    int fin = millis() ;
    if (fin-debut > temps ) {
      if (_position.x== 10*CELL_SIZE && _position.y==10*CELL_SIZE) {
        launchMove(new PVector(1, 0));
        _cellX++;
      } else if (_position.x== 11*CELL_SIZE && _position.y==10*CELL_SIZE) {
        launchMove(new PVector(0, -1));
        _cellY--;
      } else if (_position.x== 11*CELL_SIZE && _position.y==9*CELL_SIZE) {
        launchMove(new PVector(0, -1));
        _cellY--;
      }
      if (int(random(0, 2)) == 0) _direction.x= int(random(-2, 2));
      else _direction.y= int(random(-2, 2));

      if (_direction.x ==1 && _board._cells[_cellY][_cellX+1] != TypeCell.WALL) {
        launchMove(new PVector(1, 0));
        _cellX++;
      }
      if (_direction.x ==-1 && _board._cells[_cellY][_cellX-1] != TypeCell.WALL) {
        launchMove(new PVector(-1, 0));
        _cellX--;
      }
      if (_direction.y==1 && _board._cells[_cellY+1][_cellX] != TypeCell.WALL) {
        launchMove(new PVector(0, 1));
        _cellY++;
      }
      if (_direction.y==-1 && _board._cells[_cellY-1][_cellX] != TypeCell.WALL) {
        launchMove(new PVector(0, -1));
        _cellY--;
      }
      debut = fin ;
    }
    crossPacman(_hero);
  }
  /***********************/
  void moveInky(Board _board, Hero _hero) {
    int fin = millis() ;
    if (fin - debut > temps ) {
      if (_position.x== 9*CELL_SIZE && _position.y==10*CELL_SIZE) {
        launchMove(new PVector(1, 0));
        _cellX++;
      }
      if (_position.x== 10*CELL_SIZE && _position.y==10*CELL_SIZE) {
        launchMove(new PVector(1, 0));
        _cellX++;
      }
      if (_position.x== 11*CELL_SIZE && _position.y==10*CELL_SIZE) {
        launchMove(new PVector(1, 0));
        _cellX++;
      }
      if (_position.x== 12*CELL_SIZE && _position.y==10*CELL_SIZE) {
        launchMove(new PVector(0, -1));
        _cellY--;
      }
      if (_position.x== 12*CELL_SIZE && _position.y==9*CELL_SIZE) {
        launchMove(new PVector(0, -1));
        _cellY--;
      }
      if (_dirInky.equals("null")) {
        _dirInk = int(random(0, 4)) ;
      }
      if (_dirInk ==0   ) {
        if (_board._cells[_cellY][_cellX+1] != TypeCell.WALL) {
          launchMove(new PVector(1, 0));
          _cellX++;
          _dirInky="right" ;
        } else  _dirInky="null" ;
      }
      if (_dirInk == 1 ) {
        if (_board._cells[_cellY][_cellX-1] != TypeCell.WALL) {
          launchMove(new PVector(-1, 0));
          _cellX--;
          _dirInky="left" ;
        } else  _dirInky="null" ;
      }
      if (_dirInk == 2 ) {
        if (_board._cells[_cellY+1][_cellX] != TypeCell.WALL) {
          launchMove(new PVector(0, 1));
          _cellY++;
          _dirInky="down" ;
        } else  _dirInky="null" ;
      }
      if (_dirInk == 3 ) {
        if (_board._cells[_cellY-1][_cellX] != TypeCell.WALL) {
          launchMove(new PVector(0, -1));
          _cellY--;
          _dirInky="up" ;
        } else  _dirInky="null" ;
      }
      debut = fin ;
    }
    crossPacman(_hero);
  }
  /***********************************************/
  void crossPacman(Hero _hero) {
    if (_position.x == _hero._position.x && _position.y == _hero._position.y ) {
      if (! _frightened) {
        _life --;
        if (_life==0)_gameOver = true ;
        else game = new Game("levels/level1_1.txt") ;
      }
      if (_frightened) {
        returnHome();
        score += manger*200 ;
        manger++;
        _frightened = false ;
        _chase = true ;
      }
    }
  }

  /*****************Blinky*****************************/
  void moveBlinky(Board _board, Hero _hero) {
    
    float upNeighbor ;
    float downNeighbor ;
    float leftNeighbor ;
    float rightNeighbor ;
    int fin = millis() ;
    if (fin - debut > temps ) {
      if (_position.x== 9*CELL_SIZE && _position.y==10*CELL_SIZE) {
        launchMove(new PVector(1, 0));
        _cellX++;
      }
      if (_position.x== 10*CELL_SIZE && _position.y==10*CELL_SIZE) {
        launchMove(new PVector(1, 0));
        _cellX++;
      }
      if (_position.x== 11*CELL_SIZE && _position.y==10*CELL_SIZE) {
        launchMove(new PVector(1, 0));
        _cellX++;
      }
      if (_position.x== 12*CELL_SIZE && _position.y==10*CELL_SIZE) {
        launchMove(new PVector(0, -1));
        _cellY--;
      }
      if (_position.x== 12*CELL_SIZE && _position.y==9*CELL_SIZE) {
        launchMove(new PVector(0, -1));
        _cellY--;
      }
      if (_position.x== 11*CELL_SIZE && _position.y==8*CELL_SIZE) {
        launchMove(new PVector(1, 0));
        _cellX++;
      }

      if (_hero._position.y > _position.y) {
        if (_board._cells[_cellY+1][_cellX] !=TypeCell.WALL) {
          if (_board._cells[_cellY][_cellX+1] !=TypeCell.WALL && _board._cells[_cellY][_cellX-1] !=TypeCell.WALL) {
            downNeighbor = dist(_position.x, _position.y+CELL_SIZE, _hero._position.x, _hero._position.y);
            leftNeighbor = dist(_position.x-CELL_SIZE, _position.y, _hero._position.x, _hero._position.y);
            rightNeighbor= dist(_position.x+CELL_SIZE, _position.y, _hero._position.x, _hero._position.y);
            float min = min(downNeighbor, leftNeighbor, rightNeighbor);
            if (rightNeighbor ==min) {
              launchMove(new PVector(1, 0));
              _cellX++;
            } else if (leftNeighbor ==min) {
              launchMove(new PVector(-1, 0));
              _cellX--;
            } else {
              launchMove(new PVector(0, 1));
              _cellY++;
            }
          } else if (_board._cells[_cellY][_cellX+1] !=TypeCell.WALL && _board._cells[_cellY][_cellX-1] ==TypeCell.WALL ) {
            downNeighbor = dist(_position.x, _position.y+CELL_SIZE, _hero._position.x, _hero._position.y);
            rightNeighbor= dist(_position.x+CELL_SIZE, _position.y, _hero._position.x, _hero._position.y);
            float min = min(downNeighbor, rightNeighbor);
            if (rightNeighbor ==min) {
              launchMove(new PVector(1, 0));
              _cellX++;
            } else {
              launchMove(new PVector(0, 1));
              _cellY++;
            }
          } else if (_board._cells[_cellY][_cellX-1] !=TypeCell.WALL && _board._cells[_cellY][_cellX+1] ==TypeCell.WALL) {
            downNeighbor = dist(_position.x, _position.y+CELL_SIZE, _hero._position.x, _hero._position.y);
            leftNeighbor = dist(_position.x-CELL_SIZE, _position.y, _hero._position.x, _hero._position.y);
            float min = min(downNeighbor, leftNeighbor);
            if (leftNeighbor ==min) {
              launchMove(new PVector(-1, 0));
              _cellX--;
            } else {
              launchMove(new PVector(0, 1));
              _cellY++;
            }
          } else {
            launchMove(new PVector(0, 1));
            _cellY++;
          }
        } else if (_board._cells[_cellY][_cellX+1] !=TypeCell.WALL && _board._cells[_cellY][_cellX-1] !=TypeCell.WALL) {
          leftNeighbor = dist(_position.x-CELL_SIZE, _position.y, _hero._position.x, _hero._position.y);
          rightNeighbor= dist(_position.x+CELL_SIZE, _position.y, _hero._position.x, _hero._position.y);
          float min = min(leftNeighbor, rightNeighbor);
          if (rightNeighbor ==min) {
            launchMove(new PVector(1, 0));
            _cellX++;
          } else {
            launchMove(new PVector(-1, 0));
            _cellX--;
          }
        } else if (_board._cells[_cellY][_cellX+1] !=TypeCell.WALL && _board._cells[_cellY][_cellX-1] ==TypeCell.WALL) {
          launchMove(new PVector(1, 0));
          _cellX++;
        } else if (_board._cells[_cellY][_cellX-1] !=TypeCell.WALL && _board._cells[_cellY][_cellX+1] ==TypeCell.WALL) {
          launchMove(new PVector(-1, 0));
          _cellX--;
        }
      }

      if (_hero._position.y < _position.y) {
        if (_board._cells[_cellY-1][_cellX] !=TypeCell.WALL) {
          if (_board._cells[_cellY][_cellX+1] !=TypeCell.WALL && _board._cells[_cellY][_cellX-1] !=TypeCell.WALL) {
            upNeighbor = dist(_position.x, _position.y-CELL_SIZE, _hero._position.x, _hero._position.y);
            leftNeighbor = dist(_position.x-CELL_SIZE, _position.y, _hero._position.x, _hero._position.y);
            rightNeighbor= dist(_position.x+CELL_SIZE, _position.y, _hero._position.x, _hero._position.y);
            float min = min(upNeighbor, leftNeighbor, rightNeighbor);
            if (rightNeighbor ==min) {
              launchMove(new PVector(1, 0));
              _cellX++;
            } else if (leftNeighbor ==min) {
              launchMove(new PVector(-1, 0));
              _cellX--;
            } else {
              launchMove(new PVector(0, -1));
              _cellY--;
            }
          } else if (_board._cells[_cellY][_cellX+1] !=TypeCell.WALL && _board._cells[_cellY][_cellX-1] ==TypeCell.WALL) {
            upNeighbor = dist(_position.x, _position.y-CELL_SIZE, _hero._position.x, _hero._position.y);
            rightNeighbor= dist(_position.x+CELL_SIZE, _position.y, _hero._position.x, _hero._position.y);
            float min = min(upNeighbor, rightNeighbor);
            if (rightNeighbor ==min) {
              launchMove(new PVector(1, 0));
              _cellX++;
            } else {
              launchMove(new PVector(0, -1));
              _cellY--;
            }
          } else if (_board._cells[_cellY][_cellX-1] !=TypeCell.WALL && _board._cells[_cellY][_cellX+1] ==TypeCell.WALL) {
            upNeighbor = dist(_position.x, _position.y-CELL_SIZE, _hero._position.x, _hero._position.y);
            leftNeighbor = dist(_position.x-CELL_SIZE, _position.y, _hero._position.x, _hero._position.y);
            float min = min(upNeighbor, leftNeighbor);
            if (leftNeighbor ==min) {
              launchMove(new PVector(-1, 0));
              _cellX--;
            } else {
              launchMove(new PVector(0, -1));
              _cellY--;
            }
          } else {
            launchMove(new PVector(0, -1));
            _cellY--;
          }
        } else if (_board._cells[_cellY][_cellX+1] !=TypeCell.WALL && _board._cells[_cellY][_cellX-1] !=TypeCell.WALL) {
          leftNeighbor = dist(_position.x-CELL_SIZE, _position.y, _hero._position.x, _hero._position.y);
          rightNeighbor= dist(_position.x+CELL_SIZE, _position.y, _hero._position.x, _hero._position.y);
          float min = min(leftNeighbor, rightNeighbor);
          if (rightNeighbor ==min) {
            launchMove(new PVector(1, 0));
            _cellX++;
          } else {
            launchMove(new PVector(-1, 0));
            _cellX--;
          }
        } else if (_board._cells[_cellY][_cellX+1] !=TypeCell.WALL &&_board._cells[_cellY][_cellX-1] ==TypeCell.WALL ) {
          launchMove(new PVector(1, 0));
          _cellX++;
        } else if (_board._cells[_cellY][_cellX-1] !=TypeCell.WALL && _board._cells[_cellY][_cellX+1] ==TypeCell.WALL) {
          launchMove(new PVector(-1, 0));
          _cellX--;
        }
      }



      if (_hero._position.y == _position.y) {

        if (_hero._position.x>_position.x) {
          if (_board._cells[_cellY][_cellX+1] != TypeCell.WALL) {
            launchMove(new PVector(1, 0));
            _cellX ++;
            // hna yg3
          } else if (_board._cells[_cellY][_cellX-1] != TypeCell.WALL) {
            launchMove(new PVector(-1, 0));
            _cellX --;
          } else if (_board._cells[_cellY+1][_cellX] != TypeCell.WALL && _board._cells[_cellY-1][_cellX] != TypeCell.WALL) {
            upNeighbor = dist(_position.x, _position.y+CELL_SIZE, _hero._position.x, _hero._position.y);
            downNeighbor = dist(_position.x, _position.y-CELL_SIZE, _hero._position.x, _hero._position.y);
            float min = min (upNeighbor, downNeighbor);
            if (min == upNeighbor) {
              //ici il va laguer monter-descendre
              launchMove(new PVector (0, 1));
              _cellY++ ;
            } else {
              launchMove(new PVector (0, -1));
              _cellY-- ;
            }
          } else if (_board._cells[_cellY+1][_cellX] != TypeCell.WALL) {
            launchMove(new PVector (0, 1));
            _cellY++ ;
          } else {
            launchMove(new PVector (0, -1));
            _cellY-- ;
          }
        } else {

          if (_board._cells[_cellY][_cellX-1] !=TypeCell.WALL) {
            launchMove(new PVector(-1, 0));
            _cellX--;
          } else if (_board._cells[_cellY][_cellX+1] !=TypeCell.WALL) {
            launchMove(new PVector(1, 0));
            _cellX++;
          } else if (_board._cells[_cellY+1][_cellX] != TypeCell.WALL && _board._cells[_cellY-1][_cellX] != TypeCell.WALL) {
            upNeighbor = dist(_position.x, _position.y+CELL_SIZE, _hero._position.x, _hero._position.y);
            downNeighbor = dist(_position.x, _position.y-CELL_SIZE, _hero._position.x, _hero._position.y);
            float min = min (upNeighbor, downNeighbor);
            if (min == upNeighbor) {
              //ici il va laguer monter-descendre
              launchMove(new PVector (0, 1));
              _cellY++ ;
            } else {
              launchMove(new PVector (0, -1));
              _cellY-- ;
            }
          } else if (_board._cells[_cellY+1][_cellX] != TypeCell.WALL) {
            launchMove(new PVector (0, 1));
            _cellY++ ;
          } else {
            launchMove(new PVector (0, -1));
            _cellY-- ;
          }
        }
      }

      debut=fin ;
    }
    crossPacman(_hero);
  }

  // lorsque pacman mange fantome il va revenir chez lui 
  void returnHome() {
    _cellX= _cellXi;
    _cellY = _cellYi ;
    _position.x = _cellX * CELL_SIZE;
    _position.y = _cellY * CELL_SIZE ;
  }

  //Lorsque le fantomee perce le bordure 
  void update() {
    if (_cellX == 0 && _cellY == 10 ) {
      _cellX=21;
      _position.x=_cellX*CELL_SIZE  ;
    } else if (_cellX == 22 && _cellY == 10 ) {
      _cellX=1;
      _position.x= _cellX*CELL_SIZE ;
    }
  }

  void frightMod() {
    if (temp < 1000) {
      _frightened = true ;
      _chase = false ;
    } else {
      _frightened = false ;
      _chase = true ;
    }
    temp+=01 ;
  }

  void drawIt() {
    if (_frightened) {
      image( loadImage("images/peur.png"), _position.x, _position.y, _size, _size);
    } else image(_ghost, _position.x, _position.y, _size, _size);
  }
}
