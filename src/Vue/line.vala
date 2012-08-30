using Clutter;
using GLib;
using Cairo;

namespace Jdr.View {
	public class Line : Clutter.Actor {
		
		private int _x;
		private int _y;
		private int _xx;
		private int _yy;
		
		private bool top;
		
		private Clutter.CairoTexture cairo;
		
		public int start_x {
			get { return _x; }
			set { _x = value; update_rect (); }
		}
		
		public int start_y {
			get { return _y; }
			set { _y = value; update_rect (); }
		}
		
		public int end_x {
			get { return _xx; }
			set { _xx = value; update_rect (); }
		}
		
		public int end_y {
			get { return _yy; }
			set { _yy = value; update_rect (); }
		}
		
		public Line (int x, int y, int xx, int yy) {
			start_x = x;
			start_y = y;
			end_x = xx;
			end_y = yy;
			
			this.cairo = new CairoTexture ((int) this.width , (int) this.height);
			this.cairo.auto_resize = true;
			this.cairo.height = ((this._y - this._yy) < 0) ? this._yy - this._y : this._y - this._yy;
			this.cairo.width = this._xx - this._x;
			
			this.cairo.draw.connect ((ctx) => {
				cairo_set_source_color (ctx, Color.from_string ("red"));
				this.cairo.clear ();
				ctx.set_line_width (2);
				float oldx = 0;
				float oldy = 0;
				float nx = this.width;
				float ny = this.height;
				
				if (top) {
					oldy = ny;
					ny = 0;
				}
				
				ctx.move_to (oldx,oldy);
				ctx.line_to (nx, ny);
				ctx.stroke ();
				
				return true;
			});
			
			this.add_actor (cairo);
		}
		
		private void update_rect () {
			if (_y < _yy) {
				this.x = _x;
				this.y = _y;
				this.width = _xx - _x;
				this.height = _yy - _y;
				
				top = false;
			} else {
				this.x = _x;
				this.y = _yy;
				this.width = _xx - _x;
				this.height = _y - _yy;
				
				top = true;
			}
		}
	}
}
