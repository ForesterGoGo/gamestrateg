PVector debugVector;
PVector debugVector2;
PVector debugVector3;
class DebugWindow
{
  PVector position;
  PVector size;
  int type;
  boolean border;
  DebugWindow(int x,int y,int h,int z,int t)
  {
    position = new PVector(x,y);
    size = new PVector(h,z);
    type = t;
    border = false;
    debugVector = new PVector(0,0);
    debugVector2 = new PVector(0,0);
    debugVector3 = new PVector(0,0);
  }
  void Draw()
  {
    if(border)
    {
      stroke(255);
      noFill();
      rect(position.x,position.y,size.x,size.y);
    }
    switch(type)
    {
      case 1: //Окно дебага показывающее направления векторов и их длинну
        stroke(255,0,0);
        float x1 = position.x + size.x/2;
        float y1 = position.y + size.y/2;
        line(x1,y1,debugVector.x,debugVector.y);
        stroke(0,255,0);
        line(x1,y1,debugVector.x,debugVector.y);
        stroke(0,0,255);
        line(x1,y1,debugVector.x,debugVector.y);
      break;
    }
  }
}
String[] textDebug = new String[20];
int countText = 0;
void newTextDebug(String text)
{
  textDebug[++countText] = text;
}
void DrawTextDebug()
{
  fill(255);
  for(int i=0;i<countText-1;i++)
  if(textDebug[i] != null)text(textDebug[i],200,15+15*i);
}

void debug()
{
  fill(255);
  if (frameCount % 10 == 0) fps=int(frameRate);
  text("FPS: "+fps,10,10);
  text("Last Key Press: "+key+" ("+keyCode+")",10,20);
  text("Mouse Press: "+flagMousePressed,10,30);
  text("Count Allocate: "+countAllocate,10,40);
  text("Mouse Mode: "+mouseMode,10,50);
  text("Camera Scale: "+gameCamera.scale,10,60);
  
  text("Mouse in gameLocation: "+gameLocation.mouseIn,10,70);
}

void console()
{
  noStroke();
  fill(200);
  rect(0,0,width,height-400);
}


void DrawUnitsData()
{
  stroke(255);
  fill(255);
  int locX = 0, locY = 0;
  for(int i=0;rota[i]!=null;i++)
  {
    locX = width-150;//int(rota[i].location.x+15);
    locY = 100*i+30;
    text("ID: "+rota[i].id+" || LVL: "+rota[i].lvl,locX,locY);
    text("x: "+int(rota[i].location.x)+" y: "+int(rota[i].location.y),locX,locY+10);
    text("xTo: "+int(rota[i].location2.x)+" yTo: "+int(rota[i].location2.y),locX,locY+20);
    text("LocTo distance: "+int(rota[i].location.dist(rota[i].location2)),locX,locY+30);
    text("Flag move: "+rota[i].flagMove,locX,locY+40);
    if(rota[i].flagAllocate)text("IDAllocate: "+rota[i].IdAllocate,locX,locY+50);
  }
  noStroke();
  
}
