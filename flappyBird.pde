float speedX = 1;
float speedY = 1;
float axeX = 900, axeY = 600;
float obs_x = 950;
float obs_y = 0, obs_h = 0;
float pos_x = axeX/2;
float pos_y = axeY/2;
float radius = 50;
float[] obstaclesX;

Obstacle[] obstacle;
Bird bird;

void setup(){
  size(900, 600); 
  rectMode(CENTER);
  
  /// The Obstacles
  obstacle = new Obstacle[10];
  obstaclesX = new float[10];
  
  for(int i=0; i<10; i+=2){
    obs_h = random(200,1000);
    float top_y = obs_h;
    float bottom_y = 2*axeY - (obs_h+200);
    obstacle[i] = new Obstacle(obs_x, 0, top_y);
    obstacle[i+1] = new Obstacle(obs_x,axeY, bottom_y);
    obstaclesX[i] = obs_x;
    obstaclesX[i+1] = obs_x;
  }
  
  
  for(int i=0; i<10; i+=2){
    if(i>=2){
      float speed = random(300,400);
      obstacle[i].setPos_X(obstacle[i-1].getPos_X() + speed); 
      obstacle[i+1].setPos_X(obstacle[i-2].getPos_X() + speed); 
    }
  }
  
  /// The Bird
  bird = new Bird(pos_x, pos_y, radius);
}

void draw(){
  background(20,20,200);
  
  bird.BirdFill();
  bird.display();
  
  fill(20,200,20);
  for(int i=0; i<10; i++){
   obstacle[i].display(); 
   obstacle[i].setPos_X(obstacle[i].getPos_X() - speedX);
   obstaclesX[i] = obstacle[i].getPos_X();
   println("Bx"+bird.getPos_X()+" Ox: "+obstaclesX[i] );
   if(obstaclesX[i] <= bird.getPos_X()+50 && obstaclesX[i] >= bird.getPos_X()-50){
    println(" OKK"); 
   }
  }
}

class Obstacle{

  float x, y, w, h;
  Obstacle(){
    fill(0,200,0);
    this.w = 50;
  }
  
  Obstacle(float x, float y, float h){
    fill(0,200,0);
    this.x = x;
    this.y = y;
    this.h = h;
    this.w = 50;
  }
  
  void setPos_X(float x){
    this.x = x;
  }
  
  void setPos_Y(float y){
    this.y = y;
  }
  
  float getPos_X(){
    return x;
  }
  
  float getPos_Y(){
    return y;
  }
  
  void setWidth(float w){
    this.w = w;
  }
  
  void setHeight(float h){
    this.h = h;
  }
  
  void display(){
    rect(x,y,w,h); 
  }
}

class Bird{
  float x, y, r;
  
  Bird(float x, float y, float r){
   ellipseMode(CENTER);
   
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
    ellipse(x,y,r,r); 
  }
}
