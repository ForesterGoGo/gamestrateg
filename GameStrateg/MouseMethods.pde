
void mouseWheel(MouseEvent event) 
{
  float scroll = event.getCount();
  gameCamera.ModifScale(scroll);
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
  
  if(mouseButton==RIGHT && mouseMode=="Null" && gameLocation.mouseIn)
  {
    cursor(MOVE);
  }
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
    if(dist/30 < gamePoints) // !!!!!!!!!!!!!!! DIST / 30 !!!!!!!!!!!!!!!!!!!!!!
    {
      for(int k=0;k<countUnitR;k++)
        if(rota[k].flagAllocate)
          rota[k].MoveOn(mouse);
      gamePoints -= int(dist/30);
    }
    mouseMode = "Null";
  }
}
