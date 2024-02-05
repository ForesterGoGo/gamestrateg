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
    if(!enabled) return;
    if(deactivated) fill(colrDeactivated);
    else 
      if(mouseIn)
         if(!push) fill(colrMouseIn);
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
  boolean flag;
  int IdAllocate = 0;
  color colr;
  ArrayList<Button> buttons;
  int countButtons = 0;
  Panel(PVector Dposition,int Dtype,color Dc)
  {
    id = window.countPanel++;
    position = Dposition;
    type = Dtype;
    colr = Dc;
    buttons = new ArrayList<Button>();
    enabled = false;
  }
  void AddButton(Button button)
  {
    buttons.add(button);
    countButtons++;
  }
  void Draw()
  {
    if(enabled)
    {
      for(Button button : buttons)
        button.Draw();
    }
  }
  void ActivateButtons()
  {
    for(Button button : buttons)
        button.deactivated = false;
  }
  void ActivateButtons(int[] mes)
  {
    for(int i=0;i<mes.length;i++)
        buttons.get(mes[i]).deactivated = false;
  }
  void ButtonTriggerEnabled(int enblID)
  {
    for(int i=0;i<4;i++)
      upPanel.buttons.get(i).enabled = false;
    if(enblID < 4) 
      upPanel.buttons.get(enblID).enabled = true;
  }
}
void DrawGamePanel()
{
  if(gamePanel.enabled)
  {
    gamePanel.Draw();
    // облаcть игровой панели
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
   for(int i=0;i<gamePanel.countButtons;i++)
    {
      if(mouse.countAllocate > 0 || gamePanel.buttons.get(i).name == "ObjSettings") //Если выделен хотя бы больше чем один юнит
        gamePanel.buttons.get(i).deactivated = false;
      else 
        gamePanel.buttons.get(i).deactivated = true;
      
      if(gamePanel.buttons.get(i).position.x < mouse.x && gamePanel.buttons.get(i).position.y < mouse.y && 
        gamePanel.buttons.get(i).position.x+40 > mouse.x && gamePanel.buttons.get(i).position.y+40 > mouse.y &&
        gamePanel.buttons.get(i).enabled)
        {
          gamePanel.buttons.get(i).mouseIn = true;
          
          if(mousePressed)
          {
            mouse.mode = gamePanel.buttons.get(i).name;
            gamePanel.buttons.get(i).push = true;
          }
          else gamePanel.buttons.get(i).push = false;
        }
        else gamePanel.buttons.get(i).mouseIn = false;
    }
  }
  
  if(upPanel.enabled)
  {
    for(Button button : upPanel.buttons)
    {
      if(button.enabled)
      {
        if(button.position.x < mouse.x && button.position.y < mouse.y && 
          button.position.x+40 > mouse.x && button.position.y+40 > mouse.y)
        {
          if(mousePressed && !button.deactivated)
          {
            mouse.mode = button.name;
            button.push = true;
          }
          else button.push = false;
          button.mouseIn = true;
        }
        else button.mouseIn = false;
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
