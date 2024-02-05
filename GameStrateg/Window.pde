class Window
{
  int fps; //Frame per second
  int mpu; //Milisec per update
  int mpd; //Milisec per draw
  int mpp; //Milisec per pause
  boolean flagTurnDebug;
  boolean flagTurnConsole;
  int countButton = 0; // ЗАМЕНИТЬ НА ДИНАМИЧЕСКИЕ ЛИСТЫ
  int countPanel = 0; // ЗАМЕНИТЬ НА ДИНАМИЧЕСКИЕ ЛИСТЫ
  void Init()
  {
    mpu = mpd = mpp = 0;
    flagTurnDebug = false;
    flagTurnConsole = false;
  }
}
