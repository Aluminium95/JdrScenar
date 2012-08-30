using GLib;


namespace Jdr.Model {
	public class Tree : GLib.Object {
		public Node root_node;
		
		// Profondeur max de l'arbre
		public int profondeur { get; private set; }
		
		public signal void nodeDeleted (Jdr.View.Node node);
		
		public Tree () {
			this.root_node = new Jdr.Model.Node ();
			this.root_node.setLeftNode.connect (on_node_added);
			this.root_node.setRightNode.connect (on_node_added);
			this.root_node.deletedNode.connect (on_node_deleted);
		}
		
		private void on_node_added (Node n) {
			if (this.profondeur < n.rang) {
				this.profondeur = n.rang;
			}
			
			n.setLeftNode.connect (on_node_added);
			n.setRightNode.connect (on_node_added);
			n.deletedNode.connect (on_node_deleted);
		}
		
		private void on_node_deleted (Node n) {
			stdout.printf ("Node deleted\n");
			/*nodeDeleted (n.view);
			
			if (n.left != null) {
				
			}
			
			if (n.right != null) {
			
			}*/
		}
	}
}
