class Camera
{
  int id;
  PVector position;
  float[] scrolls = {1, 0.5, 0.25, 0.125, 0.0625, 0.03125};
  int countScroll;
  int lastScroll;
  PVector frame,frame2;
  Camera(PVector Dposition, int scale)
  {
    position = Dposition;
    countScroll = lastScroll = scale;
    frame = new PVector(0,0);
    frame2 = new PVector(width,height);
  }
  void Update()
  {
    if(mouse.flagScrolled)
    {
      if(mouse.scroll<0) 
      {
        if(countScroll>0) countScroll--;
      }
      else 
      {
        if(countScroll<scrolls.length-1) countScroll++; 
      }
      position.sub(mouse.vec()).mult(gameCamera.GetScroll(false)).add(mouse.vec());
      mouse.flagScrolled = false;
    } 
    
    if(mouse.flagShifted)
    {
      position.add(mouse.shift.copy());
      mouse.flagShifted = false;
    }
    
    frame = LocalToGlobalPos(new PVector(0,0));
    frame2 = LocalToGlobalPos(new PVector(width,height));
  }
  float GetScroll(boolean flag)
  {
    float step = 1;
    float temp = scrolls[countScroll]-scrolls[lastScroll];
    if(!flag)
    {
      if(temp < 0) step = 0.5;
      if(temp > 0) step = 2;
    }
    else
      step = scrolls[countScroll];
      
    return step;
  }
  
  float GetReScroll()
  {
    return 1/scrolls[countScroll];
  }
  /*Boolean InCamera(PVector start, PVector end) НУЖНО ПОЧИНИТЬ!
  {
    boolean flag = true;
    if(!(frame2.x>start.x && start.x>frame.x) && !(frame2.y>start.y && start.y>frame.y)) flag = false;
    if(!(frame2.x>end.x && end.x>frame.x) && !(frame2.y>end.y && end.y>frame.y)) flag = false;

    return flag;
  }*/
}
PVector LocalToGlobalPos(PVector temp)
{
  return temp.copy().sub(gameCamera.position).div(gameCamera.GetScroll(true));
}
PVector GlobalToLocalPos(PVector temp)
{
  return temp.copy().mult(gameCamera.GetScroll(true)).add(gameCamera.position);
}
