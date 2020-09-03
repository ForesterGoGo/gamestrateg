class Object
{
  int id;
  PVector position;
  PVector lastPosition;
  PVector speed;
  PVector direction;
  PVector transform;
  
  PVector dSize;
  PVector tSize;
  
  float dRadius;
  float tRadius;
  
  boolean enabled;
  color colr;
  Object(){}
}


class LocationEffect extends Object
{
  String type;
  boolean flagTransSize;
  LocationEffect()
  {
    id = gameLocation.locationEffects.size();
    position = new PVector(0,0);
    lastPosition = new PVector(0,0);
    speed = new PVector(0,0);
    transform = new PVector(0,0);
    dSize = new PVector(0,0);
    tSize = new PVector(0,0);
    colr = color(255);
  }
  void UpdatePos()
  {
    transform = position.copy().mult(gameCamera.GetScroll(true)).add(gameCamera.position);
    tRadius = dRadius * gameCamera.GetScroll(true);  
    tSize = dSize.copy().mult(gameCamera.GetScroll(true)).add(gameCamera.position);
  }
}


class LocationObject extends Object
{
  String type;
  boolean flagTransSize;
  LocationObject()
  {
    id = gameLocation.locationObjects.size();
    position = new PVector(0,0);
    lastPosition = new PVector(0,0);
    speed = new PVector(0,0);
    direction = new PVector(0,0);
    transform = new PVector(0,0);
    dSize = new PVector(0,0);
    tSize = new PVector(0,0);
    colr = color(255);
    flagTransSize = false;
  }
  void UpdatePos()
  {
    transform = position.copy().mult(gameCamera.GetScroll(true)).add(gameCamera.position);
    tRadius = dRadius * gameCamera.GetScroll(true);  
    tSize = dSize.copy().mult(gameCamera.GetScroll(true)).add(gameCamera.position);
  }

  void Draw(){};
}
