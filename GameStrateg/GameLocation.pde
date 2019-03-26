class GameLocation
{
  PVector position;
  PVector size;
  PVector accessArea;
  PVector accessSize;
  boolean mouseIn = false;
  GameLocation(PVector Dposition,PVector Dsize)
  {
    position = Dposition;
    size = Dsize;
    accessArea = Dposition;
    accessSize = Dsize;
  }
  void Update()
  {
    if((accessArea.x<=mouse.x && accessSize.x>mouse.x)&& 
       (accessArea.y<=mouse.y && accessSize.y>mouse.y)) mouseIn = true;
    else mouseIn = false;
  }
  void SubArea(String direction, int countSub)
  {
    switch(direction)
    {
      case "W":
        position.y += countSub;
        break;
      case "A":
        position.x += countSub;
        break;
      case "S":
        size.y -= countSub;
        break;
      case "D":
        size.x -= countSub;
        break;
    }
  }
}
