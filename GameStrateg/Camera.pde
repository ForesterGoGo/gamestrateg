class Camera
{
  int id;
  PVector position;
  float[] scrolls = {1, 0.5, 0.25, 0.125, 0.0625, 0.03125};
  int countScroll;
  int lastScroll;
  Camera(PVector Dposition, int scale)
  {
    position = Dposition;
    countScroll = lastScroll = scale;
  }
  void Update()
  {
    if(mouse.flagScrolled)
    {
      if(mouse.scroll>0) 
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
}
PVector LocalToGlobalPos(PVector temp)
{
  return temp.copy().sub(gameCamera.position).div(gameCamera.GetScroll(true));
}
PVector GlobalToLocalPos(PVector temp)
{
  return temp.copy().mult(gameCamera.GetScroll(true)).add(gameCamera.position);
}
