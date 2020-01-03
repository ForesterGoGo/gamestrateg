ArrayList<SpotLight> spotLight = new ArrayList<SpotLight>();
class SpotLight 
{
  float x;
  float y;
  float permamentSpotRadius;
  float currentRadius;
  float spotStep;
  float spotDecline;
  String type;
  SpotLight(float X, float Y, float pSR, float sS, String T)
  {
    x = X;
    y = Y;
    permamentSpotRadius = pSR;
    currentRadius = 0;
    spotDecline = 10;
    spotStep = sS;
    type = T;
  }
  boolean Update()
  {
    if(currentRadius < permamentSpotRadius) 
    {  
      currentRadius+=spotStep;
      if(type == "own")
      {
        for (Unit unit : enemy)
        {
          UnitInteraction((new PVector(x,y)),currentRadius,unit);
        }
      }
      if(type == "enemy")
      {
        for (Unit unit : own)
        {
          UnitInteraction(new PVector(x,y),currentRadius,unit);
        }
      }
      return false;
    }
    else return true;
  }
  void Draw()
  {
    if(permamentSpotRadius/10 > permamentSpotRadius-currentRadius) spotDecline--;
    fill(255,spotDecline);
    noStroke();
    circle(x,y,currentRadius);
    noFill();
    stroke(100,25);
    circle(x,y,permamentSpotRadius);
  }
}
void UpdateSpotLight()
{
  for (int i = 0; i < spotLight.size(); i++) 
  {
    SpotLight spot = spotLight.get(i);
    if(spot.Update()) spotLight.remove(i);
  }
}

// DrawSpotLiht - Draw spot light
void DrawSpotLight()
{
  for (SpotLight spot : spotLight) spot.Draw();
}


void NewSpotLight(float x, float y, float pSR, float sS, String type)
{
  spotLight.add(new SpotLight(x,y,pSR,sS,type));
}
