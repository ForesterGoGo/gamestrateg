class Mouse
{
  int x;
  int y;
  float scroll;
  PVector shift;
  boolean flagPressed;
  boolean flagAllocation;
  boolean flagLast;
  boolean flagShifted;
  boolean flagScrolled;
  int countAllocate;
  String mode;
  Mouse()
  {
    shift = new PVector(0,0);
    flagPressed = false;
    flagAllocation = false;
    flagLast = false;
    flagShifted = false;
    flagScrolled = false;
    mode = "Null";
    countAllocate = 0;
  }
  
  void Draw()
  {
    fill(255,0,0);
    line(x-20,y,x+20,y);
    line(x,y-20,x,y+20);
  }
  
  void Update()
  {
    if(!flagLast)
    {
      x = mouseX;
      y = mouseY;
      if(mouseButton==RIGHT && flagPressed)
      {
        shift = mouse.vec().sub(lastMouse.vec());
        flagShifted = true;
      }
    }
    else 
    {
      x = mouseX;
      y = mouseY;
    }
  }
  
  PVector vec()
  {
    return new PVector(x,y);
  }
}
void mouseWheel(MouseEvent event) 
{
  mouse.flagScrolled = true;
  mouse.scroll = event.getCount();
}

/*void mouseMoved()
{
  gameCamera.ModifPosition();
}*/

void mousePressed()
{
  mouse.flagPressed = true;
  mouse.flagAllocation = true;
  mousePresPos.x = mouse.x;
  mousePresPos.y = mouse.y;
  //lastMouse.y = mouse.y;
  
  if(mouseButton==RIGHT && mouse.mode=="Null" && gameLocation.mouseIn)
  {
    cursor(MOVE);
  }
}

void mouseReleased()
{
  mouse.flagPressed=false;
  mouse.flagAllocation=false;
  
  cursor(ARROW);
}

void mouseClicked()
{
  if(mouseButton==LEFT && mouse.mode=="ObjMove" && gameLocation.mouseIn)
  {
    if(dist/rateDistancePrice < gamePoints)
    {
      for(Unit unit : own) if(unit.flagAllocate) unit.MoveOn(LocalToGlobalPos(mouse.vec()));
      gamePoints -= int(dist/rateDistancePrice);
    }
    mouse.mode = "Null";
  }
}


void DrawUpdateMouseMode()
{
  /*if(mouseButton==RIGHT && mouseMode=="Null" && gameLocation.mouseIn)
  {
    gameCamera.ModifPosition();
  }*/
  if(mouse.mode=="ObjUp1" && gamePoints > minGamePointsT1*mouse.countAllocate)
  {
    for(Unit unit : own) if(unit.flagAllocate && unit.lvl < 1) unit.lvl = 1;
    mouse.mode="Null";
    gamePoints -= minGamePointsT1*mouse.countAllocate;
  }
  if(mouse.mode=="ObjUp2" && gamePoints > minGamePointsT2*mouse.countAllocate)
  {
    for(Unit unit : own) if(unit.flagAllocate && unit.lvl < 2) unit.lvl = 2;
    mouse.mode="Null";
    gamePoints -= minGamePointsT2*mouse.countAllocate;
  }
  if(mouse.mode=="ObjUp3" && gamePoints > minGamePointsT3*mouse.countAllocate)
  {
    for(Unit unit : own) if(unit.flagAllocate && unit.lvl < 3) unit.lvl = 3;
    mouse.mode="Null";
    gamePoints -= minGamePointsT3*mouse.countAllocate;
  }
  if(mouse.mode=="ObjUp4" && gamePoints > minGamePointsT4*mouse.countAllocate)
  {
    for(Unit unit : own) if(unit.flagAllocate && unit.lvl < 4) unit.lvl = 4;
    mouse.mode="Null";
    gamePoints -= minGamePointsT4*mouse.countAllocate;
  }
  if(mouse.mode=="Null")
  {
    if(mouseButton==LEFT && mouse.flagAllocation)
    {
      if(!masKey[17].push && mouse.mode!="ObjMove" && gameLocation.mouseIn)
      {
        mouse.countAllocate = 0;
        for(Unit unit : own) unit.flagAllocate = false;
      }
      stroke(153);
      noFill();
      PVector end = new PVector();
      PVector start = new PVector();
      rect(mousePresPos.x,mousePresPos.y,mouse.x-mousePresPos.x,mouse.y-mousePresPos.y);
      // Перерасчитывание координат прямоугольника выделения, при выделении в разных сторонах от начала
      if(mouse.x>mousePresPos.x)
      {
        start.x = mousePresPos.x; 
        end.x = mouse.x;
      }
      else 
      {
        start.x = mouse.x; 
        end.x = mousePresPos.x;
      }
      if(mouse.y>mousePresPos.y)
      {
        start.y = mousePresPos.y;
        end.y = mouse.y;  
      }
      else 
      {
        start.y = mouse.y; 
        end.y = mousePresPos.y;
      }
      
      for(Unit unit : own)
        if((start.x<unit.transform.x+5 && unit.transform.x+5<end.x)&& 
           (start.y<unit.transform.y+5 && unit.transform.y+5<end.y)&& !unit.flagAllocate)
           {unit.flagAllocate = true; unit.IdAllocate = mouse.countAllocate++;}
    }
  }
  if(mouse.mode=="ObjUp")
  {
    int lvl = 0;
    for(Unit unit : own)
      if(unit.flagAllocate)
        lvl = unit.lvl;
        
    upPanel.enabled = true;
    upPanel.Draw();
    upPanel.ButtonTriggerEnabled(lvl);
    
  }else upPanel.enabled = false;
  if(mouse.mode=="ObjMove" && gameLocation.mouseIn)
  {
    fill(0);
    stroke(255);
    RelocateUnits();
    fill(255);
    text(int(dist/30), mouse.x+10, mouse.y+10);
    fill(0);
  }
}
