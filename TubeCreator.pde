class TubeCreator {

  float SIZE_DIVISOR = 2;

  int RING_RESOLUTION = 20;
  int SEGMENT_HEIGHT = 20;



  TriangleMesh mesh;


  TubeCreator(String meshName) {
    mesh=new TriangleMesh(meshName);
  }

  TriangleMesh generate(TubeData data, int res) {
    RING_RESOLUTION = res;
    
    mesh.clear();

    float[][] wValues = data.getInterpolatedWidthValues();
    float[][] tValues = data.getInterpolatedThicknessValues();

    float theta = TWO_PI/(RING_RESOLUTION+0.0);

    if (wValues.length > 0 && tValues.length > 0) {

      for (int i = 0; i < wValues.length && i < tValues.length; i++) {
        for (int j = 1; j < wValues[i].length; j++) {

          float oVal = wValues[i][j]/SIZE_DIVISOR;
          float iVal = wValues[i][j]/SIZE_DIVISOR - tValues[i][j]/SIZE_DIVISOR;

          float oVal2 = 0;
          float iVal2 = 0;

          if (j < wValues[i].length-1) {
            oVal2 = wValues[i][j+1]/SIZE_DIVISOR;
            iVal2 = wValues[i][j+1]/SIZE_DIVISOR - tValues[i][j+1]/SIZE_DIVISOR;
          }
          else if (i < wValues.length-1 && i < tValues.length-1) {
            oVal2 = wValues[i+1][1]/SIZE_DIVISOR;
            iVal2 = wValues[i+1][1]/SIZE_DIVISOR - tValues[i+1][1]/SIZE_DIVISOR;
          }


          float hVal = (SEGMENT_HEIGHT*i)+(SEGMENT_HEIGHT/(data.INTERPOLATIONS+0.0))*j;
          float nhVal = hVal+(SEGMENT_HEIGHT/(data.INTERPOLATIONS+0.0));


          Vec3D origO1 = new Vec3D(oVal, hVal, 0);
          Vec3D origO2 = new Vec3D(oVal2, nhVal, 0);

          Vec3D origI1 = new Vec3D(iVal, hVal, 0);
          Vec3D origI2 = new Vec3D(iVal2, nhVal, 0);

          for (int s = 1; s < RING_RESOLUTION-1; s++) {
            Vec3D o1, o2, o3, o4;
            Vec3D i1, i2, i3, i4;

            o1 = new Vec3D(cos(s*theta)*oVal, hVal, sin(s*theta)*oVal);
            o2 = new Vec3D(cos((s+1)*theta)*oVal, hVal, sin((s+1)*theta)*oVal);

            o3 = new Vec3D(cos(s*theta)*oVal2, nhVal, sin(s*theta)*oVal2);
            o4 = new Vec3D(cos((s+1)*theta)*oVal2, nhVal, sin((s+1)*theta)*oVal2);

            i1 = new Vec3D(cos(s*theta)*iVal, hVal, sin(s*theta)*iVal);
            i2 = new Vec3D(cos((s+1)*theta)*iVal, hVal, sin((s+1)*theta)*iVal);

            i3 = new Vec3D(cos(s*theta)*iVal2, nhVal, sin(s*theta)*iVal2);
            i4 = new Vec3D(cos((s+1)*theta)*iVal2, nhVal, sin((s+1)*theta)*iVal2);


            if ((i < wValues.length-1 && i < tValues.length-1) || j < wValues[i].length-1 ) {


              mesh.addFace(o1, o4, o3);
              mesh.addFace(o1, o2, o4);

              mesh.addFace(i1, i3, i4);
              mesh.addFace(i1, i4, i2);


              if (s == 1) {
                mesh.addFace(origO1, o3, origO2);
                mesh.addFace(origO1, o1, o3);     

                mesh.addFace(origI1, origI2, i3);
                mesh.addFace(origI1, i3, i1);
              }

              if (s == RING_RESOLUTION - 2) {
                mesh.addFace(o2, origO2, o4);
                mesh.addFace(o2, origO1, origO2);  

                mesh.addFace(i2, i4, origI2);
                mesh.addFace(i2, origI2, origI1);
              }
            }




            if ( (i == 0 && j == 1) ||  ((i >= wValues.length-1 && i >= tValues.length-1) && j >= wValues[i].length-1 )) {

              if (!((i >= wValues.length-1 && i >= tValues.length-1) && j >= wValues[i].length-1 )) {
                mesh.addFace(i1, o2, o1);
                mesh.addFace(i1, i2, o2);

                if (s == 1) {
                  mesh.addFace(origI1, o1, origO1); 
                  mesh.addFace(origI1, i1, o1);
                }

                if (s == RING_RESOLUTION - 2) {
                  mesh.addFace(i2, origO1, o2); 
                  mesh.addFace(i2, origI1, origO1);
                }
              }
              else {
                mesh.addFace(i1, o1, o2);
                mesh.addFace(i1, o2, i2);
                
                if (s == 1) {
                  mesh.addFace(origI1, origO1, o1); 
                  mesh.addFace(origI1, o1, i1);
                }

                if (s == RING_RESOLUTION - 2) {
                  mesh.addFace(i2, o2, origO1); 
                  mesh.addFace(i2, origO1, origI1);
                }
                
              }
            }
          }
        }
      }
    }

    return mesh;
  }
}

