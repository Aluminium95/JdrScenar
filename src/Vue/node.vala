using GLib;
using Clutter;

namespace Jdr.View {
	public enum NodeColor {
		GREEN,
		RED,
		BLUE,
		YELLOW,
		VIOLET,
		PINK
	}
	
	public class Node : Actor {
		private weak Jdr.Model.Node? _model;
		
		public weak Jdr.Model.Node? model {
			get { return _model; }
			set {
				_model = value;
				value.notify["name"].connect (() => { text.text = _model.name; });
			}
		}
		
		private Texture texture;
		private Text text;
		
		public double y_pos;
		
		private NodeColor _color;
		public NodeColor node_color {
			get { return _color; }
			set {
				_color = value;
				change_color (value);
			}
		}
		
		public Node () {
			this.width = 50;
			this.height = 50;
			this.texture = new Texture ();
			this.texture.x = 0;
			this.texture.y = 0;
			this.add_child (texture);
			
			text = new Text.full ("Sans 15", "This is a text", Color.from_string ("orange"));
			text.x = 55;
			text.y = 12;
			this.add_child (text);
			
			this.node_color = NodeColor.BLUE;
		}
		
		public void change_color (NodeColor n) {
			if (n == NodeColor.RED || n == NodeColor.VIOLET) {
				this.text.animate (AnimationMode.EASE_OUT_CUBIC, 1000,
									"scale-x", 1.0, "opacity", 255);
			} else {
				this.text.animate (AnimationMode.EASE_OUT_CUBIC, 1000,
									"scale-x", 0.0, "opacity", 0);
			}
			
			string c = "";
			switch (n) {
				case NodeColor.BLUE:
					c = "blue.png";
					break;
				case NodeColor.RED:
					c = "red.png";
					break;
				case NodeColor.GREEN:
					c = "green.png";
					break;
				case NodeColor.PINK:
					c = "pink.png";
					break;
				case NodeColor.VIOLET:
					c = "violet.png";
					break;
				case NodeColor.YELLOW:
					c = "yellow.png";
					break;
			}
			try {
				this.texture.set_from_file ("/home/aluminium95/Code/Vala/JdrScenar/data/" + c);
			} catch (Error e) {
				this.background_color = Color.from_string ("blue");
			}
		}
	}
}
