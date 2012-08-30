using GLib;
using Clutter;

namespace Jdr.View {
	public class Timeline : Actor
	{
		public signal void nodeClicked (Jdr.View.Node n);
		
		public Timeline () {
			/*this.set_from_file ("/home/aluminium95/Images/background.png");*/
			this.set_reactive (true);
			
			this.scroll_event.connect ((ev) => {
				switch (ev.direction) {
					case ScrollDirection.UP:
						zoom (true);
						break;
					case ScrollDirection.DOWN:
						zoom (false);
						break;
				}
				
				return true;
			});
			
			// this.background_color = Color.from_string ("yellow");
		}
		
		public void zoom (bool plus) {
		
			var p = this.get_parent ();
		
			// var center_x = p.width / 2 - this.x;
			
			var center_y = p.height / 2 - this.y;
			
			if (plus ==  true) {
				var nh = this.height * 1.4;
				var ny = this.y - (center_y * 1.4 - center_y);
				this.animate (AnimationMode.EASE_OUT_CUBIC, 200, "height", nh, "y", ny);
			} else {
				var nh = this.height * 0.6;
				var ny = this.y - (center_y * 0.6 - center_y);
				this.animate (AnimationMode.EASE_OUT_CUBIC, 200, "height", nh, "y", ny);
			}
		}
		
		/**
		 * Repositionne les enfants 
		 */
		public override void allocate (ActorBox box, AllocationFlags flags) {
			base.allocate (box, flags);
			var children = this.get_children ();
			
			foreach (var child in children) {
				ActorBox child_box = {0,0,0,0};
				child_box.x1 = child.x;
				child_box.y1 = (float) ((child as Jdr.View.Node).y_pos * this.height);
				child_box.x2 = child_box.x1 + child.width;
				child_box.y2 = child_box.y1 + child.height;
				
				child.allocate (child_box, flags);
			}
		}
		
		public void add_node (Jdr.View.Node disp_node, int x) {
			disp_node.x = x;
			
			disp_node.anchor_gravity = Gravity.CENTER;
			
			disp_node.set_reactive (true);
			var c_action = new ClickAction ();
			c_action.clicked.connect ((actor) => {
				stdout.printf ("actor clicked ... \n");
				nodeClicked (actor as Jdr.View.Node);
			});
			
			disp_node.add_action (c_action);
			
			this.add_child (disp_node);
		}
	}
}
