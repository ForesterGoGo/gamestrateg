class Rota
{
  int id;
  PVector location; //вектор положения
  PVector direction; //вектор направления
  PVector speed;
  PVector location2; //вектор конечной точки движения
  boolean flagMove = false;
  boolean flagAllocate = false;
  int IdAllocate = 0;
  int points;
  int lvl;
  int type;
  color colr;
  Rota(int Did,float DxPos,float DyPos,int Dpoints,int Dlvl,int Dtype,color Dc)
  {
    id = Did;
    location = new PVector(DxPos,DyPos);
    location2 = new PVector(DxPos,DyPos);
    direction = new PVector(DxPos+10,DyPos);
    speed = new PVector(0,0);
    points=Dpoints;lvl=Dlvl;type=Dtype;colr=Dc;
  }
  //-----------------------------------------------------------------------------------------
  void Update()
  {
    /*if(flagAllocate) colr = color(150);
    else if((location.x+5>mouse.x && location.x-5<mouse.x)&& 
             (location.y+5>mouse.y && location.y-5<mouse.y)){colr = color(0,255,0);}
    else colr = color(255);*/
    
    if(!flagMove)return;
    
    if(location.dist(location2)<=1)flagMove = false;
    else 
    {
      speed = location2.copy();
      speed.normalize(); 
      direction = PVector.sub(location2,location);
      direction.normalize();
      direction.setMag(0.2);
      location.add(direction);
    }
  }
  void Draw()
  {
    //strokeWeight(4);
    //line(location.x,location.y,location.x+speed.x,location.y+speed.y);  //направление объекта
    strokeWeight(1);
    fill(colr);
    rect(location.x-5,location.y-5,10,10);
    fill(0);
    text(id,location.x-3,location.y+4.5);
    if(flagMove) 
    {
      ellipse(location2.x, location2.y, 10,10);
      line(location.x, location.y, location2.x, location2.y);
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

void Addr(PVector location,int points,int lvl,int type,color colr)
{
   rota[countUnitR++] = new Rota(countUnitR,location.x,location.y,points,lvl,type,colr);
}
void Adde(PVector location,int points,int lvl,int type,color colr)
{
   enemy[countUnitE++] = new Rota(countUnitE,location.x,location.y,points,lvl,type,colr);
}

void DrawUnits()
{
  for(int i=0;rota[i]!=null;i++)
  {
    stroke(255);
    rota[i].Update();
    rota[i].Draw();
    noStroke();
  }
  
  for(int i=0;enemy[i]!=null;i++)
  {
    stroke(255);
    enemy[i].Update();
    enemy[i].Draw();
    noStroke();
  }
}

void UpdateEnemyRandPos()
{
  for(int i=0;enemy[i]!=null;i++)
  {
    if(!enemy[i].flagMove) enemy[i].MoveOn(GetRandPosOn(2,0,0).setMag(40).add(enemy[i].location));
  }
}
PVector GetRandPosOn(int type,int w, int h)
{
  PVector temp = new PVector();
  switch(type)
  {
    case 1:temp.x = random(w); temp.y = random(h);break;
    case 2:temp.x = random(-10,10); temp.y = random(-10,10);break;
  }
  return temp;
}

void DrawUpdateMouseMode()
{
  if(mouseButton==RIGHT && mouseMode=="Null" && gameLocation.mouseIn)
  {
    gameCamera.ModifPosition();
  }
  if(mouseMode=="ObjUp1" || mouseMode=="ObjUp2" || mouseMode=="ObjUp3" || mouseMode=="ObjUp4")
  {
    for(int k=0;k<countUnitR;k++) if(rota[k].flagAllocate && rota[k].lvl < maxRotaLvl) rota[k].lvl++;
    mouseMode="Null";
  }
  if(mouseMode=="Null")
  {
    if(mouseButton==LEFT && flagAllocationMouse)
    {
      if(!keyCtrl && mouseMode!="ObjMove" && gameLocation.mouseIn)
      {
        countAllocate = 0;
        for(int k=0;k<countUnitR;k++)rota[k].flagAllocate = false;
      }
      stroke(153);
      noFill();
      rect(lastMousePos.x,lastMousePos.y,mouse.x-lastMousePos.x,mouse.y-lastMousePos.y);
      for(int k=0;k<countUnitR;k++)
        if((rota[k].location.x+5>lastMousePos.x && rota[k].location.x+5<mouse.x)&& 
           (rota[k].location.y+5>lastMousePos.y && rota[k].location.y+5<mouse.y)&& !rota[k].flagAllocate)
           {rota[k].flagAllocate = true; rota[k].IdAllocate = countAllocate++;}
    }
  }
  if(mouseMode=="ObjUp")
  {
    int lvl = 0;
    for(int k=0;k<countUnitR;k++)
      if(rota[k].flagAllocate)
        lvl = rota[k].lvl;
        
    upPanel.enabled = true;
    upPanel.Draw();
    upPanel.ButtonTriggerEnabled(lvl);
    
  }else upPanel.enabled = false;
  if(mouseMode=="ObjMove" && gameLocation.mouseIn)
  {
    fill(0);
    stroke(255);
    PVector temp;
    dist = 0;
    for(int k=0;k<countUnitR;k++)
    {
      temp = mouse.copy();
      if(rota[k].flagAllocate)
      {
        switch(countAllocate)    
        {
          case 2:
          switch(rota[k].IdAllocate)    
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
          switch(rota[k].IdAllocate)    
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
          switch(rota[k].IdAllocate)    
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
        dist += rota[k].location.dist(temp);
        ellipse(temp.x, temp.y, 10,10);
        line(rota[k].location.x, rota[k].location.y, temp.x, temp.y);  
      }
    }
    fill(255);
    text(int(dist/30), mouse.x+10, mouse.y+10);
    fill(0);
  }
}
float correct(float temp)
{
  temp*=100;
  temp = round(temp);
  return temp/100;
}
void UpdateMouseModeOnKey()
{
  if(mouseMode == "ObjUp")
  {
    if(key1)mouseMode = "ObjUp1";
    if(key2)mouseMode = "ObjUp2";
    if(key3)mouseMode = "ObjUp3";
    if(key4)mouseMode = "ObjUp4";
  }
  else
  {
    if(key1)mouseMode = "ObjMove";
    if(key2)mouseMode = "ObjUp";
    if(key3)mouseMode = "ObjAttack";
    if(key4)mouseMode = "ObjUltAttack"; 
  }
}
