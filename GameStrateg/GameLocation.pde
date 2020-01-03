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

float correct(float temp)
{
  temp*=100;
  temp = round(temp);
  return temp/100;
}

PVector GetRandPosOn(int type,int w, int h)
{
  PVector temp = new PVector();
  switch(type)
  {
    case 1:temp.x = random(w); temp.y = random(h);break;
    case 2:temp.x = random(-5,5); temp.y = random(-5,5);break;
  }
  return temp;
}
