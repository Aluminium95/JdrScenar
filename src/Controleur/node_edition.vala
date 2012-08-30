using Gtk;

namespace Jdr.Control {
	public class NodeEdition : Object {
		
		public weak Jdr.Model.Node? current;
		
		public Entry nom;
		public Button appliquer;
		public Button new_left;
		public Button new_right;
		public Button delete_right;
		public Button delete_left;
		
		public NodeEdition () {
			
		}
		
		public void set_current_node (Jdr.Model.Node n) {
			this.current = n;
			this.nom.text = n.name;
			
			update_buttons ();
		}
		
		private void update_buttons () {
			if (this.current.left != null) {
				this.new_left.set_sensitive (false);
			} else {
				this.new_left.set_sensitive (true);
			}
			
			if (this.current.right != null) {
				this.new_right.set_sensitive (false);
			} else {
				this.new_right.set_sensitive (true);
			}
			
			if (this.current.left == null) {
				this.delete_left.set_sensitive (false);
			} else {
				this.delete_left.set_sensitive (true);
			}
			
			if (this.current.right == null) {
				this.delete_right.set_sensitive (false);
			} else {
				this.delete_right.set_sensitive (true);
			}
		}
		
		public void save () {
			/**
			 * Regarde les entrées ... et 
			 * sauvegarde sur le node ...
			 */
			this.current.name = this.nom.text;
			
		}
	}
}
