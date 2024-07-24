float speedX = 3.5;
float speedY = 3;

float axeX = 900, axeY = 600;
float obs_x = 950;
float obs_y = 0, obs_h = 0;
float pos_x = axeX/2;
float pos_y = axeY/2;
float radius = 50;

float[] collisionX;
float[] collisionY;

int obsNumber = 10;
String birdName;

PImage birdImg;
PImage obstacleImgTop;
PImage obstacleImgBottom;
PImage bgImg;
int num = 1;
int score = 0;


Obstacle[] obstacle;
Bird bird;

void setup(){
  size(900, 600); 
  //rectMode(CENTER);
    
  /// The Obstacles
  obstacle = new Obstacle[obsNumber];
  collisionX = new float[obsNumber];
  collisionY = new float[obsNumber];
  
  for(int i=0; i<obsNumber; i+=2){
    obs_h = random(100,500);
    float top_y = obs_h;
    float bottom_y = axeY - (obs_h+120);
    
    obstacle[i] = new Obstacle(i,obs_x, 0, top_y);
    obstacle[i+1] = new Obstacle(i+1,obs_x,top_y + 120,bottom_y);
    
    setCollisionProperties(i, obstacle[i],obstacle[i+1]);
  }
  
  for(int i=0; i<obsNumber; i+=2){
    if(i>=2){
      float speed = random(300,400);
      obstacle[i].setPos_X(obstacle[i-1].getPos_X() + speed); 
      obstacle[i+1].setPos_X(obstacle[i-2].getPos_X() + speed); 
    }
  }
  
  /// The Bird
  bird = new Bird(pos_x, pos_y, radius);
  birdName = "b1.gif";
//  bgImg = loadImage("bg.png");
  birdImg = loadImage(birdName);
  
  obstacleImgTop = loadImage("obstacle0.png");
  obstacleImgBottom = loadImage("obstacle1.png");
  
  //The score
  //displayScore = "Score :";
}


int t = 0;
int T = 0;
void draw(){
  background(255);
  if(num <= 5) birdName = "bird1.png";
  if (num > 5 && num <=10) birdName = "bird2.png"; 
  birdImg = loadImage(birdName); 
  
  if(num > 10) num = 1;
  num ++;
  
  imageMode(CORNER);
  //image(bgImg,0,0,axeX,axeY);
  bird.BirdFill();
  bird.display();
  
  fill(255);
  
  for(int i=0; i<obsNumber; i+=2){
   displayObstacle(obstacle[i],obstacle[i+1]);
   if(obstacle[i].getPos_X() < -obstacle[i].getWidth()){
    loopObstacle(obstacle[i],obstacle[i+1]);
   }
   
   setCollisionProperties(i, obstacle[i],obstacle[i+1]);
   if(collision(i, (bird.getPos_X() + radius), (bird.getPos_Y()))){ 
     noLoop();
   } else {
     updateScore(i);     
   }

   moveObstacle(obstacle[i], obstacle[i+1]);
  }
  
  bird.freeFalling();
  textSize(40);
  fill(0);
  
  String displayScore = "SCORE: " + score;
  text(displayScore, 10, 30);
}

void updateScore(int index){
   if(obstacle[index].getPos_X()  < bird.getPos_X()) {
     
     score = index+1 + score;
   } 
}


void displayObstacle(Obstacle obs0,Obstacle obs1){
  obs0.display();
  obs1.display();
}

void moveObstacle(Obstacle obs0,Obstacle obs1){
  obs0.move(speedX);
  obs1.move(speedX);
}

boolean collision(int indexObs,float birdX, float birdY){
  if( (birdX >= collisionX[indexObs] && birdX <= collisionX[indexObs+1]) && 
      (birdY <= collisionY[indexObs]  || birdY + radius >= collisionY[indexObs+1])){
   return true; 
  }
  if(birdY < 0 || birdY + radius > axeY) return true;
  return false;
}

void setCollisionProperties(int indexObs,Obstacle obs0, Obstacle obs1){
  collisionX[indexObs] = obs0.getPos_X();
  collisionX[indexObs+1] = obs1.getPos_X() +  3*radius/2;
  
  collisionY[indexObs] = obs0.getHeight();
  collisionY[indexObs+1] = obs1.getPos_Y();
}

void loopObstacle(Obstacle obs0,Obstacle obs1){
    float topHeight = random(150,500);
    float bottomHeight = (axeY - (topHeight+120));
    float speed = 700;//random(400,550);
    float obstacleX = obs_x + speed*2;
    
    obs0.setPos_X(obstacleX);
    obs0.setHeight(topHeight);
    
    obs1.setPos_X(obstacleX);
    obs1.setHeight(bottomHeight);
    obs1.setPos_Y(topHeight+120);
}
int I = 1;

class Obstacle{
  float x, y, w, h;
  int index;
  
  Obstacle(){
    fill(0,200,0);
    this.w = 50;
  }
  
  Obstacle(int index,float x, float y, float h){
    fill(0,200,0);
    this.x = x;
    this.y = y;
    this.h = h;
    this.w = 50;
    this.index = index;
  }
  
  void setPos_X(float x){
    this.x = x;
  }
  
  void setPos_Y(float y){
    this.y = y;
  }
  
  void setWidth(float w){
    this.w = w;
  }
  
  void setHeight(float h){
    this.h = h;
  }
  
  void display(){
    if(index %2 == 0){
      image(obstacleImgTop,x,y,w,h);
    } else if(index%2 == 1) {
      image(obstacleImgBottom,x,y,w,h);
    }
    //rect(x,y,w,h); 
  }
  
  void move(float s){
    this.x -= s;
  }
  
  float getPos_X(){
    return x;
  }
  
  float getPos_Y(){
    return y;
  }
    
  float getWidth(){
    return w;
  }
  
  float getHeight(){
    return h;
  }
}

class Bird{
  float x, y, r;
  
  Bird(float x, float y, float r){
   this.x = x;
   this.y = y;
   this.r = r;
  }
  
  void BirdFill(){
     fill(200,0,20);
  }
  
  void setPos_X(float x){
    this.x = x;
  }
  
  void setPos_Y(float y){
    this.y = y;
  }
  
  void setRadius(float r){
    this.r = r;
  }
  
  void freeFalling(){
    this.y += speedY;  
  }
  
  float getPos_X(){
    return x;
  }
  
  float getPos_Y(){
    return y;
  }
  
  float getRadius(){
    return r;
  }
  
  void display(){ 
    image(birdImg, x, y, r, r);
  }
}

void keyPressed(){
  
 if(key == ' ') speedY = -5; 
 if(key == 's' || key == 'S') noLoop();
 if(key == 'p' || key == 'P') loop();

}

void keyReleased(){
 if (key == ' ') speedY = 2; 
}
