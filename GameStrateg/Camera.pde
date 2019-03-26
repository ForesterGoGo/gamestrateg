class Camera
{
  int id;
  PVector position;
  float scale = 0;
  int scaleMax;
  int scaleMin;
  Camera(PVector Dposition, int Dscale, int DsMin, int DsMax)
  {
    position = Dposition;
    scale = Dscale;
    scaleMax = DsMax;
    scaleMin = DsMin;
  }
  void Update()
  {
    
  }
  void ModifPosition()
  {
    PVector centere = new PVector(width/2,height/2);
    PVector temp = PVector.sub(mouse.copy(),centere).normalize();
    position = PVector.sub(position,temp);
  }
  void ModifScale(float scroll)
  {
    switch(int(scroll))
    {
      case -1: if(scale > scaleMin) scale += scroll/10;
      break;
      case 1: if(scale < scaleMax) scale += scroll/10;
      break;
    }
    scale = correct(scale);
    PVector centere = new PVector(width/2,height/2);
    PVector temp = PVector.sub(mouse.copy(),centere).div(scroll*10);
    position = PVector.sub(position,temp);
  //if(scale < scaleMax && scale > scaleMin){ scale += scroll/10; }
    //println("(1: "+scroll+" 2: "+int(scroll));
  }
}
