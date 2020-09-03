int maxRotaLvl = 4;
//----------------------------------------------------
int maxGamePoints = 2000;
float gamePoints = 1500,upPoints = 0.01;
int rateDistancePrice = 30;
int minGamePointsT1 = 10;
int minGamePointsT2 = 20;
int minGamePointsT3 = 30;
int minGamePointsT4 = 40;
//----------------------------------------------------
float dist = 0;

class Unit extends LocationObject 
{
  PVector endPosition; //вектор конечной точки движения
  PVector tendPosition; //вектор конечной точки движения
  PVector lastSpotPosition; //позиция от засвета врага
  PVector tlastSpotPosition;
  boolean flagMove = false;
  boolean flagAllocate = false;
  boolean flagSpoted = false;
  boolean flagLastSpoted = false;
  float spotRadius;
  float permament_spot_radius;
  String type;
  int IdAllocate;
  float time_to_spot;
  int spotting_time;
  int maxSpotTime;
  int points; //Пока нигде не используется, предположительно цена покупки/Уничтожения
  int lvl;
  Unit(PVector Dpos,int Dpoints,int Dlvl,String Dt,color Dc)
  {
    spotRadius = 250;
    permament_spot_radius = spotRadius*3;
    spotting_time = 1000; //10 секунд
    time_to_spot = 0;
    maxSpotTime = 300; //3 секунды 
    
    IdAllocate = 0;
    
    position = Dpos;
    lastSpotPosition = Dpos; //нескеилится !!!
    endPosition = Dpos; //нескеилится !!!
    tlastSpotPosition = new PVector(0,0); 
    tendPosition = new PVector(0,0);
    direction = new PVector(Dpos.x+10,Dpos.y);
    speed = new PVector(0,0);
    type = Dt;
    points = Dpoints;lvl=Dlvl;colr=Dc;
    
    gameLocation.AddObject(this);
  }
  void Update()
  {
    flagLastSpoted = flagSpoted;
    if(time_to_spot>0) time_to_spot--;
    //----------------------------SPOT LIGHT-----------------------------
    if(frameCount % spotting_time == 0) NewSpotLight(position.x,position.y,permament_spot_radius,4,type);
    if(type == "own")
    {
      for (Unit unit : enemy)
      {
        UnitInteraction(this,unit);
      }
    }
    if(type == "enemy")
    {
      for (Unit unit : own)
      {
        UnitInteraction(this,unit);
      }
    }
    //-------------------------------------------------------------------
    
    if(flagMove)
    {
      if(position.dist(endPosition)<=0.1)flagMove = false;
      else 
      {
        speed = endPosition.copy();
        speed.normalize(); 
        direction = PVector.sub(endPosition,position);
        direction.normalize();
        direction.setMag(0.2+0.05*(lvl+1));
        position.add(direction);
      }
    }
    UpdatePos();
    tendPosition = endPosition.copy().mult(gameCamera.GetScroll(true)).add(gameCamera.position);
    tlastSpotPosition = lastSpotPosition.copy().mult(gameCamera.GetScroll(true)).add(gameCamera.position);
  }
  void pre_pre_Draw()
  {
        fill(5,50);
    stroke(150,50);
    
    if(type == "own")
      circle(transform.x,transform.y,spotRadius*gameCamera.GetScroll(true));
    else 
      if(flagSpoted) circle(transform.x,transform.y,spotRadius*gameCamera.GetScroll(true));
    
    stroke(255);
    fill(0);
  }
  void pre_Draw()
  {
    fill(0);
    noStroke();
    
    if(type == "own")
      circle(transform.x,transform.y,spotRadius*gameCamera.GetScroll(true)-4);
    else if(flagSpoted)
      circle(transform.x,transform.y,spotRadius*gameCamera.GetScroll(true));

    
    stroke(255);
    fill(0);
  }
  void Draw()
  {
    if(type == "own")
    {
      //strokeWeight(1);
      //line(position.x,position.y,direction.x,direction.y);  //направление объекта
      stroke(255);
      if(flagSpoted) ellipse(transform.x, transform.y, 20*gameCamera.GetScroll(true),20*gameCamera.GetScroll(true));
      if(flagMove) 
      {
        line(transform.x, transform.y, tendPosition.x, tendPosition.y);
        ellipse(tendPosition.x, tendPosition.y, 5,5);
      }
      noStroke();
      fill(colr);
      rect(transform.x-5,transform.y-5,10,10);
      fill(0);
      text(lvl,transform.x-3,transform.y+4.5);
    }
    
    if(type == "enemy")
    {
      if(flagSpoted)
      {
        strokeWeight(1);
        //line(transform.x,transform.y,direction.x,direction.y);  //направление объекта
        stroke(255);
        fill(0);
        if(flagMove) 
        {
          line(transform.x, transform.y, tendPosition.x, tendPosition.y);
          ellipse(tendPosition.x, tendPosition.y, 5,5);
        }
        noStroke();
        fill(colr);
        rect(transform.x-5,transform.y-5,10,10);
        fill(0);
        text(lvl,transform.x-3,transform.y+4.5);
      }
      else 
      {  
        fill(colr,time_to_spot);
        //fill(colr,5);
        //rect(position.x-5,position.y-5,10,10);
        rect(tlastSpotPosition.x-5,tlastSpotPosition.y-5,10,10);
      }
    }
  }
  
