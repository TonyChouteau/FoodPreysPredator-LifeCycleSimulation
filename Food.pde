public class Food{
  
  public static final float spawnRate = 0.02;
  
  public int id;
  public PVector pos;
  public int use;
  public int useMax;
  
  public int deltaEat;
  
  public Food(int i, float x, float y, int u){
    id = i;
    pos = new PVector(x,y);
    useMax = u;
    use = useMax;
    deltaEat = useMax/4;
  }
  
  public int eat(){
    if (use >= deltaEat){
      use -= deltaEat;
      return deltaEat;
    } else {
      return 0; 
    }
  }
  
  public boolean isDead(){
   return use < deltaEat; 
  }
  
  public void show(){
    noStroke();
    textMode(CENTER);
    fill(50);
    text(("H:"+use*100/useMax+"%"),pos.x-10, pos.y-10);
    fill(240, 3, 252);
    ellipse(pos.x, pos.y, 20, 20);
  }
}
