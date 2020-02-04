
public class Prey{
  
  public int id;
  public PVector pos;
  public float speedAngle;
  public float speed = 5;
  public int hunger;
  public int hungerMax;
  public float reproductiveUrge;
  public float reproductiveUrgeMax;
  public boolean isReproducting = false;
  
  public int lifeExpectancy = 3000;
  public int life = 0;
  
  public Prey(int i, float x, float y, int h, int r){
    id = i;
    pos = new PVector(x,y);
    speedAngle = random(0,PI*2);
    hungerMax = h;
    hunger = hungerMax;
    reproductiveUrgeMax = r;
    reproductiveUrge = 0;
  }
  public Prey(int i, float x, float y, int h, int hM, int r){
    id = i;
    pos = new PVector(x,y);
    speedAngle = random(0,PI*2);
    hungerMax = hM;
    hunger = h;
    reproductiveUrgeMax = r;
    reproductiveUrge = 0;
  }
  
  private Food foodIsClose(ArrayList<Food> foods){
    for (Food f : foods){
      if (sqrt(pow(f.pos.x-pos.x,2)+pow(f.pos.y-pos.y,2)) < 200){
        return f;
      }
    }
    return null;
  }
  
  protected Prey preyIsClose(ArrayList<Prey> preys){
    for (Prey p : preys){
      if (sqrt(pow(p.pos.x-pos.x,2)+pow(p.pos.y-pos.y,2)) < 100 && p.id != id){
        return p;
      }
    }
    return null;
  }
  
  protected Predator predatorIsClose(ArrayList<Predator> predators){
    for (Predator p : predators){
      if (sqrt(pow(p.pos.x-pos.x,2)+pow(p.pos.y-pos.y,2)) < 100 && p.id != id){
        return p;
      }
    }
    return null;
  }
  
  public int eat(){
    int temp = hunger;
    hunger = 0;
    return temp;
  }
  public void move(ArrayList<Food> foods, ArrayList<Prey> preys, ArrayList<Predator> predators){
    life++;
    Food f = foodIsClose(foods);
    Prey p = preyIsClose(preys);
    if ( reproductiveUrge<reproductiveUrgeMax){
      reproductiveUrge += reproductiveUrgeMax/1000;
    }
    if (p != null && reproductiveUrge >= reproductiveUrgeMax*8/10 && hunger >= hungerMax*3/4) {
      
      //Reproduct
      speedAngle = atan2(p.pos.y-pos.y, p.pos.x-pos.x);
      PVector temp = PVector.fromAngle(speedAngle).mult(speed);
      if (sqrt(pow(p.pos.x-pos.x,2)+pow(p.pos.y-pos.y,2)) > 20){
        pos.add(temp);
      } else {
        isReproducting = true;
        reproductiveUrge = 0;
      }
      
    } else if (hunger<hungerMax && f!=null){
      
      //Eat
      speedAngle = atan2(f.pos.y-pos.y, f.pos.x-pos.x);
      PVector temp = PVector.fromAngle(speedAngle).mult(speed);
      if (sqrt(pow(f.pos.x-pos.x,2)+pow(f.pos.y-pos.y,2)) > 20){
        pos.add(temp);
      } else {
        hunger += f.eat();
      }
      
    } else {
      
      //Move random
      speedAngle += random(-PI/20, PI/20);
      PVector temp = new PVector(pos.x, pos.y);
      temp.add(PVector.fromAngle(speedAngle).mult(speed));
      if (temp.x-10 > 0 && temp.x+10 < width && temp.y-10 > 0 && temp.y+10 < height){
        pos = temp; 
      } else {
        speedAngle += random(2*PI); 
      }
      
    }
    hunger--;
  }
  
  public boolean isDead(){
    if (hunger <= 0 || life >= lifeExpectancy){
      return true;
    } else {
      return false;
    }
  }
  
  public void show(){
    noStroke();
    textMode(CENTER);
    fill(0);
    text(("H:"+hunger*100/hungerMax+"%"),pos.x-10, pos.y-10);
    text(("R:"+reproductiveUrge*100/reproductiveUrgeMax+"%"),pos.x-10, pos.y-20);
    text(("L:"+life*100/lifeExpectancy+"%"),pos.x-10, pos.y-30);
    fill(230, 162, 16);
    ellipse(pos.x, pos.y, 20, 20);
  }
}
