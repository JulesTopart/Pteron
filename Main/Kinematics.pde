float F = 210.75; //1st Arm Length
float T = 223.5; // 2nd Arm Length
float H = 75; //Base Height
float B = 125; // Tool offset (Head Length)
float Bz = -75;


float posX=250, posY=0, posZ=0;
float alpha, beta, gamma, eta, phi = 0.0;

float alpha1, beta1;

float Xxz, Zxz;

float lastPos[] = {0.0,0.0};

void IK(){
    float X;
    float Y;
    float Z;
    
    float L;
    float dia;
    
    X = posX;
    Y = posY;
    Z = -posZ;
    
    if(X == 0){
      if(Y == 0){
        gamma = 0;
      }else{
        if(Y > 0){
          gamma = PI/2;
        }else{
          gamma = - PI/2;
        }
      }
    }else{
      if(X > 0){
        gamma = atan(Y/X); 
      }else{
        gamma = atan(Y/X) + PI; 
      }
    }
    
    

  //Tool correction
  
    X = X - B*cos(gamma);
    Y = Y - B*sin(gamma);
    
    

      
    Z = Z - Bz;
    
    L = sqrt(Y*Y+X*X);
    dia = sqrt(Z*Z+L*L);
  
    alpha = PI/2-(atan2(L, Z)+acos((T*T-F*F-dia*dia)/(-2*F*dia)));
    beta = -acos((dia*dia-T*T-F*F)/(-2*F*T));
    eta = -alpha - beta;
    //For command Ustepper 1st Angle = alpha1 énd angle = beta1 - alpha1
}

void FK(){
  Xxz = cos(alpha)*F + cos(beta)*T;
  Zxz = sin(alpha)*F + sin(beta)*T;
  
  posZ = -Zxz-H-74-65+Bz;
  posX = cos(gamma)*(Xxz + B);
  posY = sin(gamma)*(Xxz + B);
}


void writePos(){  
  if(Mode.getState()){ 
    Key_Check(); 
    IK();
    //sendPos();
  }
  else{
    Key_Check();
    alpha = AlphaC.getLevel();
    beta = BetaC.getLevel();
    gamma = GammaC.getLevel();
    eta = EtaC.getLevel();
    phi = PhiC.getLevel();
    /*
    if(Serial_available){
      gamma = - data[2]*0.0174533;
      beta = - data[1]*0.0174533 + 2*PI/3;
      alpha = - data[0]*0.0174533 + PI/2;
    }*/
    //FK();
    //sendPos();
  }
}


void checkMove(){
    if(posZ <= -40) posZ = -40;
}