int N = 50;
int N2 = 10;
int N3 = 10;
ArrayList<Prey> preys;
ArrayList<Food> foods;
ArrayList<Predator> predators;

int preysIndex = 0;
int foodsIndex = 0;
int predatorsIndex = 0;

int onOver = 30;
int graphShowIndex = 0;

Graph graph;

void setup(){
  size(900,900);
  
  preys = new ArrayList();
  foods = new ArrayList();
  predators = new ArrayList();
  
  for (int i=0; i<N; i++){
    preys.add(new Prey(i, random(10,890), random(10,890), 1000+(int)random(0,500), 2000));
    preysIndex = i;
  }
  for (int i=0; i<N2; i++){
    foods.add(new Food(i, random(10,890), random(10,890), 2000));
    foodsIndex = i;
  }
  for (int i=0; i<N3; i++){
    predators.add(new Predator(i, random(10,890), random(10,890), 1000+(int)random(0,500), 2000));
    predatorsIndex = i;
  }
  
  graph = new Graph();
  
  frameRate(120);
}

void draw(){
  background(136, 222, 102);
  
  //--------------------- Preys
  ArrayList<Integer> deadList = new ArrayList();
  for (int id=0; id<preys.size(); id++){
    preys.get(id).move(foods, preys, predators);
    preys.get(id).show();
    if (preys.get(id).isDead()){
      deadList.add(id);
    }
  }
  
  int tempIndex = 0;
  for (int id : deadList){
    preys.remove(id-tempIndex);
    tempIndex++;
  }
  
  for (int id=0; id<preys.size(); id++){
    if (preys.get(id).isReproducting){
      for (int i=0; i<5; i++){ 
        preysIndex++;
        preys.add(new Prey(preysIndex, preys.get(id).pos.x, preys.get(id).pos.y, 1000, 2000));
      }
      preys.get(id).isReproducting = false;
    }
  }
  
  //--------------------- Foods
  deadList = new ArrayList();
  for (int id=0; id<foods.size(); id++){
    foods.get(id).show();
    if (foods.get(id).isDead()){
      deadList.add(id);
    }
  }
  tempIndex = 0;
  for (int id : deadList){
    foods.remove(id-tempIndex);
    tempIndex++;
  }
  
  if (random(1)<Food.spawnRate){
    foodsIndex++;
    foods.add(new Food(foodsIndex, random(10,890), random(10,890), 2000));
  }
  
  //--------------------- Predators
  deadList = new ArrayList();
  for (int id=0; id<predators.size(); id++){
    predators.get(id).move(preys, predators);
    predators.get(id).show();
    if (predators.get(id).isDead()){
      deadList.add(id);
    }
  }
  
  tempIndex = 0;
  for (int id : deadList){
    predators.remove(id-tempIndex);
    tempIndex++;
  }
  
  for (int id=0; id<predators.size(); id++){
    if (predators.get(id).isReproducting){
      if (random(1)<Predator.reproductionRate){
        for (int i=0; i<1; i++){ 
          predatorsIndex++;
          predators.add(new Predator(predatorsIndex, predators.get(id).pos.x, predators.get(id).pos.y, 250, 1000, 2000));
        }
      }
      predators.get(id).isReproducting = false;
    }
  }
  
  
  //--------------------- Graph
  graphShowIndex=(graphShowIndex+1)%onOver;
  if (graphShowIndex == 0){
  println(graphShowIndex);
    graph.add(preys.size(), foods.size(), predators.size());
  }
  graph.show();
}
