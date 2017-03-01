int pas = 7;
float angle = (PI/48);
int keyD = 0;

float tempX, tempY, tempZ;

void keyReleased(){
  if(keyD <= 1) key = ' ';
  keyD--;
}

void keyPressed(){
  keyD++;
}

void Key_Check(){
  tempX = posX;
  tempY = posY;
  tempZ = posZ;
  if(Mode.getState()){
      switch(key){
     case 'z':
       posX += pas;
       break;
     case 's':
       posX -= pas;
       break;
     case 'q':
       posY += pas;
       break;
     case 'd':
       posY -= pas;
       break;
     case 'a':
       posZ += pas;
       break;
     case 'e':
       posZ -= pas;
       break;
     case 'g':
     if(gripperAnim){
       gripperAnim = false;
       key = ' ';
     }else{
       gripperAnim = true;
       key = ' ';
     }
     break;
    case ENTER:
       if(!realTime.getState())sendPos(); else printPrgm(); 
    break;
    case '+':
    if(!realTime.getState()) addFrame();
      break;
    case '-':
    if(!realTime.getState()) removeFrame();
      break;
    }
    checkMove();
  }else{
     switch(key){
     case 'z':
       AlphaC.setLevel(alpha + angle);
       break;
     case 's':
       AlphaC.setLevel(alpha - angle);
       break;
     case 'q':
       BetaC.setLevel(beta + angle);
       break;
     case 'd':
       BetaC.setLevel(beta - angle);
       break;
     case 'a':
       GammaC.setLevel(gamma + angle);
       break;
     case 'e':
       GammaC.setLevel(gamma - angle);
       break;
     case 'w':
       EtaC.setLevel(eta + angle);
       break;
     case 'x':
       EtaC.setLevel(eta - angle);  
       break;
     case 'g':
     if(gripperAnim){
       gripperAnim = false;
       key = ' ';
     }else{
       gripperAnim = true;
       key = ' ';
     }
     break;
    case ENTER:
      if(!realTime.getState())sendPos();else printPrgm(); 
    break;
    case '+':
    if(!realTime.getState()) addFrame();
      break;
    case '-':
    if(!realTime.getState()) removeFrame();
      break;
    }
  }
  
}