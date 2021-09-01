int xspacing = 4;   // How far apart should each horizontal location be spaced
int w;              // Width of entire wave
int maxwaves = 5;   // total # of waves to add together

float theta = 0.0;
float[] amplitude = new float[maxwaves];   // Height of wave
float[] dx = new float[maxwaves];          // Value for incrementing X, to be calculated as a function of period and xspacing
float[] yvalues;    

float x = random(255);


void setup() {
  size(700, 400);
  frameRate(10);
  background(random(x), random(x), x);
  colorMode(RGB, 255, 255, 255, 100);
  w = width + 16;

  for (int i = 0; i < maxwaves; i++) {
    amplitude[i] = random(10,30);
    float period = random(100,300); // How many pixels before the wave repeats
    dx[i] = (TWO_PI / period) * xspacing;
  }

  yvalues = new float[w/xspacing];
  
  
}


void draw() {
  
  calcWave();
  renderWave();
  
}

void keyPressed() {
  if ( key == 'q' ) noLoop();  
  if ( key == 'p' ) loop();
  if ( key == 's' ) saveCanvas();

}

void saveCanvas(){
  int saveCount = 1;
  while (saveCount > 0){
    save("random" + Math.round(random(9999)) + ".jpg");
    saveCount = saveCount - 1;
  }
}

void calcWave() {
  // Increment theta (try different values for 'angular velocity' here
  theta += 0.25;

  // Set all height values to zero
  for (int i = 0; i < yvalues.length; i++) {
    yvalues[i] = 0;
  }
 
  // Accumulate wave height values
  for (int j = 0; j < maxwaves; j++) {
    float x = theta;
    for (int i = 0; i < yvalues.length; i++) {
      // Every other wave is cosine instead of sine
      if (j % 2 == 0)  yvalues[i] += sin(x)*amplitude[j];
      else yvalues[i] += cos(x)*amplitude[j];
      x+=dx[j];
    }
  }
}

void renderWave() {
  noStroke();
  fill(random(150), random(150), random(150));
  ellipseMode(CENTER);
  for (int x = 0; x < yvalues.length; x++) {
    ellipse(x*xspacing,height/2+yvalues[x],16,16);
  }
  
}