  void MoveOn(PVector temp)
  {
    flagMove = true;
    endPosition = temp.copy();
    switch(mouse.countAllocate)    
    {
      case 2:
      switch(IdAllocate)    
      {
        case 0:
          endPosition.y-=10;
        break;
        case 1:
          endPosition.y+=10;
        break;
      }
      break;
      case 3:
      switch(IdAllocate)    
      {
        case 0:
          endPosition.y-=10;
          endPosition.x-=5;
        break;
        case 1:
          endPosition.y+=10;
          endPosition.x-=5;
        break;
        case 2:
          endPosition.x+=10;
        break;
      }
      break;
      case 4:
      switch(IdAllocate)    
      {
        case 0:
          endPosition.y-=10;
          endPosition.x-=10;
        break;
        case 1:
          endPosition.y+=10;
          endPosition.x-=10;
        break;
        case 2:
          endPosition.y-=10;
          endPosition.x+=10;
        break;
        case 3:
          endPosition.y+=10;
          endPosition.x+=10;
        break;
      }
      break;
    }
  }
  //----------------------------------------------------------------------------------------------- END CLASS
}

void AddUnit(PVector position,int points,int lvl,String type,color colr)
{
  switch(type)
  {
    case "own":   own.add(new Unit(position,points,lvl,type,colr));
    break;
    case "enemy": enemy.add(new Unit(position,points,lvl,type,colr));
    break;
  }
}

void UnitInteraction(Unit own, Unit enemy)
{
  if(own.position.dist(enemy.position) < own.spotRadius/2)
    enemy.flagSpoted = true;
  else
    if(enemy.flagLastSpoted) 
    {
      enemy.lastSpotPosition = enemy.position.copy();
      enemy.time_to_spot = enemy.spotting_time;
    }
}

void UnitSpotInteraction(PVector own, float spotRadius,  Unit enemy)
{
  if(own.dist(enemy.position) < spotRadius/2)
    enemy.flagSpoted = true;
  else
    if(enemy.flagLastSpoted) 
    {
      enemy.lastSpotPosition = enemy.position.copy();
      enemy.time_to_spot = enemy.spotting_time;
    }
}

void RelocateUnits()
{
  PVector temp;
    dist = 0;
    for (Unit unit : own)
    {
      temp = mouse.vec();
      if(unit.flagAllocate)
      {
        switch(mouse.countAllocate)    
        {
          case 2:
          switch(unit.IdAllocate)    
          {
            case 0:
              temp.y-=10;
            break;
            case 1:
              temp.y+=10;
            break;
          }
          break;
          case 3:
          switch(unit.IdAllocate)    
          {
            case 0:
              temp.y-=10;
              temp.x-=5;
            break;
            case 1:
              temp.y+=10;
              temp.x-=5;
            break;
            case 2:
              temp.x+=10;
            break;
          }
          break;
          case 4:
          switch(unit.IdAllocate)    
          {
            case 0:
              temp.y-=10;
              temp.x-=10;
            break;
            case 1:
              temp.y+=10;
              temp.x-=10;
            break;
            case 2:
              temp.y-=10;
              temp.x+=10;
            break;
            case 3:
              temp.y+=10;
              temp.x+=10;
            break;
          }
          break;
        }
        dist += unit.position.dist(temp);
        ellipse(temp.x, temp.y, 10,10);
        line(unit.transform.x, unit.transform.y, temp.x, temp.y);  
      }
    }
}
void UpdateUnits()
{
  for (Unit unit : own) unit.flagSpoted = false;
  for (Unit unit : enemy) unit.flagSpoted = false;
  
  for(Unit unit : own) unit.Update();
  for(Unit unit : enemy) unit.Update();
}
void DrawUnits()
{
  for(Unit unit : enemy) unit.pre_pre_Draw();
  for(Unit unit : enemy) unit.pre_Draw();
  
  for(Unit unit : own) unit.pre_pre_Draw();
  for(Unit unit : own) unit.pre_Draw();
  
  for(Unit unit : own) unit.Draw();
  for(Unit unit : enemy) unit.Draw();
}

void UpdateEnemyPos()
{
  for(Unit unit : enemy)
  {
    if(!unit.flagMove) unit.MoveOn(GetRandPosOn(2,0,0).setMag(20).add(unit.position).add((new PVector(0,0)).add((new PVector(width/2,height/2)).sub(unit.position).normalize().setMag(10))));
  }
}
