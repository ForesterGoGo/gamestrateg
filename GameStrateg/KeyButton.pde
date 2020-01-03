Key[] masKey;
class Key
{
  char symbole;
  boolean push;
  boolean last;
  Key(char Dsymbole)
  {
    push = false;
    last = false;
    symbole = Dsymbole;
  }
  boolean handle()
  {
    boolean flag;
    if(push != last) flag = true;
    else flag = false;
    return flag;
  }
}
void keyTyped()
{
  masKey[keyCode].last = masKey[keyCode].push;
  masKey[keyCode].push = true;
}
void keyReleased()
{
  masKey[keyCode].last = masKey[keyCode].push;
  masKey[keyCode].push = false;
  if(mouseMode == "ObjUp")
  {
    switch(key)
    {
      case '1':
      mouseMode = "ObjUp1";
      break;
      case '2':
      mouseMode = "ObjUp2";
      break;
      case '3':
      mouseMode = "ObjUp3";
      break;
      case '4':
      mouseMode = "ObjUp4";
      break;
    }
  }
  else
  {
    switch(key)
    {
      case '1':
      mouseMode = "ObjMove";
      break;
      case '2':
      mouseMode = "ObjUp";
      break;
      case '3':
      mouseMode = "ObjAttack";
      break;
      case '4':
      mouseMode = "ObjUltAttack";
      break;
      case '5':
      mouseMode = "Null";
      break;
    }
  }
}
