
import processing.serial.*;
Serial Arduino;
boolean Serial_available = false;
float data[] = {0F,0F,0F};

void Serial_check(){
  if(Serial.list().length > 0){
    if(Serial_available)Arduino.stop();
    Serial_available = true;
    Arduino = new Serial(this, Serial.list()[0],9600);
    printArray(Serial.list());
    Arduino.bufferUntil('\n');
    Serial_available = true;
  }else{Serial_available = false;}
}


//void serialEvent(Serial Arduino) {
 

  //try{
     //String inString = Arduino.readStringUntil('\n');
     //if (inString != null){
     //inString = trim(inString); 
     //  float inputs[] = float(split(inString,',')); // on élude les virgules
     //   if(inputs.length == 3){
     //      for(int i = 0 ; i < data.length;  i++){
     //         data[i] = inputs[i];
     //          print("Recu: "); print(data[i]);
     //      }
     //   println();
     //  }
     //}
  //}
//}



void sendPos(){
  if(Serial_available)
  try{
    Arduino.write((byte)'<');
    Arduino.write((byte)(float)(((alpha + (PI/2))%(2*PI) )*(180/PI)));
    Arduino.write((byte)(float)(((-beta - PI)%(2*PI))*(-180/PI)));
    Arduino.write((byte)(float)((gamma%(2*PI))*(180/PI)));
    Arduino.write((byte)(float)(((eta - PI)%(2*PI))*(180/PI)));
    Arduino.write((byte)(float)(((phi)%(2*PI))*(180/PI)));
    if(gripperAnim){
      Arduino.write((byte)(float)1);
    }else{
      Arduino.write((byte)(float)0);
    }
    Arduino.write((byte)'>');
    println("Send : " + hour() + "-" + minute() + "-" + second() );
  }catch(Exception e){
    e.printStackTrace();
    Serial_available = false;
  }
  

}