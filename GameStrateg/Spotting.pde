class SpotLight extends LocationEffect
{
  float permamentSpotRadius;
  float currentRadius;
  float spotStep;
  float spotDecline;
  SpotLight(float x, float y, float pSR, float sS, String T)
  {
    position = new PVector(x,y);
    permamentSpotRadius = pSR;
    dRadius = 0;
    spotDecline = 10; //??
    spotStep = sS;
    type = T;
    gameLocation.AddEffect(this);
  }
  boolean Update()
  {
    UpdatePos();
    if(currentRadius < permamentSpotRadius) 
    {  
      currentRadius+=spotStep;
      if(type == "own")
      {
        for (Unit unit : enemy)
        {
          UnitSpotInteraction(position,currentRadius,unit);
        }
      }
      if(type == "enemy")
      {
        for (Unit unit : own)
        {
          UnitSpotInteraction(position,currentRadius,unit);
        }
      }
      return false;
    }
    else return true;
  }
  void Draw()
  {
    if(permamentSpotRadius/10 > permamentSpotRadius-currentRadius) spotDecline--; //!!!!!!!
    fill(255,spotDecline*5);
    noStroke();
    circle(transform.x,transform.y,currentRadius*gameCamera.GetScroll(true));
    noFill();
    stroke(100,25);
    circle(transform.x,transform.y,permamentSpotRadius*gameCamera.GetScroll(true));
  }
}
void UpdateSpotLight()
{
  for (int i = 0; i < gameLocation.spotLights.size(); i++) 
  {
    SpotLight spot = gameLocation.spotLights.get(i);
    if(spot.Update()) gameLocation.spotLights.remove(i);
  }
}

// DrawSpotLiht - Draw spot light
void DrawSpotLight()
{
  for (SpotLight spot : gameLocation.spotLights) spot.Draw();
}


void NewSpotLight(float x, float y, float pSR, float sS, String type)
{
  gameLocation.spotLights.add(new SpotLight(x,y,pSR,sS,type));
}
