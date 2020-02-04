import java.util.Collections;

public class Graph{

  ArrayList<Integer> preys = new ArrayList();
  ArrayList<Integer> foods = new ArrayList();
  ArrayList<Integer> predators = new ArrayList();
  
  public Graph(){}
  
  public void add(int p, int f, int pr){
    if (preys.size() < 100){
      preys.add(p);
      foods.add(f);
      predators.add(pr);
    } else {
       for (int i=1; i<preys.size(); i++){
         preys.set(i-1, preys.get(i));
         foods.set(i-1, foods.get(i));
         predators.set(i-1, predators.get(i));
       }
       preys.remove(0);
       foods.remove(0);
       predators.remove(0);
       
       preys.add(p);
       foods.add(f);
       predators.add(pr);
    }
  }
  
  public void show(){
    noFill();
    strokeWeight(2);
    
    int maxPreys = 0;
    int maxFoods = 0;
    int maxPredators = 0;
    if (preys.size()>0){
      maxPreys = Collections.max(preys);
      maxFoods = Collections.max(foods);
      maxPredators = Collections.max(predators);
    }
    
    for (int i=1; i<preys.size(); i++){
      noStroke();
      fill(0, 200);
      rect(width/2-25, height*3/4-15, 80, 60);
      //textSize(20);
      fill(255, 255);
      text(preys.get(preys.size()-1), width/2, height*3/4);
      text(foods.get(foods.size()-1), width/2, height*3/4+20);
      text(predators.get(predators.size()-1), width/2, height*3/4+40);
      
      stroke(230, 162, 16);
      line(width*(i-1)/100, height-5-preys.get(i-1)*(height/2)/(maxPreys+1), width*i/100, height-5-preys.get(i)*(height/2)/(maxPreys+1));
      stroke(240, 3, 252);
      line(width*(i-1)/100, height-5-foods.get(i-1)*(height/2)/(maxFoods+1), width*i/100, height-5-foods.get(i)*(height/2)/(maxFoods+1));
      stroke(252, 20, 3);
      line(width*(i-1)/100, height-5-predators.get(i-1)*(height/2)/(maxPredators+1), width*i/100, height-5-predators.get(i)*(height/2)/(maxPredators+1));
      //textSize(10);
    }
  }
}
