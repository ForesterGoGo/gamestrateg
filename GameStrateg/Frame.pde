class Frame extends LocationObject 
{
  Frame()
  {
    //position = new PVector(0,0);
    transform = new PVector(0,0);
    //dSize = new PVector(width,height);
    dSize = new PVector(width,height);
    type = "Frame";
    flagTransSize = true;
    
    gameLocation.AddObject(this);
  }
  void Draw()
  {
    noFill();
    stroke(255);
    rect(transform.x, transform.y, tSize.x-transform.x, tSize.y-transform.y);
    ellipse(transform.x,transform.y,10,10);
    fill(255,0,0);
    ellipse(tSize.x,tSize.y,10,10);
  }
  void UpdatePos()
  {
    transform = position.copy().mult(gameCamera.GetScroll(true)).add(gameCamera.position);
    tSize = dSize.copy().mult(gameCamera.GetScroll(true)).add(gameCamera.position);
  }
}
