//import processing.net.*;//Include
//Client c;+
int temp = 0;

ArrayList<Unit> own   = new ArrayList<Unit>();
ArrayList<Unit> enemy = new ArrayList<Unit>();
ArrayList<Grid> grids = new ArrayList<Grid>();
ArrayList<Force> forces = new ArrayList<Force>();

Window window;
GameLocation gameLocation;
Camera gameCamera;
Panel gamePanel,upPanel;
Grid gameGrid;
DebugWindow debugWindow;
Mouse mouse;
Mouse lastMouse;
Mouse mousePresPos;

void setup() 
{
  size(1028, 600);
  stroke(0);
  background(204);
  
  window = new Window();
  masKey = new Key[255];
  for(int i = 0;i<masKey.length;i++)
  {
    masKey[i] = new Key(char(i));
  }
  //----------------------------------------------------
  gameCamera = new Camera(new PVector(width/4,height/4),1);
  //----------------------------------------------------
  mouse = new Mouse();
  mousePresPos = new Mouse();
  lastMouse = new Mouse();
  lastMouse.flagLast = true;
  //----------------------------------------------------
  gameLocation = new GameLocation(new PVector(0,0),new PVector(width,height));
  gameLocation.FrameInit();
  gameLocation.GameMapInit();
  gameLocation.gameMap.flagGridBorder = true;
  gameLocation.gameMap.enabled = true;
  //gameLocation.SubArea("S",40);
  //----------------------------------------------------
  //grids.add(new Grid(3,3,color(100)));
  //----------------------------------------------------
  gamePanel = new Panel(new PVector(0,0),0,color(255));
  //АДД БАТОН                   |Положение                      |Тип                |ID            |Стандарт цвет       |При нажатии         |Под курсором      |Отключена
  gamePanel.AddButton(new Button(new PVector(0,height-40),       TypeButton.CLICABLE,"ObjMove",     color(0, 204, 0),    color(0, 220, 0),    color(0, 100, 0),  color(0,100,0)));//кнопка назначения пункта перемещения объекта
  gamePanel.AddButton(new Button(new PVector(40,height-40),      TypeButton.CLICABLE,"ObjUp",       color(255,0,0),      color(100,20,20),    color(200,0,0),    color(100,0,0)));//кнопка улучшения объекта
  gamePanel.AddButton(new Button(new PVector(80,height-40),      TypeButton.CLICABLE,"ObjAttack",   color(0, 153, 153),  color(0, 170, 170),  color(0, 100, 100),color(0,100,100)));//кнопка атаки объекта
  gamePanel.AddButton(new Button(new PVector(120,height-40),     TypeButton.CLICABLE,"ObjUltAttack",color(255, 116, 0),  color(255, 136, 20), color(200, 96, 0), color(100,50,0)));//кнопка ульты объекта
  gamePanel.AddButton(new Button(new PVector(width-40,height-40),TypeButton.CLICABLE,"ObjSettings", color(200, 100, 200),color(255, 136, 255),color(150, 75, 150), color(100,50,100)));//кнопка ульты объекта
  
  gamePanel.enabled = true;
  gamePanel.ActivateButtons();
  //----------------------------------------------------
  upPanel = new Panel(new PVector(0,0),0,color(255));
  upPanel.AddButton(new Button(new PVector(0,height-80),TypeButton.GROUPFLAG,"ObjUp1",color(255,0,0),color(255,55,55),color(200,0,0), color(100,100,100)));
  upPanel.AddButton(new Button(new PVector(40,height-80),TypeButton.GROUPFLAG,"ObjUp2",color(255,0,0),color(255,55,55),color(200,0,0), color(100,100,100)));
  upPanel.AddButton(new Button(new PVector(80,height-80),TypeButton.GROUPFLAG,"ObjUp3",color(255,0,0),color(255,55,55),color(200,0,0), color(100,100,100)));
  upPanel.AddButton(new Button(new PVector(120,height-80),TypeButton.GROUPFLAG,"ObjUp4",color(255,0,0),color(255,55,55),color(200,0,0), color(100,100,100)));
  //----------------------------------------------------
  //debugWindow = new DebugWindow(200,200,200,200,1);
  //debugWindow.border = true;
  //----------------------------------------------------
  //c = new Client(this,"192.168.57.8", 12345);
  //----------------------------------------------------
  forces.add(new Force()); //ZERO FORCE IS PLAYER
  //----------------------------------------------------
  AddUnit(new PVector(100,100),1000,0,"own",color(255));
  AddUnit(new PVector(100,120),1000,0,"own",color(255));
  AddUnit(new PVector(100,140),1000,0,"own",color(255));
  AddUnit(new PVector(100,160),1000,0,"own",color(255));

  AddUnit(new PVector(width-100,100),1000,0,"enemy",color(255,0,0));
  AddUnit(new PVector(width-100,120),1000,0,"enemy",color(255,0,0));
  AddUnit(new PVector(width-100,140),1000,0,"enemy",color(255,0,0));
  AddUnit(new PVector(width-100,160),1000,0,"enemy",color(255,0,0));
  //----------------------------------------------------
  background(0);
  window.Init();
}

void draw()
{
  background(0);
  int temp = millis();
  //-------------------------------UPDATE-------------------------------------- 
  window.mpp=temp-window.mpp;
  //----------------------------------------------------
  mouse.Update();
  gameCamera.Update();
  gameLocation.Update();
  UpdateGamePoints();
  UpdatePanels();
  gameLocation.frame.UpdatePos();
  UpdateUnits();
  UpdateEnemyPos();
  UpdateSpotLight();
  //----------------------------------------------------
  window.mpu = millis()-temp;
  //--------------------------------DRAW---------------------------------------
  temp = millis();
  //----------------------------------------------------
  //debugWindow.Draw();
  gameLocation.Draw();
  DrawUnits();
  DrawSpotLight();
  DrawUpdateMouseMode();
  DrawUnitsData();
  DrawGamePoints();
  DrawGamePanel();
  //DrawTextDebug();
  if(window.flagTurnDebug)debug();
  if(window.flagTurnConsole)console();
  /*for(int i = 0;i<gameLocation.locationObjects.size();i++) 
    text(gameLocation.locationObjects.get(i).type+" (id"+gameLocation.locationObjects.get(i).id+") - "+gameLocation.locationObjects.get(i).transform,10,140+10*i);
  */
  debug();  
  
  //------------UPDATE FOR NEXT FRAME-------------------
  gameCamera.lastScroll = gameCamera.countScroll;
  lastMouse.Update();
  //----------------------------------------------------
  window.mpd = millis()-temp;
  window.mpp = millis();
  //--------------------------------------------------------------------------
}
