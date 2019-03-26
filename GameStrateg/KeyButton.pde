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
    
    return true;
  }
}
void keyPressed()
{
  //if(masKey[keyCode].push) return;
  //println("KEY-"+keyCode+":`"+key+"` - PRESSED");
  masKey[keyCode].last = masKey[keyCode].push;
  masKey[keyCode].push = true;
}
void keyReleased()
{
  //if(!masKey[keyCode].push) return;
  //println("KEY-"+keyCode+":`"+key+"` - RELEASED");
  masKey[keyCode].last = masKey[keyCode].push;
  masKey[keyCode].push = false;
}
