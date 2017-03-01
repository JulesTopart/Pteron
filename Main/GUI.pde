Button  Send; 
CheckBox test2;
Switch Mode;
Switch realTime;
Cursor test4;

Cursor AlphaC;
Cursor BetaC;
Cursor GammaC;
Cursor EtaC;
Cursor PhiC;

void Gui_init(){
    Send = new Button(20F,685F,20F,80F,"Send Position",#118900, #0B5500);
    test2 = new CheckBox(100F,50F,20F);
    Mode = new Switch(20F,300F,20F,60F,"Mode: Cartesian","Mode : Angular");
    realTime = new Switch(20F,360F,20F,60F,"Mode: Real Time","Mode : Programming");
    test4 = new Cursor(400F,340F,100F,0,300,"TEST");
    
    AlphaC = new Cursor(1050F,30F,200F,-2*PI,2*PI,"Alpha: ");
    BetaC = new Cursor(1100F,30F,200F,-PI,3*PI,"Beta: ");
    GammaC = new Cursor(1150F,30F,200F,-2*PI,2*PI,"Gamma: ");
    EtaC = new Cursor(1200F,30F,200F,-PI,3*PI,"Eta: ");
    PhiC = new Cursor(1250F,30F,200F,-2*PI,2*PI,"Phi: ");
}


void drawGUI(){
   Send.display();
   Mode.display();
   realTime.display();
   
   AlphaC.display();
   BetaC.display();
   GammaC.display();
   EtaC.display();
   PhiC.display();
   
    
  fill(#F7F7F7);

  text("X:                 mm ",5, 25);
  text(posX, 15 ,25 );
  text("Y:                 mm ",5, 50);
  text(posY, 15 ,50 );
  text("Z:                 mm ",5, 75);
  text(posZ, 15 ,75 );
  
  text("Please use ZQSD key to manipulate arm / Use G to toggle the gripper / Use + and - to add a key frame to your programm / Use Enter to send the data",270, 25);

 
  
  translate(0,100,0);
  
  text("Alpha:                         ° ",5, 25);
  text(((alpha + (PI/2))%(2*PI))*(180/PI), 55 ,25 );
  text("Beta:                          ° ",5, 50);
  text(((-beta + PI)%(2*PI))*(-180/PI), 55 ,50 );
  text("Gamma:                         ° ",5, 75);
  text((gamma%(2*PI)) *(180/PI), 55 ,75 );
  
  text("X:                 mm ",20, 760);
  text(currentMouseX, 30 ,760 );
  text("Y:                 mm ",40, 760);
  text(currentMouseY, 200 ,760 );
  
  translate(0,-100,0);
  
  text("X:                 mm ",15 ,760 );
  text(mouseX, 35 ,760 );
  text("Y:                 mm ",115, 760);
  text(mouseY, 135 ,760 );
  text("Serial : ",15,730);
  
  if(Serial_available){
    fill(#1FA502);
    text("Connected",50,730); 
  }
  else{
    fill(#C91010);
    text("Disconnected",50,730); 
  }
}