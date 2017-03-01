float currentMouseX = 0;
float currentMouseY = 0;

boolean moveX, moveY, moveZ;

void mouseDragged(){
  if(test4.isActive()){
   test4.dragEvent();
  }else if(AlphaC.isActive()){
    AlphaC.dragEvent();
  }else if(BetaC.isActive()){
    BetaC.dragEvent();
  }else if(GammaC.isActive()){
    GammaC.dragEvent();
  }else if(EtaC.isActive()){
    EtaC.dragEvent();
  }else if(PhiC.isActive()){
    PhiC.dragEvent();
  }
  else{
    tempX = posX;
    tempY = posY;
    tempZ = posZ;
    //-9633532 Red
    //-16690428 Green
    // -16580280 Blue
    if(get(mouseX, mouseY) == -9633532 || moveX){
      posX += mouseX - pmouseX;
      posX -= mouseY - pmouseY;
      moveX = true;
    }else if(get(mouseX, mouseY) == -16690428 || moveY){
      posY += mouseX - pmouseX;
      posY -= mouseY - pmouseY;
      moveY = true;
    }else if(get(mouseX, mouseY) == -16580280 || moveZ){
      posZ += mouseX - pmouseX;
      posZ -= mouseY - pmouseY;
      moveZ = true;
    }else{
      rotY -= (mouseX - pmouseX) * 0.01;
      rotX -= (mouseY - pmouseY) * 0.01;
      
      if(rotX > 0) rotX = 0;
          if(rotX < -PI) rotX = -PI;
    
  }

}

  //checkMove();
}

void mouseReleased(){
 moveX = false; 
 moveY = false; 
 moveZ = false; 
 
 Send.releaseEvent();
 test4.releaseEvent();
   AlphaC.releaseEvent();
   BetaC.releaseEvent();
   GammaC.releaseEvent();
   EtaC.releaseEvent();
   PhiC.releaseEvent();
}

void mousePressed(){

currentMouseX = mouseX;
currentMouseY = mouseX;

    Send.clickEvent();
    test2.clickEvent();
    Mode.clickEvent();
    realTime.clickEvent();
    test4.clickEvent();
    
   AlphaC.clickEvent();
   BetaC.clickEvent();
   GammaC.clickEvent();
   EtaC.clickEvent();
   PhiC.clickEvent();
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  zoom -= e*0.05;
}