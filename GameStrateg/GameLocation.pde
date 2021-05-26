class GameLocation
{
  PVector position;
  PVector dSize;
  PVector accessArea;
  PVector accessSize;
  boolean mouseIn = false;
  Map gameMap;
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
  void GameMapInit()
  {
    gameMap = new Map(100,100,64,64); //(кол-во в длину, кол-во в высоту, длиная ячейки, высота ячейки, цвет)
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
    
    gameMap.Update();
  }
  void Draw()
  {
    for (LocationObject locationObject : locationObjects) locationObject.Draw();
    frame.Draw();
    gameMap.Draw();
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

class Cell extends LocationObject
{
  Cell(){}
  void Draw(){}
  void Update(){}
}
class Line extends LocationObject 
{
  int number;
  Line(PVector pos, PVector size, int i)
  {
    position = pos;
    dSize = size;
    number = i;
  }
  void Update()
  {
  }
  void Draw()
  {
    //if(gameCamera.InCamera(transform,tSize))
    if(number%gameCamera.GetReScroll()==0)line(transform.x,transform.y,tSize.x,tSize.y);
  }
}

class Map
{
  boolean enabled;
  boolean flagInteractionCameraScale;
  boolean flagGridBorder;
  int countX;
  int countY;
  int longX;
  int longY;
  ArrayList <Cell> cells;
  ArrayList <Line> lines;
  
  PVector position;
  PVector transform;
  PVector dSize;
  PVector tSize;
  
  Map(int w, int h, int lw, int lh)
  {
    cells = new ArrayList<Cell>();
    lines = new ArrayList<Line>();
    /*for(int i=0;i<w;i++)
      for(int j=0;j<h;j++)
      {
        cells.add(new Cell(i,j,0));
      }*/
    countX = w;
    countY = h;
    longX = lw;
    longY = lh;
    gameLocation.frame.position = new PVector(0,0);
    gameLocation.frame.dSize = new PVector(countX*longX,countY*longY);  
    int numberX = 1;
    int numberY = 1;
    for(int x=1;x<countX;x++) 
    {
      lines.add(new Line(new PVector(longX*x,0),new PVector(longX*x,countY*longY),numberY++));  
      for(int y=1;y<countY;y++) 
      {
        lines.add(new Line(new PVector(0,longY*y),new PVector(countX*longX,longY*y),numberX++));
      }
    }
  }

  void Update()
  {
    for(Line line : lines)
    {
      line.UpdatePos();
      line.Update();
    }
  }
  void Draw()
  {
    fill(0);

    //PVector toCenter = new PVector(width/2-(countX*longX)/2,height/2-(countY*longY)/2);
    stroke(color(100));
    //if(flagGridBorder){rect(position.x,position.y,countX*longX,countY*longY); rect(position.x-2,position.y-2,countX*longX+4,countY*longY+4);}
   
    for(Line line : lines)
    {
      line.Draw();
    }

  }
}
