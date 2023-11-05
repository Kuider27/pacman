class Hero { //<>//
  // position on screen
  PVector _position;
  PVector _posOffset;
  // position on board
  int _cellX, _cellY;
  // display size
  float _size;

  // move data
  PVector _direction;
  

  //pac-man's pictures
  PImage pic = loadImage("images/left.gif") ;
  PImage heart = loadImage("images/heart.png");// nombre de vie de pac-man

  boolean _bonus = false ;


  Hero(PVector position, PVector posOff, int cellX, int cellY, float size) {
    _position = new PVector (position.x, position.y );
    _direction = new PVector (0, 0 );
    _posOffset = new PVector (posOff.x, posOff.y) ;
    _cellX = cellX ;
    _cellY = cellY ;
    _size = size ;
  }

  void launchMove(PVector _dir) {
    _position.x+=_dir.x*CELL_SIZE;
    _position.y+=_dir.y*CELL_SIZE ;
  }

  void move(Board board) {
    int endTime=millis();
    if (endTime-startTime>time) {
      if (_direction.y == -1) {
        if ( board._cells[_cellY - 1][_cellX] != TypeCell.WALL ) {
          launchMove(_direction);
          if ( board._cells[_cellY - 1][_cellX] ==TypeCell.DOT) score+=10 ;
          if ( board._cells[_cellY - 1][_cellX] ==TypeCell.SUPER_DOT) {
            score+=50 ;
            temp=0 ;
            manger = 1 ;
          }
          board._cells[_cellY][_cellX] = TypeCell.EMPTY ;
          _cellY-- ;
          board._cells[_cellY][_cellX] = TypeCell.PAC_MAN ;
          pic = loadImage("images/up.gif") ;
        }
      }
      if (_direction.y == 1) {
        if ( board._cells[_cellY+1][_cellX] != TypeCell.WALL ) {
          launchMove(_direction);
          if ( board._cells[_cellY + 1][_cellX] ==TypeCell.DOT) score+=10 ;
          if ( board._cells[_cellY + 1][_cellX] ==TypeCell.SUPER_DOT) {
            score+=50 ;
            temp=0 ;
            manger = 1 ;
          }
          board._cells[_cellY][_cellX] = TypeCell.EMPTY ;
          _cellY++ ;
          board._cells[_cellY][_cellX] = TypeCell.PAC_MAN ;
          pic = loadImage("images/down.gif") ;
        }
      }

      if (_direction.x == 1) {
        if ( board._cells[_cellY][_cellX+1] != TypeCell.WALL ) {
          launchMove(_direction);
          if ( board._cells[_cellY][_cellX+1] ==TypeCell.DOT) score+=10 ;
          if ( board._cells[_cellY ][_cellX+1] ==TypeCell.SUPER_DOT){
            score+=50 ;
            temp=0 ;
            manger = 1 ;
          }
          board._cells[_cellY][_cellX] = TypeCell.EMPTY ;
          _cellX ++ ;
          board._cells[_cellY][_cellX] = TypeCell.PAC_MAN ;
          pic = loadImage("images/right.gif") ;
        }
      }
      if (_direction.x == -1) {
        if ( board._cells[_cellY][_cellX-1] != TypeCell.WALL ) {
          launchMove(_direction);
          if ( board._cells[_cellY][_cellX-1] ==TypeCell.DOT) score+=10 ;
          if ( board._cells[_cellY ][_cellX-1] ==TypeCell.SUPER_DOT){
            score+=50 ;
            temp=0 ;
            manger = 1 ;
          }
          board._cells[_cellY][_cellX] = TypeCell.EMPTY ;
          _cellX -- ;
          board._cells[_cellY][_cellX] = TypeCell.PAC_MAN ;
          pic = loadImage("images/left.gif") ;
        }
      }
      startTime = endTime;
    }
  }
  void update(Board board) {
    move(board);
    if (_cellX == 0 && _cellY == 10 ) {
      _cellX=21;
      _position.x=_cellX*CELL_SIZE  ;
      board._cells[10][22]=TypeCell.EMPTY ;
      score+=10 ;
    } else if (_cellX == 22 && _cellY == 10 ) {
      _cellX=1;
      _position.x= CELL_SIZE ;
      board._cells[10][0]=TypeCell.EMPTY ;
      score+=10 ;
    }
  }
  void Bonus(Board _board) {
    int lapsTemps=millis();
    if (lapsTemps > 20000 && lapsTemps < 26000 && _bonus==false ) {
      _board._cells[16][11]=TypeCell.BONUS ;
    } else   _board._cells[16][11]=TypeCell.EMPTY ;
    if (_board._cells[_cellY][_cellX] == TypeCell.BONUS) {
      score+=500 ;
      _bonus =true ;
    }
  }



  void drawIt() {
    image(pic, _position.x, _position.y, _size, _size);
    for (int i =0; i<_life; i++) {
      image(heart, CELL_SIZE *(i+1), height-2*CELL_SIZE, CELL_SIZE, CELL_SIZE);
    }
  }
}
