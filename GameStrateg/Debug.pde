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
  if (frameCount % 10 == 0) window.fps=int(frameRate);
  text("FPS: "+window.fps+" | MPUpdate: "+window.mpu+" | MPPause: "+window.mpp+" | MPDraw:"+window.mpd,10,10);
  text("Last Key Press: "+key+" ("+keyCode+")",10,20);
  text("Mouse Press: "+mouse.flagPressed+"("+mouse.x+","+mouse.y+") / ("+mousePresPos.x+","+mousePresPos.y+")",10,30);
  text("Count Allocate: "+mouse.countAllocate,10,40);
  text("Mouse Mode: "+mouse.mode,10,50);
  text("Camera Scroll: "+gameCamera.GetScroll(true)+" ("+gameCamera.GetScroll(false)+")",10,60);
  text("CountScroll: "+gameCamera.scrolls[gameCamera.countScroll]+"-"+gameCamera.scrolls[gameCamera.lastScroll],10,90);
  text("Mouse in gameLocation: "+gameLocation.mouseIn,10,70);
  //text("Temp:"+enemy.get(0).time_to_spot+" | "+enemy.get(0).maxSpotTime,10,80);
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
  int i=0;
  for (Unit unit : own)
  {
    int locX = width-150;//int(rota[i].location.x+15);
    int locY = 100*(++i)+30;
    text("LVL: "+unit.lvl,locX,locY);
    text("x: "+int(unit.position.x)+" y: "+int(unit.position.y),locX,locY+10);
    text("xTo: "+int(unit.endPosition.x)+" yTo: "+int(unit.endPosition.y),locX,locY+20);
    text("xStep: "+(unit.position.x-unit.lastPosition.x)+" yTo: "+(unit.position.y-unit.lastPosition.y),locX,locY+30);
    text("LocTo distance: "+int(unit.position.dist(unit.endPosition)),locX,locY+40);
    text("Flag move: "+unit.flagMove,locX,locY+50);
    text("Flag spot: "+unit.flagSpoted,locX,locY+60);
    text("Time of spot: "+unit.time_to_spot,locX,locY+70);
  }
  noStroke();
}
