
void mouseWheel(MouseEvent event) 
{
  /*float scroll = event.getCount();
  gameCamera.ModifScale(scroll);*/
}

/*void mouseMoved()
{
  gameCamera.ModifPosition();
}*/

void mousePressed()
{
  flagMousePressed=true;
  flagAllocationMouse=true;
  lastMousePos.x = mouse.x;
  lastMousePos.y = mouse.y;
  
  /*if(mouseButton==RIGHT && mouseMode=="Null" && gameLocation.mouseIn)
  {
    cursor(MOVE);
  }*/
}

void mouseReleased()
{
  flagMousePressed=false;
  flagAllocationMouse=false;
  
  cursor(ARROW);
}

void mouseClicked()
{
  if(mouseButton==LEFT && mouseMode=="ObjMove" && gameLocation.mouseIn)
  {
    if(dist/rateDistancePrice < gamePoints)
    {
      for(Unit unit : own) if(unit.flagAllocate) unit.MoveOn(mouse);
      gamePoints -= int(dist/rateDistancePrice);
    }
    mouseMode = "Null";
  }
}


void DrawUpdateMouseMode()
{
  /*if(mouseButton==RIGHT && mouseMode=="Null" && gameLocation.mouseIn)
  {
    gameCamera.ModifPosition();
  }*/
  if(mouseMode=="ObjUp1" && gamePoints > minGamePointsT1*countAllocate)
  {
    for(Unit unit : own) if(unit.flagAllocate && unit.lvl < 1) unit.lvl = 1;
    mouseMode="Null";
    gamePoints -= minGamePointsT1*countAllocate;
  }
  if(mouseMode=="ObjUp2" && gamePoints > minGamePointsT2*countAllocate)
  {
    for(Unit unit : own) if(unit.flagAllocate && unit.lvl < 2) unit.lvl = 2;
    mouseMode="Null";
    gamePoints -= minGamePointsT2*countAllocate;
  }
  if(mouseMode=="ObjUp3" && gamePoints > minGamePointsT3*countAllocate)
  {
    for(Unit unit : own) if(unit.flagAllocate && unit.lvl < 3) unit.lvl = 3;
    mouseMode="Null";
    gamePoints -= minGamePointsT3*countAllocate;
  }
  if(mouseMode=="ObjUp4" && gamePoints > minGamePointsT4*countAllocate)
  {
    for(Unit unit : own) if(unit.flagAllocate && unit.lvl < 4) unit.lvl = 4;
    mouseMode="Null";
    gamePoints -= minGamePointsT4*countAllocate;
  }
  if(mouseMode=="Null")
  {
    if(mouseButton==LEFT && flagAllocationMouse)
    {
      if(!masKey[17].push && mouseMode!="ObjMove" && gameLocation.mouseIn)
      {
        countAllocate = 0;
        for(Unit unit : own) unit.flagAllocate = false;
      }
      stroke(153);
      noFill();
      PVector end = new PVector();
      PVector start = new PVector();
      rect(lastMousePos.x,lastMousePos.y,mouse.x-lastMousePos.x,mouse.y-lastMousePos.y);
      // Перерасчитывание координат прямоугольника выделения, при выделении в разных сторонах от начала
      if(mouse.x>lastMousePos.x)
      {
        start.x = lastMousePos.x; 
        end.x = mouse.x;
      }
      else 
      {
        start.x = mouse.x; 
        end.x = lastMousePos.x;
      }
      if(mouse.y>lastMousePos.y)
      {
        start.y = lastMousePos.y;
        end.y = mouse.y;  
      }
      else 
      {
        start.y = mouse.y; 
        end.y = lastMousePos.y;
      }
      
      for(Unit unit : own)
        if((start.x<unit.location.x+5 && unit.location.x+5<end.x)&& 
           (start.y<unit.location.y+5 && unit.location.y+5<end.y)&& !unit.flagAllocate)
           {unit.flagAllocate = true; unit.IdAllocate = countAllocate++;}
    }
  }
  if(mouseMode=="ObjUp")
  {
    int lvl = 0;
    for(Unit unit : own)
      if(unit.flagAllocate)
        lvl = unit.lvl;
        
    upPanel.enabled = true;
    upPanel.Draw();
    upPanel.ButtonTriggerEnabled(lvl);
    
  }else upPanel.enabled = false;
  if(mouseMode=="ObjMove" && gameLocation.mouseIn)
  {
    fill(0);
    stroke(255);
    RelocateUnits();
    fill(255);
    text(int(dist/30), mouse.x+10, mouse.y+10);
    fill(0);
  }
}
