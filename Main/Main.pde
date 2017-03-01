/***********************************************************************
*                        Robot Arm Simulation                          *
*             Created by Jules Topart for project Pteron               *
*             Please make sure you dowload all the package             *
*                         IUT AMIENS 2016-2017                         * 
*                                                                      *
************************************************************************
*/

String RobotType = "Pteron";
//String RobotType = "UStepper";
PImage backImg;


void setup(){
    size(1300,800, P3D);
    textSize(10);
    backImg = loadImage("texture/background.jpg");
    backImg.resize(width,height);
    OpenGl_init();
    Serial_check();
    Gui_init();
    frameRate(200);
    newProgram();

}

float Tx = 5 ,Ty = 5;

void draw(){
  //  demo()
  background(backImg);
  draw3D();
  drawGUI();
  //test1.display();
  //test2.display();

  //test4.display();
  
  if(millis() % 10 == 0) surface.setTitle(int(frameRate) + " fps");
  //if(millis() % 100 == 0) Serial_check();
}

void demo(){
  if(posX < 250) Tx = +5;
  if(posX > 400) Tx = -5;
  if(posY < -200) Ty = +5;
  if(posY > 200) Ty = -5;
  if(millis() % 100 == 0) gripperAnim = !gripperAnim;
  
  posX += Tx;
  posY += Ty;
}

//1000 10