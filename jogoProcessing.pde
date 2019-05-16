
float bolaX;
float bolaY;
float deslocamentoX;
float deslocamentoY;
float posicaoMouse;
int pontos;
PImage bola;
PImage bg;
PFont fonte;
PFont fonteAdd;
static final int TELA_INICIO = 0;
static final int JOGO = 1;
static final int FIM_DE_JOGO = 2;
int estado;
int recorde;
int pontuacao;

//################## setup() #####################

void setup() {
  size(600, 450);
  resetaJogo();
  bola = loadImage("bola.png");
  bg = loadImage("bg.png");
  fonte = loadFont("04b.vlw");
  fonteAdd = createFont("Arial", 14);
  estado = TELA_INICIO;
  recorde = 0;
  pontuacao = 0;
}

void resetaJogo() {
  frameRate(60);
  bolaX=15;
  bolaY=15;
  deslocamentoX = 5;
  deslocamentoY = 4;
  pontos=0;
}


// ########## draw() ############


void draw() {

  switch(estado) {

  case TELA_INICIO:
    telaInicio();
    break;

  case JOGO:
    jogar();
    break;

  case FIM_DE_JOGO:
    fimdeJogo();
    break;
  }
}



//  ######## keyPressed() ###########

void keyPressed() {


  if (keyCode == ENTER) {
    if (estado == FIM_DE_JOGO || estado == TELA_INICIO) {
      estado = JOGO;
    }
  }

  if (key == BACKSPACE) {
    if (estado == FIM_DE_JOGO) estado = TELA_INICIO;
  }
}



// ######### telaInicio() ##########


void telaInicio() {
  resetaJogo();


  background(51, 102, 153);

  image(bola, 250, 140, 100, 100);
  fill(255);


  textFont(fonte);
  textAlign(CENTER);
  text("BALL PONG \n\n", 300, 300);

  textFont(fonteAdd);
  textAlign(LEFT);
  text("Feito com Processing 3.5.3", 30, 400, 100, 50);
  text("Aperte ENTER para iniciar", 225, 330);


  if (recorde > 0) {
    text("Highscore: "+recorde, 500, 30);
  }
}





// ##########  jogar()  ##################

void jogar() {

  background(bg);

  fill(255);
  rect(100, 0, 5, 450);
  rect(495, 0, 5, 450);
  rect(295, 0, 5, 225);
  rect(105, 225, 390, 5);

  textFont(fonte);
  textAlign(LEFT);
  text(""+pontos, 530, 50, 100, 50);


  noCursor();


  image(bola, bolaX, bolaY, 30, 30);


  noStroke();
  fill(128, 90, 70);
  rect(mouseX, 430, 100, 20);



  verificaBordas();

  bolaY += deslocamentoY;
  bolaX += deslocamentoX;
  posicaoMouse = mouseX;
} 



// ############ verificaBordas()##########

void verificaBordas() {

  if (bolaY >= 420) {
    if (pontos > recorde) recorde = pontos;

    pontuacao = pontos;
    estado = FIM_DE_JOGO;
  } else if (bolaY <= 0) {

    deslocamentoY = 4;
  } else if ( bolaY >= 400 && bolaX <= mouseX+100 && bolaX >=mouseX - 3) {

    if (deslocamentoX > 0 && mouseX < posicaoMouse) {

      deslocamentoX = -5;
    } else if (deslocamentoX < 0 && mouseX > posicaoMouse) {

      deslocamentoX = 5;
    }

    pontos++;
    deslocamentoY = -4;

    frameRate(frameRate+5);
   
  }

  if (bolaX >= 570) {

    deslocamentoX = -5;
  } else if (bolaX <= 0) {

    deslocamentoX = 5;
  }
} 



//  ################## fimdeJogo() #############

void fimdeJogo() {
  resetaJogo();
  smooth();
  background(0);
  fill(200, 10, 10);
  textFont(fonte);
  textAlign(CENTER);
  text("DERROTA", 295, 300);

  textFont(fonteAdd);
  textAlign(CENTER);
  text("Pontuação:"+ pontuacao, 250, 200, 100, 50);
  text("Aperte ENTER para reiniciar ou BACKSPACE para tela inicial", 200, 330, 200, 50);
} 
