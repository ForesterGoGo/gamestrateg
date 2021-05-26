class Frame extends LocationObject 
{
  Frame()
  {
    position = new PVector(0,0);
    dSize = new PVector(width,height);
    type = "Frame";
    
    gameLocation.AddObject(this);
  }
  void Draw()
  {
    noFill();
    stroke(255);
    rect(transform.x, transform.y, tSize.x-transform.x, tSize.y-transform.y);
    fill(255,0,0);
  }
  void UpdatePos()
  {
    transform = position.copy().mult(gameCamera.GetScroll(true)).add(gameCamera.position);
    tSize = dSize.copy().mult(gameCamera.GetScroll(true)).add(gameCamera.position);
  }
}
