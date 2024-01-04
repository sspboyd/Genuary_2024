public class Strip {
  int w, h, x, y;
  int num_marks;
  float stroke_w;
  int stroke_clr;
  float mark_spacing;
  float mark_x_off, mark_y_off;
  float mark_x_2, mark_y_2;
  float x_shift_incr;

 
  public Strip(int _w, int _h, int _x, int _y, int _num_marks, float _stroke_w) {
    
    w=_w;
    h=_h;
    x=_x;
    y=_y;
    num_marks= _num_marks;
    stroke_w=_stroke_w;
    //stroke_clr= _stroke_clr;
    mark_spacing = w/num_marks;
    mark_x_off=0;
    mark_y_off=0;
    x_shift_incr = pow(i_PHI, int(random(4)+i_PHI));
  }
  
  void update(){
  x+=x_shift_incr;
  }

  void render() {
    //println(canv);
    //color s_clr = color(random(),1.0,1.0);
    
    canv.stroke(0,255*i_PHI);
    canv.strokeWeight(stroke_w);
    
    for (int i=0; i<num_marks; i++) {

      float mark_x = (mark_spacing/2)+x + mark_spacing*i;
      float mark_y = y;
      float mark_x_2 = mark_x+mark_x_off;
      float mark_y_2 = mark_y+h+mark_y_off;
      canv.line(mark_x, mark_y, mark_x_2, mark_y_2);
    }
  }
}
