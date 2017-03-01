ArrayList<float[]> keyF;
ArrayList<float[]>keyA;

float lastA, lastB, lastE;
boolean lastGripp;

PrintWriter output;
boolean hasFile = false;
int nbFrame = 0;

String str = "";

void newProgram(){
      str = "PRGM" + "_" + day() + "-" + month() + "-" + year() + " I " + hour() + "-" + minute();
      output = createWriter("/prgm/"+str+".sim");
      println("Created :" + str);
      keyF = new ArrayList<float[]>();
      keyA = new ArrayList<float[]>();
}


void addFrame(){
  nbFrame++;
  boolean temp = false;
  
  if(alpha != lastA){
    if(temp == false){
      output.print("G01 ");
      temp = true;
    }
    output.print("X " + alpha + " ");
  }
  
  if(beta != lastB){
    if(temp == false){
      output.print("G01 ");
      temp = true;
    }
    output.print("Y " + beta + " ");
  }
  
  if(eta != lastE){
    if(temp == false){
      output.print("G01 ");
      temp = true;
    }
    output.print("Z " + eta + " ");
  }
  
  if(gripperAnim){
   output.print("M55 ");
  }
  
  if(temp) output.println();
  
  float T[] = {posX, posY, posZ};
  keyF.add(T);
  float Clamps;
  if(gripperAnim) Clamps = 1.0; else Clamps = 0.0;
  float A[] = {alpha, beta, gamma, eta, phi, Clamps};
  keyA.add(A);

  lastA = alpha;
  lastB = beta;
  lastE = eta;
  lastGripp = gripperAnim;
  output.flush(); // Write the remaining data
}

void removeFrame(){
if(keyF.size() > 0) keyF.remove(keyF.size() -1);
  
}


void printPrgm(){
  Mode.toggle();
  for(int i = 0; i< keyA.size();i++){
      float[] tempT= keyA.get(i);
      alpha = tempT[0];
      beta = tempT[1];
      gamma = tempT[2];
      eta = tempT[3];
      phi = tempT[4];
      if(tempT[5] == 1.0) gripperAnim = true; else gripperAnim = false;
      sendPos();
  }
  Mode.toggle();
  
  
}