float PHI = 1.61803399; //<>//
float i_PHI = 0.61803399;
int rseed = int(random(10000000));

PGraphics canv;
ArrayList<Strip> strips =new ArrayList<Strip>();
int[] fib_seq = {4, 7, 11, 18, 29, 47, 76, 123, 199, 322, 521, 843};
int num_strips = fib_seq[int(random(fib_seq.length))];
float matte_dim, plt_x1, plt_x2, plt_y1, plt_y2, plt_w, plt_h;
int canv_w, canv_h, window_w, window_h;
float frame_ratio = pow(i_PHI, 5);


// strips.add(s)
void settings() {
  window_w=800;
  window_h=800;
  canv_w=1920;
  canv_h=1920;
  size(window_w, window_h);
  //size(540, 960);
  //size(800, 1000);

  randomSeed(rseed);
  println(rseed);

  matte_dim = min(canv_w, canv_h)*frame_ratio;
  plt_x1 = matte_dim;
  plt_x2 = canv_w-matte_dim;
  plt_y1 = matte_dim;
  plt_y2 = canv_h-matte_dim;
  plt_w = plt_x2-plt_x1;
  plt_h = plt_y2-plt_y1; //<>//
  
}


void setup() {
  background(255);
  canv = createGraphics(canv_w, canv_h);
  //canv = createGraphics(1080,1920);
  //canv = createGraphics(1600,2000);

  //println(canv.height);
//colorMode(HSB,1.0);

  
  for (int i=0; i<num_strips; i++) {
    int cw = int(random(plt_w*i_PHI));
    //int cw = int(random(canv.width*i_PHI)+(canv.width-(canv.width*i_PHI)));
    int ch = int(plt_h*pow(i_PHI,int(random(1,6))));
    //int ch = fib_seq[int(random(fib_seq.length))]; //<>//
    int cx = int(plt_x1+random(plt_w-cw));
    int cy = int(plt_y1+random(plt_h-ch));
    //int cy = int(plt_y1+((plt_h/num_strips)*i));
    int cnm = fib_seq[int(random(fib_seq.length-5))+1];
    //float csw = pow(PHI, int(random(6)-2));
float csw = pow(i_PHI, int(random(4)-2));

    strips.add(new Strip(cw, ch, cx, cy, cnm, csw));
  }




  canv.beginDraw();
  canv.clear();
  for (Strip s : strips) {
    //s.update();
    s.render();
  }

  // draw frame
  // frame min dim
  float frame_dim_ratio = pow(i_PHI, 4);
  float frame_dim = min(width, height)*frame_dim_ratio;
  // top
  canv.noStroke();
  canv.fill(255);
  //canv.rect(0, 0, canv.width, frame_dim);
  canv.rect(0, canv.height-frame_dim, canv.width, frame_dim);
  //canv.rect(0, 0, frame_dim, canv.height);
  canv.rect(canv.width-frame_dim, 0, frame_dim, canv.height);

  canv.endDraw();

  image(canv, 0, 0, width, height);

  noLoop();
}


void draw() {
  //background(255);
  //for (Strip s : strips) {
  //s.update();
  //s.render();
  //}

  //fill(0);
  //ellipse(mouseX,mouseY,10,10);
}

void keyPressed() {
  if (key == 's' || key == 's') {
    String export_filename ="genuary2024_day2_"+rseed+".png";
    save(export_filename);
    println("saved to: "+export_filename);
  }
}
