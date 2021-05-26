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
void keyPressed()
{
  masKey[keyCode].last = masKey[keyCode].push;
  masKey[keyCode].push = true;
}
void keyReleased()
{
  masKey[keyCode].last = masKey[keyCode].push;
  masKey[keyCode].push = false;
  if(mouse.mode == "ObjUp")
  {
    switch(key)
    {
      case '1':
      mouse.mode = "ObjUp1";
      break;
      case '2':
      mouse.mode = "ObjUp2";
      break;
      case '3':
      mouse.mode = "ObjUp3";
      break;
      case '4':
      mouse.mode = "ObjUp4";
      break;
    }
  }
  else
  {
    switch(key)
    {
      case '1':
      mouse.mode = "ObjMove";
      break;
      case '2':
      mouse.mode = "ObjUp";
      break;
      case '3':
      mouse.mode = "ObjAttack";
      break;
      case '4':
      mouse.mode = "ObjUltAttack";
      break;
      case '5':
      mouse.mode = "Null";
      break;
    }
  }
}
