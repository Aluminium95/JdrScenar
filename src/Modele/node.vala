using GLib;

namespace Jdr.Model {
	/**
	 * Type du choix à faire
	 */
	public enum NodeType {
		PRINCIPAL,
		SECONDAIRE
	}
	
	/**
	 * Type de comportement qui amène à ce choix
	 * On peut combiner un fort et un faible :
	 * 		MAUVAIS / BON / NEUTRE => faible 
	 * 		CHAOTIQUE / LOYAL / STRICT => fort
	 * Exemple : 
	 *	 	CHAOTIQUE & NEUTRE = 0x13
	 */
	public enum NodeInfluence {
		RIEN = 0x00,
		MAUVAIS = 0x1,
		BON = 0x2,
		NEUTRE = 0x3,
		CHAOTIQUE = 0x10,
		LOYAL = 0x20,
		STRICT = 0x30
	}
	
	public class Node : GLib.Object {
		
		public weak Jdr.View.Node? view;
		
		public signal void setLeftNode (Node n);
		public signal void setRightNode (Node n);
		public signal void deletedNode (Node self);
		
		
		public weak Node? _parent = null;
		
		private Node? _left = null;
		private Node? _right = null;
		
		public int rang;
		
		public weak Node? parent {
			get { return _parent; }
			set { this.rang = value.rang + 1; this._parent = value; }
		}
		
		public Node? left {
			get { return _left; }
			set { _left = value; _left.parent = this; setLeftNode (value); }
		}
		
		public Node? right {
			get { return _right; }
			set {  _right = value; _right.parent = this; setRightNode (value); }
		}
		
		public string name { get; set; }
		public string description { get; set; }
		public string declencheur { get; set; }
		public NodeType type;
		public NodeInfluence influence;
				
		public Node () {
			
		}
		
		public Node.with_parent (Node n) {
			this.parent = n;
			this.rang = this.parent.rang + 1;
		}
		
		~Node () {
			if (this.view != null && this.view is Clutter.Actor) {
				var p = this.view.get_parent ();
				if (p != null) {
					p.remove_child (this.view);
				}
			}
		}
		
		public void delete_left () {
			this._left = null;
		}
		
		public void delete_right () {
			this._right = null;
		}
	}
}
