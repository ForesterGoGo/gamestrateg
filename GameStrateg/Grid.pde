class GridDot extends LocationObject
{
  GridDot(int x1, int y1)
  {
    position = new PVector(x1,y1);
  }
}
//--------------------------------------------------------------------
class GridLine extends LocationObject
{
  GridDot gridDotPos;
  GridDot gridDotSize;
  GridLine(int x1, int y1, int x2, int y2, color c)
  {
    gridDotPos = new GridDot(x1,y1);
    gridDotSize = new GridDot(x2,y2);
    colr = c;
  }
  
  void Draw()
  {
    fill(colr);
    line(gridDotPos.transform.x, gridDotPos.transform.y, gridDotSize.transform.x, gridDotSize.transform.y);
  }
  void UpdatePos()
  {
    gridDotPos.UpdatePos();
  }
}
//--------------------------------------------------------------------
class Grid extends LocationObject
{
  ArrayList<GridLine> gridLines;
  Grid(int w, int h, color c)
  {
    gridLines = new ArrayList<GridLine>();
    enabled = false;
    dSize = new PVector(w,h);
    colr = c;
    type = "Grid";
    
    gameLocation.AddObject(this);
    
    int countX = width/int(dSize.x);
    int countY = height/int(dSize.y);
    
    int sumX = 0;  
    int sumY = 0;
    
    for(int i=1;i<dSize.x;i++) 
    {
      sumX += countX;
      gridLines.add(new GridLine(sumX, 0, sumX, height, c));
    }
    for(int i=1;i<dSize.y;i++) 
    {
      sumY += countY; 
      gridLines.add(new GridLine(0, sumY, width, sumY, c));
    }
    this.UpdatePos();
  }
  void Draw()
  {
    for (GridLine gridLine : gridLines) gridLine.Draw();
  }
  void UpdatePos()
  {
    for(GridLine gridLine : gridLines) gridLine.UpdatePos();
  }
}
/*class Grid
{
  boolean enabled;
  boolean flagEnabledExtremeLine;
  boolean flagEnabledSpaceAround;
  boolean flagEnabledText;
  boolean flagInteractionCameraScale;
  int spaceAround;
  boolean flagDistributionlines;
  int wLines;
  int hLines;
  
  color colr;
  color textColr;
  
  Grid(int w, int h,boolean f, color c)
  {
    enabled = false;
    flagInteractionCameraScale = false;
    flagEnabledExtremeLine = false;
    flagEnabledSpaceAround = false;
    spaceAround = 0;
    
    wLines = w;
    hLines = h;
    flagDistributionlines = f;
    colr = c;
  }
  void Update()
  {
    
  }
  void Draw()
  {
    float scale = 1;
    if(flagInteractionCameraScale)
      scale = gameCamera.scale;
    PVector center = new PVector(width*scale/2 - width/2,height*scale/2 - height/2);
    stroke(colr);
    int countX = width/wLines;
    int countY = height/hLines;
    
    int sumX = 0;  
    int sumY = 0;
    
    for(int i=1;i<wLines;i++) 
    {
      sumX += countX;
      line(sumX*scale-center.x+gameCamera.position.x,0*scale-center.y+gameCamera.position.y,sumX*scale-center.x+gameCamera.position.x,height*scale-center.y+gameCamera.position.y);
      if(flagEnabledText)text(i,sumX+5,15);
    }
    for(int i=1;i<hLines;i++) 
    {
      sumY += countY;
      line(0*scale-center.x+gameCamera.position.x,sumY*scale-center.y+gameCamera.position.y,width*scale-center.x+gameCamera.position.x,sumY*scale-center.y+gameCamera.position.y);
      if(flagEnabledText)text(i,5,sumY+15);
    }
  }
}*/
