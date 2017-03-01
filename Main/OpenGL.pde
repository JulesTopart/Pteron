PShape base, shoulder, upArm, loArm, end, s;
PShape Gripper, Grip_Base, Grip_Arm;
float rotX, rotY;

float zoom = 1;

PImage img;

int numParts = 80;
float diam = 600;

boolean gripperAnim = false;
float gripperRot = PI/6;
float gripperStep = 0.01;

//Araylist key

void OpenGl_init(){
    ortho();
    smooth();
    img = loadImage("Texture/base.jpg");
    //img.resize(300,300);
    //TODO Model Ustepp et Moveo
    base = loadShape("Part/Obj_Socle.obj");
    shoulder = loadShape("Part/Obj_Axe1.obj");
    upArm = loadShape("Part/Obj_Axe2.obj");
    loArm = loadShape("Part/Obj_Axe3.obj");
    end = loadShape("Part/Obj_Effecteur.obj");
    
    Gripper = loadShape("Part/Gripper.obj");
    Grip_Arm = loadShape("Part/Pince Bras 1.obj");
    Grip_Base  = loadShape("Part/Pince_Socle.obj");
    
    s = createShape();
    s.beginShape();
    s.texture(img);
    s.noStroke();
    s.textureMode(NORMAL);
    float theta = TWO_PI / numParts;
    for (int i=0; i<numParts; i++) {
      float angle = theta * i;
      float x = cos(angle);
      float y = sin(angle);
      s.vertex(x * diam, y * diam, (x+1)/2, (y+1)/2);
    }
    s.endShape();
    
   
   Grip_Base.disableStyle();
   Gripper.disableStyle();
   Grip_Base.rotateZ(-PI/2);
   
   
    shoulder.rotateZ(-PI/2);
    upArm.rotateY(PI/2);
    loArm.rotateY(-PI/2);
    end.rotateZ(PI);
    
    
    shoulder.disableStyle();
    upArm.disableStyle();
    loArm.disableStyle();
    base.disableStyle();
    
    //base.setTexture(img);
    //base.setTextureMode(NORMAL);
}
 
 
void draw3D(){
  pushMatrix();
  anim();
  directionalLight(0, 255, 0, 0, -1, 0);
   writePos();
   smooth();
   lights();

   translate(width/2,2*height/3);
   rotateX(rotX);
   rotateY(-rotY); 
   scale(-zoom);
   
   rotateY(PI/2);
   rotateX(-PI/2);
   rotateZ(PI/2);
   
   
   pushMatrix();
      renderKeyF();
      translate(posX,posY,posZ);
   if(Mode.getState()) drawRep();
   popMatrix();
   
   pushMatrix();
   fill(#6C6C6C); 
   translate(0,0,-75); 
     shape(base);
   translate(0,0,-1);
   fill(#D35906);
     shape(s);
   popMatrix();
   
   
     fill(#E38800);
   rotateZ(gamma);
     shape(shoulder);
   translate(0,0,74);
   
      fill(#EA9615);
   rotateY(alpha);
     shape(upArm);
   translate(F, 0, 0);
  fill(#E38800);
   rotateY(beta);
     shape(loArm);
   translate(-T, 0, 0);
   rotateX(phi);
   rotateY(eta);
     shape(end);
   translate(50,0,0);
   
      fill(#404040); 
   shape(Grip_Base);
   
   pushMatrix();
     translate(0,-15,0);
     rotateZ(-gripperRot);
     shape(Grip_Arm);
     translate(40,0,0);
     rotateZ(gripperRot + PI/12);
     shape(Grip_Arm);
     translate(40,10,-5);
     rotateZ(-PI/12);
          fill(#313131); 
     shape(Gripper);
   popMatrix();
   
   pushMatrix();
     translate(0,15,0);
     rotateZ(gripperRot);
     shape(Grip_Arm);
     translate(40,0,0);
     rotateZ(-gripperRot - PI/12);
     shape(Grip_Arm);
     translate(40,-10,-5);

     rotateZ(PI/12);
     rotateZ(PI);
     fill(#313131); 
       shape(Gripper);
   popMatrix();

  popMatrix();
}

void drawLine(float x1, float y1, float z1, float x2, float y2, float z2, float weight, color strokeColour)
{
  PVector p1 = new PVector(x1, y1, z1);
  PVector p2 = new PVector(x2, y2, z2);
  PVector v1 = new PVector(x2-x1, y2-y1, z2-z1);
  float rho = sqrt(pow(v1.x,2)+pow(v1.y,2)+pow(v1.z,2));
  float phi = acos(v1.z/rho);
  float the = atan2(v1.y,v1.x);
  v1.mult(0.5);
  pushMatrix();
  translate(x1,y1,z1);
  translate(v1.x, v1.y, v1.z);
  rotateZ(the);
  rotateY(phi);
  noStroke();
  fill(strokeColour);
  box(weight,weight,p1.dist(p2)*1.2);
  popMatrix();
}

void drawRep(){
  drawLine(0,0,0,0,0,200,5,#070390);
  drawLine(0,0,0,0,200,0,5,#02A708);
  drawLine(0,0,0,200,0,0,5,#DB0209); 
}


void anim(){
  if(!gripperAnim){
    gripperRot += gripperStep;
    if(gripperRot >= PI/4){
      gripperRot = PI/4;
      
    }
  }
  
  if(gripperAnim){
    gripperRot -= gripperStep;
    if(gripperRot <= PI/24){
      gripperRot = PI/24;
    }
  }
}


void renderKeyF(){
 for(int i = 0 ; i< keyF.size(); i++) {
   pushMatrix();
   translate(keyF.get(i)[0],keyF.get(i)[1],keyF.get(i)[2]);
   stroke(#B20505);
   fill(#B20505);
     ellipse(0,0,10,10);
   rotateX(PI/2);
      ellipse(0,0,10,10);
   rotateY(PI/2);
      ellipse(0,0,10,10);
   popMatrix();
 }
  
  
  
}