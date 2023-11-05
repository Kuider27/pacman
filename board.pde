enum TypeCell
{
  EMPTY, WALL, DOT, SUPER_DOT, PAC_MAN, BONUS
}

class Board
{
  TypeCell _cells[][];
  PVector _position;
  int _nbCellsX;
  int _nbCellsY;
  int _cellSize; // cells should be square
  String [] level ;
  Hero _hero ;
  PImage _pomme = loadImage("images/bonus.png");// image de bonus

  Board(PVector position, int nbCellsX, int nbCellsY, int cellSize, String partie) {
    _position = new PVector(position.x, position.y);
    _nbCellsX = nbCellsX ;
    _nbCellsY = nbCellsY ;
    _cellSize = cellSize ;
    _cells = new TypeCell[_nbCellsY][_nbCellsX] ;
    level = loadStrings(partie);

    for (int i=0; i< _nbCellsY; i++) {
      for (int j=0; j<_nbCellsX; j++) {
        String s = str(level[i].charAt(j));
        if ( s.equals("x")) _cells[i][j] = TypeCell.WALL ;
        if ( s.equals("o")) _cells[i][j] = TypeCell.DOT ;
        if ( s.equals("V")) _cells[i][j] = TypeCell.EMPTY ;
        if ( s.equals("O")) _cells[i][j] = TypeCell.SUPER_DOT ;
        if ( s.equals("P")) _cells[i][j] = TypeCell.PAC_MAN ;
      }
    }
  }

  void drawIt() {
    for (int i=0; i<_cells.length; i++ ) {
      for (int j=0; j< _cells[i].length; j++ ) {
        // le mur
        if ( _cells[i][j] == TypeCell.WALL ) {
          rectMode(CORNER);
          fill(0, 0, 255);
          noStroke();
          rect(j*_cellSize, i*_cellSize, _cellSize, _cellSize);
        }
        //Pac-Gomme
        if ( _cells[i][j] == TypeCell.DOT ) {
          ellipseMode(CORNER);
          fill(255);
          noStroke();
          ellipse((j*_cellSize)+(_cellSize*0.3), (i*_cellSize)+(_cellSize*0.3), _cellSize*0.2, _cellSize*0.2);
        }
        // Super pac-gomme
        if ( _cells[i][j] == TypeCell.SUPER_DOT ) {
          ellipseMode(CORNER);
          fill(255);
          noStroke();
          ellipse((j*_cellSize)+(_cellSize*0.25), (i*_cellSize)+(_cellSize*0.25), _cellSize*0.4, _cellSize*0.4);
        }
        // Le vide
        if ( _cells[i][j] == TypeCell.EMPTY ) {
          rectMode(CORNER);
          fill(0);
          noStroke();
          rect(j*_cellSize, i*_cellSize, _cellSize, _cellSize);
        }
        if ( _cells[i][j] == TypeCell.BONUS) {
          image(_pomme, j*CELL_SIZE, i*CELL_SIZE, CELL_SIZE, CELL_SIZE);
        }
      }
    }
    
  }
// pour avoir la position de pac de le tableau P

  PVector getPos() {
    int x=0 ;
    int y = 0 ;
    for (int i=0; i<_cells.length; i++ ) {
      for (int j=0; j< _cells[i].length; j++ ) {
        if ( _cells[i][j] == TypeCell.PAC_MAN ) {
          x = j ;
          y = i ;
        }
      }
    }
    return new PVector(x, y);
  }

// vérifier si le pac man mange tout 
void eatAll(){
 boolean b = false ;
 for (int i=0; i<_cells.length; i++ ) {
      for (int j=0; j< _cells[i].length; j++ ) {
         if(_cells[i][j] == TypeCell.DOT || _cells[i][j] == TypeCell.SUPER_DOT ) {
          b = true ;
        }
      }
    }
    if(b==true) eatAll = true ;
}
}
