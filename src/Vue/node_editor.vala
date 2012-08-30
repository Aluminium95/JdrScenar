using Clutter;
using GLib;

namespace Jdr.View {
	public class NodeEditor : Actor {
		public Text display;
		
		public NodeEditor () {
			this.set_layout_manager (new BoxLayout ());
			var lay = this.layout_manager as BoxLayout;
			lay.vertical = true;
			
			display = new Text.full ("Sans 22", "Salut tout le monde", Color.from_string ("orange"));
			display.set_editable (true);
			display.set_selectable (true);
			var tt = new Text.full ("Sans 22", "Édition du Node", Color.from_string ("orange"));

			var r = new Rectangle ();
			r.color = Color.from_string ("yellow");
			r.width = 50;
			r.height = 50;
			
			lay.pack (tt, false, false, false, 0, 0);
			lay.pack (r, true, true, true, 0, 0);
			lay.pack (display, true, true, true, 0, 0);
			
			this.background_color = Color.from_string ("#555753");
		}
	}
}
