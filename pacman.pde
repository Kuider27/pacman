Game game;
int score =0 ;
PFont f;
boolean play = true ;
// Ces deux variables pour gérer la vitesse de pacman en fonction de temps
int startTime= 0;
int time = 200;
// pour sauvegarder le score a la fin du partie et récupérer les meilleuirs scores
String[] _score ={"0"} ;

// pour gérer le temp de frightened du fantomes 
int temp = 9999999; // pour gérer frightenedMode() dans class Fantome
/*lorsque le pacman mange un fantome score+=200 le deuxième +400 ..etc donc cette variable 
permet de compter nombre de fantomes qui a été mangé par pacman*/
int manger = 1;

boolean _gameOver = false ;// permet de savoir si le jeu est terminé ou pas 
int _life = 2 ; // nombre de vie de pacman
boolean addLife = false ;//lorsque le score >10000 pacman gagne une vie donc cette variable permet de gèrer l'oparation
boolean eatAll ;// lorsque pac man mange tout le jeu va terminer et cette var permet de gérer cette opération

void setup() {
  size(460, 500, P2D );
  game = new Game("levels/level1_1.txt");
  f = createFont("Arial", 16, true);
}

void draw() {
 if (!_gameOver) {
    
    background(0);
    textFont(f, 16);
    fill(255);
    text("SCORE : "+score, CELL_SIZE, height-2*CELL_SIZE);
    game.drawIt();
    if (play) {
      game.update();
    }
     game.addLife();
  } else {
    background(0, 127);
    textFont(f, 30);
    fill(255);
    text("GAME OVER",CELL_SIZE*6, height/2 -CELL_SIZE*3);
    text("YOUR SCORE IS : "+score, CELL_SIZE*4, height/2);
  }
  if(eatAll) _gameOver =true  ; // lorsque pacman mange le jeu va terminer
}

void keyPressed() {
  game.handleKey(key);
}
