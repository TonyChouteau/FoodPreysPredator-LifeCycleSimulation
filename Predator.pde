public class Predator extends Prey{
  
  public static final float reproductionRate = 0.2;
  
  public Predator(int i, float x, float y, int h, int r){
    super(i, x, y, h, r);
    this.speed*=1.5;
    this.lifeExpectancy = 5000;
  }
  public Predator(int i, float x, float y, int h, int hM, int r){
    super(i, x, y, h, hM, r);
    this.speed*=1.5;
    this.lifeExpectancy = 5000;
  }
  
  public void move(ArrayList<Prey> preys, ArrayList<Predator> predators){
    life++;
    Prey p = preyIsClose(preys);
    Predator pr = predatorIsClose(predators);
    if ( reproductiveUrge<reproductiveUrgeMax){
      reproductiveUrge += reproductiveUrgeMax/1000;
    }
    if (pr != null && reproductiveUrge >= reproductiveUrgeMax*8/10 && hunger >= hungerMax*3/4) {
      
      //Reproduct
      speedAngle = atan2(pr.pos.y-pos.y, pr.pos.x-pos.x);
      PVector temp = PVector.fromAngle(speedAngle).mult(speed);
      if (sqrt(pow(pr.pos.x-pos.x,2)+pow(pr.pos.y-pos.y,2)) > 20){
        pos.add(temp);
      } else {
        isReproducting = true;
        reproductiveUrge = 0;
      }
      
    } else if (hunger<hungerMax && p!=null){
      
      //Eat
      speedAngle = atan2(p.pos.y-pos.y, p.pos.x-pos.x);
      PVector temp = PVector.fromAngle(speedAngle).mult(speed);
      if (sqrt(pow(p.pos.x-pos.x,2)+pow(p.pos.y-pos.y,2)) > 20){
        pos.add(temp);
      } else {
        hunger += p.eat();
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
  
  @Override
  public void show(){
    noStroke();
    textMode(CENTER);
    fill(0);
    text(("H:"+hunger*100/hungerMax+"%"),pos.x-10, pos.y-10);
    text(("R:"+reproductiveUrge*100/reproductiveUrgeMax+"%"),pos.x-10, pos.y-20);
    text(("L:"+life*100/lifeExpectancy+"%"),pos.x-10, pos.y-30);
    fill(252, 20, 3);
    ellipse(pos.x, pos.y, 20, 20);
  }
}
