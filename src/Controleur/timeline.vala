using GLib;
using Clutter;

namespace Jdr.Control {
	public class Timeline : Object {
		public Jdr.View.ScrollTimeline view;
		public Jdr.Model.Tree model;
		
		public Jdr.View.Node current;
		
		private Jdr.View.Node v_node;
		
		// Request ... 
		public signal void changeCurrentNode (Jdr.View.Node n);
		
		public void set_current_node (Jdr.View.Node? c) {
			if (current != null) {
				current.change_color (Jdr.View.NodeColor.BLUE);
				current.get_animation ().loop = false;
				current.animate (AnimationMode.EASE_OUT_CUBIC, 500, "opacity", 255);
				unset_nexts_nodes ();
			}
			
			this.current = c;
			
			this.focus_selected_node ();
		
			var anim = current.animate (AnimationMode.EASE_IN_CUBIC, 500, "opacity", 100);
			anim.loop = true;
			current.change_color (Jdr.View.NodeColor.RED);
					
			set_nexts_nodes ();
			
			this.view.move_buttons (this.current);
		}
		
		protected void set_nexts_nodes () {
			var c = this.current;
			if (c.model.left != null) {
				c.model.left.view.change_color (Jdr.View.NodeColor.VIOLET);
			}
			
			if (c.model.right != null) {
				c.model.right.view.change_color (Jdr.View.NodeColor.VIOLET);
			}
			
			if (c.model.parent != null) {
				c.model.parent.view.change_color (Jdr.View.NodeColor.VIOLET);
			}
		}
		
		protected void unset_nexts_nodes () {
			var c = this.current;
			if (c.model.left != null) {
				c.model.left.view.change_color (Jdr.View.NodeColor.BLUE);
			}
			
			if (c.model.right != null) {
				c.model.right.view.change_color (Jdr.View.NodeColor.BLUE);
			}
			
			if (c.model.parent != null) {
				c.model.parent.view.change_color (Jdr.View.NodeColor.BLUE);
			}
		}
		
		public void focus_selected_node () {
			if (current != null) {
				this.view.timeline.animate (AnimationMode.EASE_OUT_CUBIC, 2000, 
					"x", - current.x + this.view.width / 2,
					"y", - current.y + this.view.height / 2);
			}
		}
		
		public Timeline () {
			this.view = new Jdr.View.ScrollTimeline ();
			this.view.timeline.width = 1000;
			this.view.timeline.height = 1000; // le 10 est pour le padding
			this.view.width = 400;
			this.view.height = 400;
			this.model = new Jdr.Model.Tree ();
			
			var r_node = this.model.root_node;
			v_node = new Jdr.View.Node ();
			r_node.view = v_node;
			v_node.model = r_node;
			v_node.anchor_gravity = Gravity.CENTER;
			
			v_node.y_pos = 0.50;
			v_node.x = 100;
			this.view.timeline.add_node (v_node, 10);
			r_node.setRightNode.connect (on_node_added_right);
			r_node.setLeftNode.connect (on_node_added_left);
			
			this.changeCurrentNode (v_node);
			
			/**
			 * Connection des boutons 
			 */
			this.view.requestFocusNode.connect (() => {
				focus_selected_node ();
			});
			
			this.view.changeNodeLeft.connect (() => {
				if (this.current.model.left != null) {
					Jdr.View.Node n = this.current.model.left.view;
					this.changeCurrentNode (n);
				}
			});
			
			this.view.changeNodeRight.connect (() => {
				if (this.current.model.right != null) {
					Jdr.View.Node n = this.current.model.right.view;
					this.changeCurrentNode (n);
				}
			});
			
			this.view.changeNodeParent.connect (() => {
				if (this.current.model.parent != null) {
					Jdr.View.Node n = this.current.model.parent.view;
					this.changeCurrentNode (n);
				}
			});
		}
		
		public Actor get_display_actor () {
			return view as Actor;
		}
		
		public Jdr.View.ScrollTimeline get_view () {
			return view;
		}
		
		/**
		 * Récupère la différence entre un 
		 * node et son parent (pour le node de rang x)
		 */
		public double get_y_diff (int rang) {
			return 50 / GLib.Math.pow (2, rang) / 100;
		}
		
		private void on_node_added_right (Jdr.Model.Node n) {
			n.setLeftNode.connect (on_node_added_left);
			n.setRightNode.connect (on_node_added_right);
			
			var parent = n.parent;
			if (parent != null) {
				var node = new Jdr.View.Node ();
				node.anchor_gravity = Gravity.CENTER;
				n.view = node;
				node.model = n;
				node.y_pos = parent.view.y_pos + get_y_diff (n.rang);
				this.view.timeline.add_node (node, (int) parent.view.x + 200);
				this.view.timeline.width = 250 * this.model.profondeur;
			}
		}
		
		private void on_node_added_left (Jdr.Model.Node n) {
			n.setLeftNode.connect (on_node_added_left);
			n.setRightNode.connect (on_node_added_right);
			
			var parent = n.parent;
			if (parent != null) {
				var node = new Jdr.View.Node ();
				node.anchor_gravity = Gravity.CENTER;
				n.view = node;
				node.model = n;
				node.y_pos = parent.view.y_pos - get_y_diff (n.rang);
				this.view.timeline.add_node (node, (int) parent.view.x + 200);
				this.view.timeline.width = 250 * this.model.profondeur;
			}
		}
	}
}
