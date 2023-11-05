class Menu {
  boolean _draw ;
  PFont _text ;
  boolean restart = false ;//restart the game
  Menu() {
    _draw = false ;///dessiner le menu
    _text = createFont("Arial", 12, true);
  }

  void drawIt() {
    fill(0, 200);
    rectMode(CORNER);
    rect(0, 0, width, height);

    rectMode(CENTER);
    fill(127, 230);
    rect(width/2, CELL_SIZE*4, CELL_SIZE*10, CELL_SIZE*2.5);
    fill(0);
    text("  Recommencer la partie", CELL_SIZE*7, CELL_SIZE*4);

    fill(127, 230);
    rect(width/2, CELL_SIZE*8, CELL_SIZE*10, CELL_SIZE*2.5);
    fill(0);
    text("   Sauvegarder la partie", CELL_SIZE*7, CELL_SIZE*8);

    fill(127, 230);
    rect(width/2, CELL_SIZE*12, CELL_SIZE*10, CELL_SIZE*2.5);
    fill(0);
    text("     Charger une partie ", CELL_SIZE*7, CELL_SIZE*12);

    fill(127, 230);
    rect(width/2, CELL_SIZE*16, CELL_SIZE*10, CELL_SIZE*2.5);
    fill(0);
    text("Consulter milleurs scores", CELL_SIZE*7, CELL_SIZE*16);

    fill(127, 230);
    rect(width/2, CELL_SIZE*20, CELL_SIZE*10, CELL_SIZE*2.5);
    fill(0);
    text("           Quitter le jeu", CELL_SIZE*7, CELL_SIZE*20);
  }


  boolean inTarget(PVector centerPos, float largeur, float hauteur ) {
    return (((mouseX>=centerPos.x-largeur/2)&&(mouseX<=centerPos.x+largeur/2))&&((mouseY>=centerPos.y-hauteur/2)&&(mouseY<=centerPos.y+hauteur/2)));
  }

  void Restart() {
    if (mouseButton == LEFT && mousePressed==true && inTarget(new PVector(width/2, CELL_SIZE*4), CELL_SIZE*10, CELL_SIZE*2.5)) {
      cursor(ARROW) ;
      game = new Game("levels/level1_1.txt") ;
      score = 0 ;
      _draw=false ;
    }
  }


  void saveGame(Board _board) {
    if (mouseButton == LEFT && mousePressed==true && inTarget(new PVector(width/2, CELL_SIZE*8), CELL_SIZE*10, CELL_SIZE*2.5)) {
      String [] _level = new String [_board._nbCellsY+2] ;
      for (int i=0; i<_board._nbCellsY; i++) {
        String s="";
        for (int j=0; j<_board._nbCellsX; j++) {
          if (_board._cells[i][j] == TypeCell.WALL) s=s+"x" ;
          else if (_board._cells[i][j] == TypeCell.DOT) s=s+"o";
          else if (_board._cells[i][j] == TypeCell.EMPTY) s=s+"V";
          else if (_board._cells[i][j] == TypeCell.SUPER_DOT) s=s+"O";
          else if (_board._cells[i][j] == TypeCell.PAC_MAN) s=s+"P";
        }
        _level[i] = s ;
      }
      _level[_board._nbCellsY] = str(score) ;
      _level[_board._nbCellsY+1] = str(_life) ;
      saveStrings("partie.txt", _level);
      exit();
    }
  }
// cette fonction permet de charger le dernier score et consulter les meilleurs scores
  void Score() {
    if (_gameOver) {
      _score=append(_score, str(score));
      saveStrings("score.txt", _score);
    }
    if (mouseButton == LEFT && mousePressed==true && inTarget(new PVector(width/2, CELL_SIZE*16), CELL_SIZE*10, CELL_SIZE*2.5)) {
      _score = loadStrings("score.txt");
      int [] sc = new int[_score.length];
      for (int i=0; i<_score.length; i++) {
        sc[i] = int (_score[i]);
      }
      for (int i = 1; i < sc.length; i++)
      {
        int index = sc[i];
        int j = i-1;

        while (j >= 0 && sc[j] < index)
        {
          sc[j+1] = sc[j];
          j--;
        }
        sc[j+1] = index;
      }
      fill(0, 200);
      rectMode(CORNER);
      rect(0, 0, width, height);
      for (int i=0; i< sc.length && i<3; i++ ) {
        fill(255);
        text("Le "+(i+1)+" est :   "+sc[i], width/2-CELL_SIZE*2 , height/2 + (i*CELL_SIZE));
      }
    }
  }


  void loadGame() {
    if (mouseButton == LEFT && mousePressed==true && inTarget(new PVector(width/2, CELL_SIZE*12), CELL_SIZE*10, CELL_SIZE*2.5)) {
      game = new Game("partie.txt") ;
      score = int (game._board.level[game._board._nbCellsY]);
      _life = int (game._board.level[game._board._nbCellsY+1]);
      _draw=false ;
    }
  }

  void exitGame() {
    if (mouseButton == LEFT && mousePressed==true && inTarget(new PVector(width/2, CELL_SIZE*20), CELL_SIZE*10, CELL_SIZE*2.5)) {
      exit();
      cursor(ARROW) ;
    }
  }

  void cursorForm() {
    if ( inTarget(new PVector(width/2, CELL_SIZE*20), CELL_SIZE*10, CELL_SIZE*2.5) || (inTarget(new PVector(width/2, CELL_SIZE*4), CELL_SIZE*10, CELL_SIZE*2.5))
      ||(inTarget(new PVector(width/2, CELL_SIZE*8), CELL_SIZE*10, CELL_SIZE*2.5))||(inTarget(new PVector(width/2, CELL_SIZE*12), CELL_SIZE*10, CELL_SIZE*2.5))
      || (inTarget(new PVector(width/2, CELL_SIZE*16), CELL_SIZE*10, CELL_SIZE*2.5))) {
      cursor(HAND) ;
    } else cursor(ARROW) ;
  }
}
