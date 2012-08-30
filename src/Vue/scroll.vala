using GLib;
using Clutter;

namespace Jdr.View {
	public class ScrollTimeline : Actor {
		public Jdr.View.Timeline timeline;
		private DragAction d_action;
		
		public signal void requestFocusNode ();
		public signal void changeNodeLeft ();
		public signal void changeNodeRight ();
		public signal void changeNodeParent ();
		
		private Actor button_next_left;
		private Actor button_next_right;
		private Actor button_next_parent;
		private Actor button_zoom_plus;
		private Actor button_zoom_moins;
		private Actor button_first;
		
		private weak Jdr.View.Node? current;
		
		public void move_buttons (Jdr.View.Node n) {
			this.current = n;
			stdout.printf ("Node (%f,%f)\n", n.x, n.y);
			
			if (this.current.model.parent == null) {
				button_next_parent.animate (AnimationMode.EASE_OUT_CUBIC, 1000,
					"opacity", 0);
			} else {
				button_next_parent.animate (AnimationMode.EASE_OUT_CUBIC, 1000,
					"opacity", 255);
			}
			
			if (this.current.model.left == null) {
				button_next_left.animate (AnimationMode.EASE_OUT_CUBIC, 1000,
					"opacity", 0);
			} else {
				button_next_left.animate (AnimationMode.EASE_OUT_CUBIC, 1000,
					"opacity", 255);
			}
			
			if (this.current.model.right == null) {
				button_next_right.animate (AnimationMode.EASE_OUT_CUBIC, 1000,
					"opacity", 0);
			} else {
				button_next_right.animate (AnimationMode.EASE_OUT_CUBIC, 1000,
					"opacity", 255);
			}
			
			/*button_next_left.x = n.x + 50 + this.timeline.x;
			button_next_left.y = n.y - 50 + this.timeline.y;
			
			button_next_right.x = n.x + 50 + this.timeline.x;
			button_next_right.y = n.y + 50 + this.timeline.y;*/
		}
		
		private inline void auto_bind (Actor a, float x, float y, AllocationFlags flags) {
			
			ActorBox child_box = {0,0,0,0};
			var cx = (current != null) ? current.x : 0;
			var cy = (current != null) ? current.y : 0;
			
			child_box.x1 = timeline.x + x + cx;
			child_box.y1 = timeline.y + y + cy;
			child_box.x2 = child_box.x1 + a.width;
			child_box.y2 = child_box.y1 + a.height;
			a.allocate (child_box, flags);
			
			
			/*this.timeline.notify["x"].connect (() => {
				if (this.current != null) {
					a.x = timeline.x + x + this.current.x;
				}
			});
			
			this.timeline.notify["y"].connect (() => {
				if (this.current != null) {
					a.y = timeline.y + y + this.current.y;
				}
			});*/
			
			/*this.timeline.notify["height"].connect (() => {
				a.y = timeline.y + y + this.current.y;
			});*/
		}
		
		/**
		 * Repositionne les enfants 
		 */
		public override void allocate (ActorBox box, AllocationFlags flags) {
			base.allocate (box, flags);
			
			ActorBox child_box = {0,0,0,0};
			child_box.x1 = timeline.x;
			child_box.y1 = timeline.y;
			child_box.x2 = timeline.x + timeline.width;
			child_box.y2 = timeline.y + timeline.height;
			timeline.allocate (child_box, flags);
			
			auto_bind (button_next_left, 30, - 80, flags);
			auto_bind (button_next_right, 30, 30, flags);
			auto_bind (button_next_parent, -100, -25, flags);
			
			auto_bind (button_zoom_moins, 0,-100, flags);
			auto_bind (button_zoom_plus, 0, 50, flags); 
			
			child_box.x1 = button_first.x;
			child_box.y1 = button_first.y;
			child_box.y2 = button_first.y + button_first.height;
			child_box.x2 = button_first.x + button_first.width;
			button_first.allocate (child_box, flags);
			
		}
		
