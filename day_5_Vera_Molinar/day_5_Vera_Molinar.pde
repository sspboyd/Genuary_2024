int window_w, window_h, canv_w, canv_h;
float PHI = 1.61803399;
float i_PHI = 0.61803399;
int rseed = int(random(10000000));
int[] fib_seq = {4, 7, 11, 18, 29, 47, 76, 123, 199, 322, 521, 843};
PGraphics c; // short for canvas

float matte_dim, plt_x1, plt_x2, plt_y1, plt_y2, plt_w, plt_h;
int[] num_sqrs = {1, 18,199};
float  frame_ratio = pow(i_PHI, 5);


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
  plt_h = plt_y2-plt_y1;
}

void setup() {
  background(255);
  c = createGraphics(canv_w, canv_h);
  c.smooth(3);

  c.beginDraw();
  c.clear();

  c.noFill();
  c.stroke(0);
  c.strokeWeight(pow(PHI, 2));
  float sqr_dim = plt_w/(num_sqrs.length);
  float sqr_dim_buffer = (sqr_dim*pow(i_PHI, 4))/2;

  println(sqr_dim_buffer);
  //println(sqr_dim_buffer);
  for (int i=0; i<num_sqrs.length; i++) {
    float sqr_x, sqr_y;
    sqr_x = sqr_dim_buffer+ i* sqr_dim;
    sqr_y =plt_h*(pow(i_PHI, 4));

    for (int j=0; j<num_sqrs[i]; j++) {
      c.push();
      c.translate(sqr_x+sqr_dim/2, sqr_y+sqr_dim/2);

      float x_off = sqr_dim * pow(i_PHI, int(random(3+i, 7))) * rndSign();
      float y_off = sqr_dim * pow(i_PHI, int(random(3+i, 7))) * rndSign();

      c.translate(x_off, y_off);

      c.rotate(TWO_PI * pow(i_PHI, i));
      c.rotate(TWO_PI * pow(i_PHI, int(random(6+i, 11))) * rndSign());
      c.rect(-sqr_dim/2, -sqr_dim/2, sqr_dim, sqr_dim);
      //c.rect(100, 200, sqr_dim, sqr_dim);
      c.pop();
    }
  }


  c.endDraw();

  image(c, 0, 0, window_w, window_h);
  noLoop();
}

int rndSign(){
return int(random(2))*2-1;
}
void draw() {
}
void keyPressed() {
  if (key == 's' || key == 's') {
    String export_filename ="genuary2024_day5_"+rseed+".png";
    save(export_filename);
    println("saved to: "+export_filename);
  }
}
