interface TypeButton 
{
  int
  CLICABLE  = 0, 
  FLAG      = 1, 
  GROUPFLAG = 2;
}
class Button
{
  int id;
  PVector position;
  int type = 0;
  String name;
  color colr;
  color colrPush;
  color colrMouseIn;
  color colrDeactivated;
  boolean push = false;
  boolean mouseIn = false;
  boolean enabled = true;
  boolean deactivated = true;
  Button(PVector Dposition, int Dtype, String Dname, color Dcolr, color DcolrPush, color DcolrMouseIn, color DcolrDeactivated)
  {
    id = ++window.countButton;
    position = Dposition;
    type = Dtype;
    colr = Dcolr;
    colrPush = DcolrPush;
    colrMouseIn = DcolrMouseIn;
    name = Dname;
    colrDeactivated = DcolrDeactivated;
  };
  void Draw()
  {
    if(enabled) return;
    if(deactivated) fill(colrPush);
    else 
      if(mouseIn)
         if(push) fill(colrMouseIn);
         else fill(colrPush);
      else fill(colr);
    rect(position.x,position.y,40,40);
  }
}
class Panel
{
  int id;
  boolean enabled;
  PVector position;
  int type;
  int countButton;
  boolean flag;
  int IdAllocate = 0;
  color colr;
  Button[] Button;
  int currentCountButton = 0;
  Panel(PVector Dposition,int Dtype,color Dc, int DcountButton)
  {
    id = window.countPanel++;
    position = Dposition;
    type = Dtype;
    colr = Dc;
    countButton = DcountButton;
    Button = new Button[countButton];
    enabled = false;
  }
  void AddButton(PVector v, int t, String n, color c, color c_p, color c_m)
  {
    if(currentCountButton < countButton) Button[currentCountButton++] = new Button(v,t,n,c,c_p,c_m,color(100,100,100));
  }
  void AddButton(PVector v, int t, String n, color c, color c_p, color c_m, color c_d)
  {
    if(currentCountButton < countButton) Button[currentCountButton++] = new Button(v,t,n,c,c_p,c_m,c_d);
  }
  void Draw()
  {
    if(enabled)
    {
      for(int i=0;i<currentCountButton;i++)
        Button[i].Draw();
    }
  }
  void ActivateButtons()
  {
    for(int i=0;i<currentCountButton;i++)
        Button[i].deactivated = false;
  }
  void ActivateButtons(int[] mes)
  {
    for(int i=0;i<mes.length;i++)
        Button[mes[i]].deactivated = false;
  }
  void ButtonTriggerEnabled(int enblID)
  {
    for(int i=0;i<4;i++)
      upPanel.Button[i].enabled = false;
    if(enblID >= 4) return;
    upPanel.Button[enblID].enabled = true;
  }
}
void DrawGamePanel()
{
  if(gamePanel.enabled)
  {
    gamePanel.Draw();
    // облать игровой панели
    stroke(200);
    noFill();
    rect(0,height-40,width,40);
    noStroke();
  }
}
void UpdatePanels()
{
  if(gamePanel.enabled)
  {
   //Проход по всем кнопкам в панели, проверка на глобальные состояния и логику
   for(int i=0;i<gamePanel.currentCountButton;i++)
    {
      for(int k=1;k<4;k++)
        if(gamePanel.Button[i].name == "ObjUp"+k)
          if(mouse.countAllocate > 1) 
            gamePanel.Button[i].enabled = true;
          else 
            gamePanel.Button[i].enabled = false;
      
      if(gamePanel.Button[i].position.x < mouse.x && gamePanel.Button[i].position.y < mouse.y && 
        gamePanel.Button[i].position.x+40 > mouse.x && gamePanel.Button[i].position.y+40 > mouse.y &&
        gamePanel.Button[i].enabled)
        {
          gamePanel.Button[i].mouseIn = true;
          
          if(mousePressed)
          {
            mouse.mode = gamePanel.Button[i].name;
            gamePanel.Button[i].push = true;
          }
          else gamePanel.Button[i].push = false;
        }
        else gamePanel.Button[i].mouseIn = false;
    }
  }
  
  if(upPanel.enabled)
  {
    for(int i=0;i<upPanel.currentCountButton;i++)
    {
      if(upPanel.Button[i].enabled)
      {
        if(upPanel.Button[i].position.x < mouse.x && upPanel.Button[i].position.y < mouse.y && 
          upPanel.Button[i].position.x+40 > mouse.x && upPanel.Button[i].position.y+40 > mouse.y)
        {
          if(mousePressed)
          {
            mouse.mode = upPanel.Button[i].name;
            upPanel.Button[i].push = true;
          }
          else upPanel.Button[i].push = false;
          
          upPanel.Button[i].mouseIn = true;
        }
        else upPanel.Button[i].mouseIn = false;
      }
    }
  }
}


void DrawGamePoints()
{
  textSize(100);
  int temp = int(gamePoints);
  float temp2 = textWidth(str(temp))*1.3;
  text(temp, 100, height-50);
  textSize(50); 
  text("+"+upPoints, temp2+50, height-50);
  textSize(12); 
}

void UpdateGamePoints()
{
  if(gamePoints<maxGamePoints)gamePoints+=upPoints;
}
