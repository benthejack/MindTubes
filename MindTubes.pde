import processing.opengl.*;
import toxi.geom.*;
import toxi.geom.mesh.*;
import toxi.processing.*;
import neurosky.*;
import org.json.*;



int SPEED = 60;

ToxiclibsSupport gfx;


TubeData tData;
TubeDisplay renderer2D;
TubeCreator renderer3D;

int currentFrame = 0;
int cnt2 = 0;

Boolean doRender3D = false;


void setup() {
  size(1200, 800, OPENGL);
  background(255);


  gfx=new ToxiclibsSupport(this);


  tData = new TubeData();
  renderer2D = new TubeDisplay(0, 800-250);
  renderer3D = new TubeCreator("mindTube");
  initMindwave();
}

TriangleMesh msh;

void draw() {

  if (mind.signal <= 0) {
    background(255); 

    if (doRender3D) {
      msh  = renderer3D.generate(tData, 20);
      msh.computeVertexNormals();

      pushMatrix();
      translate(0, 800-250, 0);
      rotateZ(-PI/2);
      scale(2);
      ambientLight(48, 48, 48);
      lightSpecular(230, 230, 230);
      directionalLight(255, 255, 255, 0, -0.5, -1);
      specular(255, 255, 255);
      shininess(16.0);
      beginShape(TRIANGLES);
      noStroke();
      gfx.mesh(msh);
      popMatrix();
      endShape();
      
    }else{
      
      if(renderer2D.draw(tData, currentFrame)){
        currentFrame++;
      }
      
    }

  }
  else {
    lights();

    drawDisconnected(mind.signal);
  }
}

void mousePressed() {
  doRender3D = !doRender3D;
}

void keyPressed(){
 if(key == 's'){
       TriangleMesh msh = renderer3D.generate(tData, 100);
        msh.saveAsSTL(sketchPath("myMindTube2.stl"));
    
   
 } 
  
}

