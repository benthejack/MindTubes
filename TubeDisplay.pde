class TubeDisplay {

  int SEGMENTS_PER_SCREEN = 20;
  float SEGMENT_WIDTH;
  float x, y;


  TubeDisplay(float i_x, float i_y) {
    x = i_x;
    y = i_y;
    SEGMENT_WIDTH = width/(SEGMENTS_PER_SCREEN+0.0);
  }


  Boolean draw(TubeData data, int frame) {
    
    float interpWidth = SEGMENT_WIDTH/data.INTERPOLATIONS;
    
    float[][] wValues = data.getInterpolatedWidthValues();
    float[][] tValues = data.getInterpolatedThicknessValues();



    if (wValues.length > 0 && tValues.length > 0) {

      for (int i = 0; i < wValues.length && i < tValues.length; i++) {
        for (int j = 1; j < wValues[i].length; j++) {
          
          float cx = (SEGMENT_WIDTH*i)+(interpWidth*(j));
          float lx = (SEGMENT_WIDTH*i)+(interpWidth*(j-1));
          
          stroke(0);
          
          if(i*data.INTERPOLATIONS+j < frame){
            line(x+lx, y+wValues[i][j-1], x+cx, y+wValues[i][j]);
            line(x+lx, y-wValues[i][j-1], x+cx, y-wValues[i][j]);
            
            line(x+lx, y+(wValues[i][j-1]-tValues[i][j-1]), x+cx, y+(wValues[i][j]-tValues[i][j]));
            line(x+lx, y-(wValues[i][j-1]-tValues[i][j-1]), x+cx, y-(wValues[i][j]-tValues[i][j]));
            
          }
        }
      }


      return true;
    }
    else{
      
      return false; 
      
    }
    
  }
}

