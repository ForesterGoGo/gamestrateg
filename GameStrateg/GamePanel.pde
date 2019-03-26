interface TypeButtonPanel 
{
  int
  CLICABLE  = 0, 
  FLAG      = 1, 
  GROUPFLAG = 2;
}
class ButtonPanel
{
  int id;
  PVector position;
  int type = 0;
  String name;
  color colr;
  color colrPush;
  color colrMouseIn;
  color colrDisabled;
  boolean push = false;
  boolean mouseIn = false;
  boolean enabled = true;
  ButtonPanel(PVector Dposition, int Dtype, String Dname, color Dcolr, color DcolrPush, color DcolrMouseIn, color DcolrDisabled)
  {
    id = ++countButtonPanel;
    position = Dposition;
    type = Dtype;
    colr = Dcolr;
    colrPush = DcolrPush;
    colrMouseIn = DcolrMouseIn;
    name = Dname;
    colrDisabled = DcolrDisabled;
  };
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
  ButtonPanel[] buttonPanel;
  int currentCountButton = 0;
  Panel(PVector Dposition,int Dtype,color Dc, int DcountButton)
  {
    id = countPanel++;
    position = Dposition;
    type = Dtype;
    colr = Dc;
    countButton = DcountButton;
    buttonPanel = new ButtonPanel[countButton];
    enabled = false;
  }
  void AddButton(PVector v, int t, String n, color c, color c_p, color c_m)
  {
    if(currentCountButton < countButton) buttonPanel[currentCountButton++] = new ButtonPanel(v,t,n,c,c_p,c_m,color(100,100,100));
  }
  void AddButton(PVector v, int t, String n, color c, color c_p, color c_m, color c_d)
  {
    if(currentCountButton < countButton) buttonPanel[currentCountButton++] = new ButtonPanel(v,t,n,c,c_p,c_m,c_d);
  }
  void Draw()
  {
    if(enabled)
    {
      for(int i=0;i<currentCountButton;i++)
      {
        if(buttonPanel[i].mouseIn)
        {
          if(buttonPanel[i].push)fill(buttonPanel[i].colrMouseIn);
          else fill(buttonPanel[i].colrPush);
        }else fill(buttonPanel[i].colr);
        if(!buttonPanel[i].enabled) fill(buttonPanel[i].colrPush);
        rect(buttonPanel[i].position.x,buttonPanel[i].position.y,40,40);
      }
    }
  }
  void ButtonTriggerEnabled(int enblID)
  {
    for(int i=0;i<4;i++)
      upPanel.buttonPanel[i].enabled = false;
    if(enblID >= 4) return;
    upPanel.buttonPanel[enblID].enabled = true;
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
   for(int i=0;i<gamePanel.currentCountButton;i++)
    {
      if(gamePanel.buttonPanel[i].name == "ObjUp")
        if(countAllocate == 1) 
          gamePanel.buttonPanel[i].enabled = true;
        else 
          gamePanel.buttonPanel[i].enabled = false;
      
      if(gamePanel.buttonPanel[i].position.x < mouse.x && gamePanel.buttonPanel[i].position.y < mouse.y && 
        gamePanel.buttonPanel[i].position.x+40 > mouse.x && gamePanel.buttonPanel[i].position.y+40 > mouse.y &&
        gamePanel.buttonPanel[i].enabled)
        {
          gamePanel.buttonPanel[i].mouseIn = true;
          
          if(mousePressed)
          {
            mouseMode = gamePanel.buttonPanel[i].name;
            gamePanel.buttonPanel[i].push = true;
          }
          else gamePanel.buttonPanel[i].push = false;
        }
        else gamePanel.buttonPanel[i].mouseIn = false;
    }
  }
  if(upPanel.enabled)
  {
    for(int i=0;i<upPanel.currentCountButton;i++)
    {
      if(upPanel.buttonPanel[i].enabled)
      {
        if(upPanel.buttonPanel[i].position.x < mouse.x && upPanel.buttonPanel[i].position.y < mouse.y && 
          upPanel.buttonPanel[i].position.x+40 > mouse.x && upPanel.buttonPanel[i].position.y+40 > mouse.y)
          {
            if(mousePressed)
            {
              mouseMode = upPanel.buttonPanel[i].name;
              upPanel.buttonPanel[i].push = true;
            }
            else upPanel.buttonPanel[i].push = false;
            
            upPanel.buttonPanel[i].mouseIn = true;
          }
          else upPanel.buttonPanel[i].mouseIn = false;
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
