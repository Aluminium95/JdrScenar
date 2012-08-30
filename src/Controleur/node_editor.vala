using GLib;
using Clutter;

namespace Jdr.Control {
	/*public class NodeEditor : Object {
		public Jdr.View.NodeEditor view;
		public weak Jdr.Model.Node? model; // current node
		
		public signal void valueUpdated (Jdr.Model.Node n);
		public signal void requestFocus (Actor a);
		
		public NodeEditor () {
			this.view = new Jdr.View.NodeEditor ();
			
			this.view.display.set_editable (true);
			this.view.display.set_selectable (true);
			this.view.display.set_line_wrap (true);
			var a = new ClickAction ();
			a.clicked.connect (() => {
				requestFocus (this.view.display);
			});
			this.view.display.add_action (a);
			
			this.view.display.text_changed.connect (() => {
				stdout.printf ("Text : %s\n", this.view.display.text);
			});
		}
		
		public Actor get_display_actor () {
			return this.view as Actor;
		}
		
		public Jdr.View.NodeEditor get_view () {
			return this.view;
		}
		
		public void modify_name (string name) {
			// editor.nameEntry.text = name; // Dans l'idée quoi ...
		}
		
		public void modify_desc (string desc) {
			// editor.nameDesc.text = name; // Dans l'idée quoi ...
		}*/
				
		/*public void set_model (Jdr.Model.Node? n) {
			this.model = n;*/
			/**
			 * Update UI
			 */
			/*this.view.display.text = n.name;
		}
		
		protected void modify_name_cb (string text) {
			this.model.name = text;
		}
		
		protected void modify_desc_cb (string desc) {
			this.model.description = desc;
		}
	}*/
}