		public ScrollTimeline () {
			this.set_clip_to_allocation (true);
			
			this.timeline = new Jdr.View.Timeline ();
			
			this.add_child (timeline);
	
			d_action = new DragAction ();
			
			this.background_color = Color.from_string ("black");
			
			d_action.drag_end.connect ((actor, x, y, mod) => {
				
			});
			
			this.timeline.add_action (d_action);
			
			try {
				button_first = new Texture.from_file ("/home/aluminium95/Code/Vala/JdrScenar/data/red.png");
				button_first.set_reactive (true);
				button_first.width = 50;
				button_first.height = 50;
				button_first.add_constraint (new BindConstraint (this, BindCoordinate.X, 10));
				button_first.add_constraint (new BindConstraint (this, BindCoordinate.Y, 10));
			
				var first_click = new ClickAction ();
				first_click.clicked.connect (() => {
					requestFocusNode ();
				});
			
				button_first.add_action (first_click);
				this.add_child (button_first);
			
			
			
				button_zoom_plus =  new Texture.from_file ("/home/aluminium95/Code/Vala/JdrScenar/data/plus.png");
				button_zoom_plus.set_reactive (true);
				button_zoom_plus.width = 50;
				button_zoom_plus.height = 50;
//~ 				button_zoom_plus.add_constraint (new BindConstraint (this, BindCoordinate.X, 70));
//~ 				button_zoom_plus.add_constraint (new BindConstraint (this, BindCoordinate.Y, 10));
			
				var zoom_plus_click = new ClickAction ();
				zoom_plus_click.clicked.connect (() => {
					this.timeline.zoom (true);
				});
			
				button_zoom_plus.add_action (zoom_plus_click);
				this.add_child (button_zoom_plus);
			
			
				button_zoom_moins = new Texture.from_file ("/home/aluminium95/Code/Vala/JdrScenar/data/moins.png");
				button_zoom_moins.set_reactive (true);
				button_zoom_moins.width = 50;
				button_zoom_moins.height = 50;
//~ 				button_zoom_moins.add_constraint (new BindConstraint (this, BindCoordinate.X, 140));
//~ 				button_zoom_moins.add_constraint (new BindConstraint (this, BindCoordinate.Y, 10));
			
				var zoom_moins_click = new ClickAction ();
				zoom_moins_click.clicked.connect (() => {
					this.timeline.zoom (false);
				});
			
				button_zoom_moins.add_action (zoom_moins_click);
				this.add_child (button_zoom_moins);
			
			
				button_next_left = new Texture.from_file ("/home/aluminium95/Code/Vala/JdrScenar/data/left.png");
				button_next_left.set_reactive (true);
				button_next_left.width = 50;
				button_next_left.height = 50;
//~ 				button_next_left.add_constraint (new BindConstraint (this, BindCoordinate.X, 31));
//~ 				button_next_left.add_constraint (new BindConstraint (this, BindCoordinate.Y, 119));
			
				var next_left_click = new ClickAction ();
				next_left_click.clicked.connect (() => {
					this.changeNodeLeft ();
				});
			
				button_next_left.add_action (next_left_click);
				this.add_child (button_next_left);
			
			
				button_next_right = new Texture.from_file ("/home/aluminium95/Code/Vala/JdrScenar/data/right.png");
				button_next_right.set_reactive (true);
				button_next_right.width = 50;
				button_next_right.height = 50;
//~ 				button_next_right.add_constraint (new BindConstraint (this, BindCoordinate.X, 31));
//~ 				button_next_right.add_constraint (new BindConstraint (this, BindCoordinate.Y, 156));
			
				var next_right_click = new ClickAction ();
				next_right_click.clicked.connect (() => {
					this.changeNodeRight ();
				});
			
				button_next_right.add_action (next_right_click);
				this.add_child (button_next_right);
			
			
				button_next_parent = new Texture.from_file ("/home/aluminium95/Code/Vala/JdrScenar/data/parent.png");
				button_next_parent.set_reactive (true);
				button_next_parent.width = 50;
				button_next_parent.height = 50;
//~ 				button_next_parent.add_constraint (new BindConstraint (this, BindCoordinate.X, 0));
//~ 				button_next_parent.add_constraint (new BindConstraint (this, BindCoordinate.Y, 137));
			
				var next_parent_click = new ClickAction ();
				next_parent_click.clicked.connect (() => {
					this.changeNodeParent ();
				});
			
				button_next_parent.add_action (next_parent_click);
				this.add_child (button_next_parent);
				
				
			} catch (Error e) {
				stdout.printf ("euh ... pas d'images ... \n");
			}
			
		}
	}
}
