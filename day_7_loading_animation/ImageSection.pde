public class ImageSection {
  int w, h, x, y;
  float init_rot, curr_rot;
  PImage base_img, img;


  public ImageSection(int _w, int _h, int _x, int _y, float _init_rot) {

    w=_w;
    h=_h;
    x=_x;
    y=_y;
    init_rot=_init_rot;
    curr_rot = init_rot;
    PImage img;
  }

  void update(float _pct_done) {
    float pct_done = _pct_done;
    if (pct_done<0.999) {
      int time_remaining = loading_duration_ms-(curr_time-start_time);
      float d_rot = TWO_PI-curr_rot;
      float easing = 0.027;
      // curr_rot += d_rot * easing;
      curr_rot=map(time_remaining,loading_duration_ms,0,init_rot,TWO_PI);
    } else {
      curr_rot=TWO_PI;
    }
  }

  void render(PImage _base_img) {
    base_img = _base_img;
    int get_x = int(x-(w/2.0));
    int get_y = int(y-(h/2.0));
    img = base_img.get(get_x,get_y,w,h);
    push();
    translate(x, y);
    rotate(curr_rot);
    image(img, 0, 0);
    pop();
  }
}