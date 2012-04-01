MindData mind = new MindData();
ThinkGearSocket neuroSocket;

void initMindwave() {
  neuroSocket = new ThinkGearSocket(this);

  try {
    neuroSocket.start();
  } 
  catch (ConnectException e) {
    println("Is ThinkGear running??");
  }

  println("done init");
}

void poorSignalEvent(int sig) {

  mind.connected = false;
  mind.signal = sig;
}

public void attentionEvent(int attentionLevel) {
  mind.connected = true;
  mind.attention = attentionLevel;
  
  if(attentionLevel > 0){
    println(50+attentionLevel*2);
    tData.addWidthValue(50+attentionLevel*2);
  }
}



void meditationEvent(int meditationLevel) {
  mind.connected = true;
  mind.meditation = meditationLevel;
  
  if(meditationLevel > 0){
    float thickness = 5+(((meditationLevel*meditationLevel*meditationLevel)/1000000.0)* 100);
    println(thickness);
    tData.addThicknessValue(thickness);
  }

}

void blinkEvent(int blinkStrength) {
  mind.blinkStrength = blinkStrength;
}

public void eegEvent(int delta, int theta, int low_alpha, int high_alpha, int low_beta, int high_beta, int low_gamma, int mid_gamma) {
  mind.delta = delta;
  mind.theta = theta;
  mind.low_alpha = low_alpha;
  mind.high_alpha = high_alpha;
  mind.low_beta = low_beta;
  mind.high_beta = high_beta;
  mind.low_gamma = low_gamma;
  mind.mid_gamma = mid_gamma;
}

void rawEvent(int[] raw) {
  mind.raw = raw;
}	

void stop() {
  mind.connected = false;

  neuroSocket.stop();
  super.stop();
}

void drawDisconnected(int sig) {

  println("signal:"+sig);


  background(255);

  float x = width/2;
  float y = height/2;
  float nx = x - 2.5*30;
  float ny = y - 20;


  fill(255, 0, 0);
  noStroke();

  ellipse(x, y, 500, 500);

  int val = 200-sig;


  for (int i = 0; i < 5; i++) {
    if (val >= (i+1)*(200/5))
      fill(255);
    else
      fill(0);

    rect(nx, ny, 20, y-ny);

    nx+= 30;
    ny -= 10;
  }
  
  stroke(0);
  fill(0);

}




class MindData {
  Boolean connected = false;
  int signal = 0;

  int[] raw;
  int delta, theta, low_alpha, high_alpha, low_beta, high_beta, low_gamma, mid_gamma;
  int blinkStrength;
  int attention;
  int meditation;
}

