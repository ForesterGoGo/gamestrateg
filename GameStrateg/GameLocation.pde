class GameLocation
{
  PVector position;
  PVector dSize;
  PVector accessArea;
  PVector accessSize;
  boolean mouseIn = false;
  ArrayList<SpotLight> spotLights;
  ArrayList<LocationObject> locationObjects;
  ArrayList<LocationEffect> locationEffects;
  Frame frame;
  
  GameLocation(PVector Dposition,PVector Dsize)
  {
    spotLights = new ArrayList<SpotLight>();
    locationObjects = new ArrayList<LocationObject>();
    locationEffects = new ArrayList<LocationEffect>();
    position = Dposition;
    dSize = Dsize;
    accessArea = Dposition;
    accessSize = Dsize;
  }
  void FrameInit()
  {
    frame = new Frame();
  }
  void AddObject(LocationObject temp)
  {
    locationObjects.add(temp);
  }
  void AddEffect(LocationEffect temp)
  {
    locationEffects.add(temp);
  }
  void Update()
  {
    if((accessArea.x<=mouse.x && accessSize.x>mouse.x)&& 
       (accessArea.y<=mouse.y && accessSize.y>mouse.y)) mouseIn = true;
    else mouseIn = false;
  }
  void Draw()
  {
    for (LocationObject locationObject : locationObjects) locationObject.Draw();
    frame.Draw();
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
        dSize.y -= countSub;
        break;
      case "D":
        dSize.x -= countSub;
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

boolean IsZero(PVector temp)
{
  if(temp.x == 0 && temp.y == 0) return true;
  return false;
}
