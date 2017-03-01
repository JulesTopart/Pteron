
//EventHandler
/*
ArrayList<Button> Buttons;
ArrayList<CheckBox> CheckBoxs;
ArrayList<Cursor> Cursors;
ArrayList<Switch> Switchs;


void initControl(){
 Buttons = new ArrayList<Button>(); 
 CheckBoxs = new ArrayList<CheckBox>();
 Cursors = new ArrayList<Cursor>();
 Switchs = new ArrayList<Switch>();
}
*/

//void addButton(Button B){
//  Buttons.add(B);
//}

//void addCheckBox(CheckBox C){
//  CheckBoxs.add(C);
//}


//void addCursor(Cursor C){
//  Cursors.add(C);
//}

//void addSwitch(Switch S){
//  Switchs.add(S);
//}

/*****************************
*        GUI tools           *
******************************
*/


/*
  CHECKBOX,
  BUTTON,
  CURSOR,
  SWITCH;
*/



class ControlMain{
  ControlMain(float X, float Y, float H, float W){
    m_posX = X;
    m_posY = Y;
    m_height = H;
    m_width = W;
    m_isVisible = true;
  }
  
  void setVisibility(boolean a){
    m_isVisible = a;
  }
  
  void toggle(){
    m_isVisible = ! m_isVisible;
  }
  
  void clickEvent(){}
  void releaseEvent(){}
  
  boolean isOverControl(float X, float Y){
    if(X > m_posX && X < m_posX + m_width && Y > m_posY && Y < m_posY + m_height){
      return true;
    }else{
      return false;
    }
  }
  
  void display(){}
  
  float m_posX, m_posY, m_height, m_width;
  boolean m_isVisible; 
};


//CHECKBOX


class CheckBox extends ControlMain{
  CheckBox(float X, float Y, float S){
    super(X,Y,S,S);
    checked = false;
  }
  
  
  void display(){
    if(checked){
      stroke(#FFFFFF);
      fill(#000000);
      rect(m_posX, m_posY, m_width, m_height);
      line(m_posX, m_posY, m_posX + m_width, m_posY + m_height);
      line(m_posX, m_posY + m_height, m_posX + m_width, m_posY);
    }else{
      stroke(#FFFFFF);
      fill(#000000);
      rect(m_posX, m_posY, m_width, m_height);
    }
  }
  
  void clickEvent(){
    if(isOverControl(mouseX, mouseY)) checked = !checked; 
  }
 
  
  
  boolean isChecked(){
    return checked;
  }
  
  private boolean checked;
};


//CLASS BUTTON 


class Button extends ControlMain{  
  Button(float X, float Y, float H, float W, String label, color Color, color pushedColor){
    super(X,Y,H,W);
    pushed =false;
    m_color = Color;
    m_pushedColor = pushedColor;
    m_label = label;
    //Buttons.add(this);
  }
  
  boolean isPushed(){
   return pushed; 
  }
  
  void clickEvent(){
    if(isOverControl(mouseX, mouseY)){
      pushed = true;
      sendPos();
    }
  }
  
  void releaseEvent(){
      pushed = false; 
  }

  void display(){
    
    if(pushed){
      stroke(#5A5A5A);
      fill(m_pushedColor);
      rect(m_posX, m_posY, m_width, m_height ,5);
      fill(#FFFFFF);
      text(m_label, m_posX + (m_width/2) - m_label.length()/2 *5 ,m_posY+13 );
    }else{
      noStroke();
      fill(m_color);
      rect(m_posX, m_posY, m_width, m_height,5);
      fill(#FFFFFF);
      text(m_label, m_posX + (m_width/2) - m_label.length()/2 *5 ,m_posY+13 );
    }
  }
  
  private color m_color;
  private color m_pushedColor;
  private String m_label;
  private boolean pushed;
};


class Cursor extends ControlMain{
  Cursor(float X, float Y,float L, float min, float max, String label){
    super(X,Y,L,0);
    m_level = (max + min) / 2 ;
    m_min = min;
    m_max = max;
    m_label = label;
    m_isActive = false;
  }
  
  
   boolean isOverControl(float X, float Y){
    if(X > m_posX-10 && X < m_posX + 10 && Y > m_posY + map(m_level,m_min,m_max,0,1)*m_height && Y < m_posY + map(m_level,m_min,m_max,0,1)*m_height + 10){
      return true;
    }else{
      return false;
    }
  }
  
  float getLevel(){
    return m_level; 
  }
  
    void clickEvent(){
    if(isOverControl(mouseX, mouseY)){
      m_isActive = true;
    }
  }
  
    void releaseEvent(){
      m_isActive = false; 
  }
  
  boolean isActive(){
   return m_isActive; 
  }
  
  void dragEvent(){
    if(m_isActive){
      m_level -= (mouseX - pmouseX)*0.05;
      m_level += (mouseY - pmouseY)*0.05;
      if(m_level < m_min) m_level = m_min;
      if(m_level > m_max) m_level = m_max;
    }
  }
  
  void setLevel(float L){
     m_level = L;
  }
  
  void display(){
    
    stroke(#FFFFFF);
    line(m_posX,m_posY,m_posX, m_posY + m_height +10 );
    fill(#817F7F);
    rect(m_posX - 10, m_posY + map(m_level,m_min,m_max,0,1)*m_height, 20, 10);
    fill(#FFFFFF);
    text(m_label, m_posX-20, m_posY -12);
  }
  
   private boolean m_isActive;
   private String m_label;
   private float m_level;
   private float m_min, m_max;
}


class Switch extends ControlMain{
  Switch(float X, float Y,float H,float L, String labelOn, String labelOff){
     super(X,Y,H,L);
     m_state = true;
     m_labelOn = labelOn;
     m_labelOff = labelOff;
  }
  
    void clickEvent(){
    if(isOverControl(mouseX, mouseY)){
      m_state = !m_state;
      display();
    }
  }
 
 boolean getState(){
  return m_state; 
 }
 
    void display(){
        fill(#F7F7F7);
    if(m_state){
       noStroke();
       text(m_labelOn,m_posX , m_posY-10);
       rect(m_posX - 2,m_posY-2 ,m_width+4,m_height+4);
       fill(#268100);
       rect(m_posX,m_posY,m_width,m_height);
       fill(#8B8A8A);
       stroke(#3E3E3E);
       rect(m_posX+m_width-m_height,m_posY,m_height,m_height);
    }else{
       noStroke();
       text(m_labelOff,m_posX , m_posY-10);
       rect(m_posX - 2,m_posY-2 ,m_width+4,m_height+4);
       fill(#E30000);
       rect(m_posX,m_posY,m_width,m_height);
       fill(#8B8A8A);
       stroke(#3E3E3E);
       rect(m_posX,m_posY,m_height,m_height);
    }
  }
  
  
  
  private boolean m_state;  
  private String m_labelOn;
  private String m_labelOff;
}