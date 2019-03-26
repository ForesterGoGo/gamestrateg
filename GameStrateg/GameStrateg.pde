//import processing.net.*;//Include
//Client c;+
int s=0,x=50,y=50;
int i=0;
int countButtonPanel = 0;
int countAllocate = 0;
int countPanel = 0;
int countUnitR = 0;
int countUnitE = 0;
int maxRotaLvl = 4;
int maxGamePoints = 200;
float gamePoints = 150,upPoints = 0.01;
float dist = 0;
Rota[] rota;
Rota[] enemy;
Panel gamePanel,upPanel;
GameLocation gameLocation;
Camera gameCamera;
Grid gameGrid;
DebugWindow debugWindow;
int fon[][];
int fps;
PVector lastMousePos = new PVector(0,0);
PVector mouse = new PVector(0,0);
PVector test = new PVector(0,0);
String TextConsole;
String mouseMode = "Null";
boolean flagAllocationMouse;
boolean flagTurnDebug=true;
boolean flagTurnConsole;
boolean flagMousePressed;

PImage img;

//---------KEY
boolean keyQ,keyW,keyE,keyR,keyT,keyY,keyU;
boolean keyI,keyO,keyP,keyBacketLeft,keyBacketRight;
boolean keyA,keyS,keyD,keyF,keyG,keyH,keyJ;
boolean keyK,keyL,keyColon,keyApostrophe;
boolean keyZ,keyX,keyC,keyV,keyB,keyN,keyM;
boolean keyAngleBacketLeft,keyAngleBacketRight;
boolean keyQuestion,keyUp,keyDown,keySpace,keyCtrl;
boolean key1,key2,key3,key4;
//------------
void setup() 
{
  size(1028, 600);
  stroke(0);
  background(204);
  //----------------------------------------------------
  //img = loadImage("http://processing.org/img/processing-web.png");
  //----------------------------------------------------
  masKey = new Key[255];
  for(int i = 0;i<masKey.length;i++)
  {
    masKey[i] = new Key(char(i));
  }
  //----------------------------------------------------
  gameCamera = new Camera(new PVector(width/2,height/2),5,1,5);
  
  gameLocation = new GameLocation(new PVector(0,0),new PVector(width,height));
  gameLocation.SubArea("S",40);
  //----------------------------------------------------
  gamePanel = new Panel(new PVector(0,0),0,color(255),4);
  gamePanel.AddButton(new PVector(0,height-40),TypeButtonPanel.CLICABLE,"ObjMove",color(0, 204, 0),color(0, 220, 0),color(0, 180, 0));//кнопка назначения пункта перемещения объекта
  gamePanel.AddButton(new PVector(40,height-40),TypeButtonPanel.CLICABLE,"ObjUp",color(255,0,0),color(255,20,20),color(235,0,0),color(184,0,0));//кнопка улучшения объекта
  gamePanel.AddButton(new PVector(80,height-40),TypeButtonPanel.CLICABLE,"ObjAttack",color(0, 153, 153),color(0, 170, 170),color(0, 123, 123));//кнопка атаки объекта
  gamePanel.AddButton(new PVector(120,height-40),TypeButtonPanel.CLICABLE,"ObjUltAttack",color(255, 116, 0),color(255, 136, 20),color(225, 96, 0));//кнопка ульты объекта
  
  gamePanel.enabled = true;
  //----------------------------------------------------
  upPanel = new Panel(new PVector(0,0),0,color(255),4);
  upPanel.AddButton(new PVector(0,height-80),TypeButtonPanel.GROUPFLAG,"ObjUp1",color(255,0,0),color(255,20,20),color(235,0,0));
  upPanel.AddButton(new PVector(40,height-80),TypeButtonPanel.GROUPFLAG,"ObjUp2",color(255,0,0),color(255,20,20),color(235,0,0));
  upPanel.AddButton(new PVector(80,height-80),TypeButtonPanel.GROUPFLAG,"ObjUp3",color(255,0,0),color(255,20,20),color(235,0,0));
  upPanel.AddButton(new PVector(120,height-80),TypeButtonPanel.GROUPFLAG,"ObjUp4",color(255,0,0),color(255,20,20),color(235,0,0));
  //----------------------------------------------------
  gameGrid = new Grid(10,10,true,color(100));
  gameGrid.flagInteractionCameraScale = true;
  gameGrid.enabled = true;
  //----------------------------------------------------
  //debugWindow = new DebugWindow(200,200,200,200,1);
  //debugWindow.border = true;
  //----------------------------------------------------
  //c = new Client(this,"192.168.57.8", 12345);
  background(0);
  rota = new Rota[20];
  Addr(new PVector(100,100),1000,0,0,color(255));
  Addr(new PVector(100,120),1000,0,0,color(255));
  Addr(new PVector(100,140),1000,0,0,color(255));
  Addr(new PVector(100,160),1000,0,0,color(255));
  
  enemy = new Rota[20];
  Adde(new PVector(width-100,100),1000,0,1,color(255,0,0));
  Adde(new PVector(width-100,120),1000,0,1,color(255,0,0));
  Adde(new PVector(width-100,140),1000,0,1,color(255,0,0));
  Adde(new PVector(width-100,160),1000,0,1,color(255,0,0));
}

void draw()
{
  background(0);
  //if (img != null) image(img, -5000, -200, width+5000, height+200);
  mouse.x = mouseX;
  mouse.y = mouseY;
  gameLocation.Update();
  UpdateGamePoints();
  UpdatePanels();
  UpdateEnemyRandPos();
  UpdateMouseModeOnKey();
  
  gameGrid.Draw();
  //debugWindow.Draw();
  DrawUnits();//And Update
  DrawUpdateMouseMode();
  DrawUnitsData();
  DrawGamePoints();
  DrawGamePanel();
  //DrawTextDebug();
  if(flagTurnDebug)debug();
  if(flagTurnConsole)console();
}
