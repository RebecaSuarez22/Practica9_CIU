import processing.sound.*;
import processing.serial.*;

Serial myPort;  // Create object from Serial class
String val;     // Data received from the serial port

int jugx = 360;
int jugy = 160;

int jug2x = 20;
int jug2y = 160;

float cir_x = 200;
float cir_y = 200;

float mov_x = 2;
float mov_y = -2;

int ancho=20;
int alto=75;
int D = 20;

int goles1 = 0;
int goles2 = 0;

boolean inicio = false;
boolean fin = false;

int g = 0;
int showWin = 0;

SoundFile  rebote;
SoundFile  punto;
SoundFile ganador;

PFont mario;
int sensor = 0;

void setup(){
  size(400,400);  
  rebote = new SoundFile(this,"sonidos/mixkit-magic-bubbles-spell-2999.wav");
  punto = new SoundFile(this,"sonidos/mixkit-failure-arcade-alert-notification-240.wav");
  ganador = new SoundFile(this,"sonidos/mixkit-video-game-win-2016.wav");
  mario = createFont("SuperMario256.ttf", 128);
  textFont(mario);
  String portName = Serial.list()[0]; //change the 0 to a 1 or 2 etc. to match your port
  myPort = new Serial(this, portName, 9600);
  val = "0";
  sensor = 0;
}

void draw(){ 
  background(128);
  
  if ( myPort.available() > 0){  // If data is available,
    val = myPort.readStringUntil('\n'); // read it and store it in val
  }
  
  if(val != null  && val != ""){
    sensor = Integer.parseInt(val.trim());
  }
    
  
  if(jug2y>=(400-alto)){
    jug2y=(400-alto);
  }else if(jug2y<=0){
    jug2y=0;
  }
  
  
  jugy=sensor;    
  
  if(jugy>=(400-alto)){
    jugy=(400-alto);
  }else if(jugy<=0){
    jugy=0;
  }
  
  
  if(key == 'w'){
    jug2y -=2;
  } else if(key == 's'){
    jug2y +=2;
  }
    
  background(0);    
  

  if(cir_x > width) {
    cir_x = width;
    mov_x = -mov_x;
    goles1+=1;
    punto.play();
  }
  
  if(cir_y > height) {
    cir_y = height;
    mov_y = -mov_y;    
  }
  
  if(cir_x < 0) {
    cir_x = 0;
    mov_x = -mov_x;
    goles2+=1;
    punto.play();
  }
  
  if(cir_y < 0) {
    cir_y = 0;
    mov_y = -mov_y;
  }
  
    
  //Si choca con el jugador de la derecha
  if (mov_x>0 && jugy<=cir_y+D/2 && cir_y-D/2<=jugy+alto && jugx<=cir_x+D/2 && cir_x-D/2<=jugx+ancho){
    mov_x=-mov_x;
    rebote.play();
  }
  
  //Si choca con el jugador de la izquierda
  if (mov_x<0 && jug2y<=cir_y+D/2 && cir_y-D/2<=jug2y+alto && jug2x+ancho>=cir_x-D/2 && cir_x-D/2<=jug2x+ancho){
    mov_x=-mov_x;
    rebote.play();
  }
  
  if(inicio == true){    
    stroke (255);
    cir_x = cir_x + mov_x;
    cir_y = cir_y + mov_y;

    fill(255);
    ellipse(cir_x, cir_y, D, D);
  
    fill(236,112,99);
    strokeWeight (0);
    rect(jugx,jugy,ancho,alto);
    fill(93,173,226);
    rect(jug2x,jug2y,ancho,alto);
    
    textSize(30);
    fill(255);
    text(goles1, 150, 40);
    text(goles2, 230, 40);  
    
    textSize(15);
    text("Jugador 1", 50, 380);
    text("Jugador 2", 255, 380);
    
    strokeWeight (3);
    fill(255);
    line (200,0,200,400);
  }
  
  if(inicio == false){  
    textSize(18);
     if(fin == true){
       text("Ha ganado el jugador "+g, 80, 100);
     }
     
     reset();     
     
     fill(0);
     stroke (46, 91, 176);
     strokeWeight (5);
     rect (75,150,260,75);
     
     fill(255); 
     textSize(18);
     text("Pulse la tecla enter", 90, 180);     
     text("para empezar", 130, 210);     
     textSize(12);
     text("Help(h)", 180, 280);  
     
    if (key == ENTER){
        inicio=true;    
    }
    
    if(key == 'h'){
      fill(255);
      rect(60,75,290,270);
      fill(0); 
      textSize(20);
      text("Intrucciones", 125, 110);
      textSize(15);
      text("Jugador 1: ", 80, 140);
      text("Mover hacia arriba 'w'", 80, 160);
      text("Mover hacia abajo 's'", 80, 180);
      
      text("Jugador 2: ", 80, 220);
      text("Mover hacia arriba 'UP'", 80, 240);
      text("Mover hacia abajo 'DOWN'", 80, 260);
      
      text("Gana el primer jugador que", 80, 300);
       text("marque tres goles", 80, 320);
    
    }     
  
  }  
  
  finJuego();
  
}

void reset(){
     cir_x=200;
     cir_y=200;
     
     goles1=0;
     goles2=0;
     
     jugx = 360;
     jugy = 160;

     jug2x = 20;  
     jug2y = 160;
}

void finJuego(){ 
     if(goles1 == 3){
      ganador.play();
      g=1;
      inicio = false;
      fin = true;      
    }

    if(goles2 == 3){
      ganador.play();   
      g=2;
      inicio=false;
      fin = true;      
    }
 }
