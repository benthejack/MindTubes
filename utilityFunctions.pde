float splineAt(float[] pts, int i, float t) {

  t = constrain(t, 0, 1); 
  i = constrain(i, 0, pts.length-1); 
  float P0; 
  float P1;
  float P2;
  float P3;



  if (i == 0) {
    P0 = pts[i];
    P1 = pts[i];
  }
  else {
    P0 = pts[i-1];
    P1 = pts[i];
  }

  if (i >= pts.length-2) {
    P2 = pts[i+1];
    P3 = pts[i+1];
  }
  else {
    P2 = pts[i+1];
    P3 = pts[i+2];
  }



  return 0.5 *(  	
  (2 * P1) +
    (-P0 + P2) * t +
    (2*P0 - 5*P1 + 4*P2 - P3) * (t*t) +
    (-P0 + 3*P1- 3*P2 + P3) * (t*t*t)
    );
}


float splineAt(ArrayList<Float> pts, int i, float t) {

  t = constrain(t, 0, 1); 
  i = constrain(i, 0, pts.size()-1); 
  float P0; 
  float P1;
  float P2;
  float P3;



  if (i == 0) {
    P0 = (float)pts.get(i);
    P1 = (float)pts.get(i);
  }
  else {
    P0 = (float)pts.get(i-1);
    P1 = (float)pts.get(i);
  }

  if (i >= pts.size()-2) {
    P2 = (float)pts.get(i+1);
    P3 = (float)pts.get(i+1);
  }
  else {
    P2 = (float)pts.get(i+1);
    P3 = (float)pts.get(i+2);
  }



  return 0.5 *(  	
  (2 * P1) +
    (-P0 + P2) * t +
    (2*P0 - 5*P1 + 4*P2 - P3) * (t*t) +
    (-P0 + 3*P1- 3*P2 + P3) * (t*t*t)
    );
}
