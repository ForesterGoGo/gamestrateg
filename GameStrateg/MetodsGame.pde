class Unit
{
  PVector location; //вектор положения
  PVector direction; //вектор направления
  PVector speed;
  PVector location2; //вектор конечной точки движения
  PVector lastSpotLocation;
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
  int points;
  int lvl;
  color colr;
  Unit(float DxPos,float DyPos,int Dpoints,int Dlvl,String Dt,color Dc)
  {
    spotRadius = 250;
    permament_spot_radius = spotRadius*3;
    spotting_time = 1000;
    time_to_spot = 0;
    maxSpotTime = 300; //3 секунды 
    IdAllocate = 0;
    location = new PVector(DxPos,DyPos);
    lastSpotLocation = new PVector(DxPos,DyPos);
    location2 = new PVector(DxPos,DyPos);
    direction = new PVector(DxPos+10,DyPos);
    speed = new PVector(0,0);
    type = Dt;
    points=Dpoints;lvl=Dlvl;colr=Dc;
  }
  //-----------------------------------------------------------------------------------------
  void Update()
  {
    flagLastSpoted = flagSpoted;
    if(time_to_spot>0) time_to_spot--;
    //----------------------------SPOT LIGHT-----------------------------
    if(frameCount % spotting_time == 0) NewSpotLight(location.x,location.y,permament_spot_radius,4,type);
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
    
    if(!flagMove)return;
    
    if(location.dist(location2)<=1)flagMove = false;
    else 
    {
      speed = location2.copy();
      speed.normalize(); 
      direction = PVector.sub(location2,location);
      direction.normalize();
      direction.setMag(0.2+0.05*(lvl+1));
      location.add(direction);
    }
  }
  void pre_pre_Draw()
  {
        fill(5,50);
    stroke(150,50);
    
    if(type == "own")
      circle(location.x,location.y,spotRadius);
    else 
      if(flagSpoted) circle(location.x,location.y,spotRadius);
    
    stroke(255);
    fill(0);
  }
  void pre_Draw()
  {
    fill(0);
    noStroke();
    
    if(type == "own")
      circle(location.x,location.y,spotRadius-1);
    else if(flagSpoted)
      circle(location.x,location.y,spotRadius);

    
    stroke(255);
    fill(0);
  }
  void Draw()
  {
    if(type == "own")
    {
      //strokeWeight(1);
      //line(location.x,location.y,direction.x,direction.y);  //направление объекта
      stroke(255);
      if(flagSpoted) ellipse(location.x, location.y, 20,20);
      if(flagMove) 
      {
        line(location.x, location.y, location2.x, location2.y);
        ellipse(location2.x, location2.y, 5,5);
      }
      noStroke();
      fill(colr);
      rect(location.x-5,location.y-5,10,10);
      fill(0);
      text(lvl,location.x-3,location.y+4.5);
    }
    
    if(type == "enemy")
    {
      if(flagSpoted)
      {
        strokeWeight(1);
        //line(location.x,location.y,direction.x,direction.y);  //направление объекта
        stroke(255);
        fill(0);
        if(flagMove) 
        {
          line(location.x, location.y, location2.x, location2.y);
          ellipse(location2.x, location2.y, 5,5);
        }
        noStroke();
        fill(colr);
        rect(location.x-5,location.y-5,10,10);
        fill(0);
        text(lvl,location.x-3,location.y+4.5);
      }
      else 
      {  
        fill(colr,time_to_spot);
        //fill(colr,5);
        //rect(location.x-5,location.y-5,10,10);
        rect(lastSpotLocation.x-5,lastSpotLocation.y-5,10,10);
      }
    }
  }
  
  void MoveOn(PVector temp)
  {
    flagMove = true;
    location2 = temp.copy();
    switch(countAllocate)    
    {
      case 2:
      switch(IdAllocate)    
      {
        case 0:
          location2.y-=10;
        break;
        case 1:
          location2.y+=10;
        break;
      }
      break;
      case 3:
      switch(IdAllocate)    
      {
        case 0:
          location2.y-=10;
          location2.x-=5;
        break;
        case 1:
          location2.y+=10;
          location2.x-=5;
        break;
        case 2:
          location2.x+=10;
        break;
      }
      break;
      case 4:
      switch(IdAllocate)    
      {
        case 0:
          location2.y-=10;
          location2.x-=10;
        break;
        case 1:
          location2.y+=10;
          location2.x-=10;
        break;
        case 2:
          location2.y-=10;
          location2.x+=10;
        break;
        case 3:
          location2.y+=10;
          location2.x+=10;
        break;
      }
      break;
    }
  }
  //-----------------------------------------------------------------------------------------------
}

void AddUnit(PVector location,int points,int lvl,String type,color colr)
{
  switch(type)
  {
    case "own":   own.add(new Unit(location.x,location.y,points,lvl,type,colr));
    break;
    case "enemy": enemy.add(new Unit(location.x,location.y,points,lvl,type,colr));
    break;
  }
}

void UnitInteraction(Unit own, Unit enemy)
{
  if(own.location.dist(enemy.location) < own.spotRadius/2)
    enemy.flagSpoted = true;
  else
    if(enemy.flagLastSpoted) 
    {
      enemy.lastSpotLocation = enemy.location.copy();
      enemy.time_to_spot = enemy.spotting_time;
    }
}

void UnitInteraction(PVector own, float spotRadius,  Unit enemy)
{
  if(own.dist(enemy.location) < spotRadius/2)
    enemy.flagSpoted = true;
  else
    if(enemy.flagLastSpoted) 
    {
      enemy.lastSpotLocation = enemy.location.copy();
      enemy.time_to_spot = enemy.spotting_time;
    }
}

void RelocateUnits()
{
  PVector temp;
    dist = 0;
    for (Unit unit : own)
    {
      temp = mouse.copy();
      if(unit.flagAllocate)
      {
        switch(countAllocate)    
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
        dist += unit.location.dist(temp);
        ellipse(temp.x, temp.y, 10,10);
        line(unit.location.x, unit.location.y, temp.x, temp.y);  
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
    if(!unit.flagMove) unit.MoveOn(GetRandPosOn(2,0,0).setMag(20).add(unit.location).add((new PVector(0,0)).add((new PVector(width/2,height/2)).sub(unit.location).normalize().setMag(10))));
  }
}
