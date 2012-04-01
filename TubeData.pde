class TubeData {

  int INTERPOLATIONS = 60;

  ArrayList<Float> widthData;
  ArrayList<Float> thicknessData;



  TubeData() {
    widthData = new ArrayList<Float>();
    thicknessData = new ArrayList<Float>();
  }

  void addWidthValue(float w) {
    widthData.add(new Float(w));
  }

  void addThicknessValue(float t) {
    thicknessData.add(new Float(t));
  }



  float[][] getInterpolatedWidthValues() {

    if (widthData.size() > 0) {
      float[][] values = new float[widthData.size()-1][INTERPOLATIONS+1];

      for (int j = 0; j < widthData.size()-1; j++) {

        for (int i = 0; i <= INTERPOLATIONS; i++) {

          float w = splineAt(widthData, j, i/(INTERPOLATIONS+0.0));
          try {

            values[j][i] = w;
          }
          catch(ArrayIndexOutOfBoundsException e) {
            println("ARRAY OOB");
          }
        }
      }


      return values;
    }
    else {

      return new float[0][0];
    }
  }





  float[][] getInterpolatedThicknessValues() {


    if (thicknessData.size() > 0) {

      float[][] values = new float[thicknessData.size()-1][INTERPOLATIONS+1];

      for (int j = 0; j < thicknessData.size()-1; j++) {

        for (int i = 0; i <= INTERPOLATIONS; i++) {

          float t = splineAt(thicknessData, j, i/(INTERPOLATIONS+0.0));

          try {

            values[j][i] = t;
          }
          catch(ArrayIndexOutOfBoundsException e) {
            println("ARRAY OOB");
          }
        }
      }


      return values;
    }
    else {

      return new float[0][0];
    }
  }
}

