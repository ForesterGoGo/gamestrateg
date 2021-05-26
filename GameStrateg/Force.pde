class Force
{
  int id;
  PVector position;
  PVector zone; //Зона спавна
  int countUnit;
  ArrayList<Unit> units;
  IntList ally;
  Force()
  {    
    units = new ArrayList<Unit>();
    //Массив с объектами Unit 
    ally = new IntList();
    //Массив Ally (Союзников) Все кто не союзник - враг!
    
    position = new PVector(0,0);
    zone = new PVector(width,height);
  }
  void Update()
  {
    
  }
  void addAlly(Force allyForce)
  {
    ally.append(allyForce.id);
  }
}
