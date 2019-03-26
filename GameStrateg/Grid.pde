class Grid
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
}
