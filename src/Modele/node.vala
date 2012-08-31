using GLib;

namespace Jdr.Model {
	/**
	 * Type du choix à faire
	 *  	Inutile pour le moment ... 
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
	 * 		Inutile pour l'instant 
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
		
		public weak Jdr.View.Node? view; // À supprimer 
		
		public signal void setLeftNode (Node n);
		public signal void setRightNode (Node n);
		public signal void deletedNode (Node self);
		
		
		public weak Node? _parent = null;
		
		private Node? _left = null;
		private Node? _right = null;
		
		public int rang { get; private set; }
		
		/**
		 * Lien faible vers le parent
		 * 
		 * (définit le rang automatiquement à partir du parent)
		 */
		public weak Node? parent {
			get { return _parent; }
			set { this.rang = value.rang + 1; this._parent = value; }
		}
		
		/**
		 * Définit le node de gauche (émet le signal setLeftNode)
		 * 
		 * S'ajoute automatiquement comme parent de ce node
		 */
		public Node? left {
			get { return _left; }
			set { _left = value; _left.parent = this; setLeftNode (value); }
		}
		
		/**
		 * Définit le node de droite (émet le signal setRightNode)
		 * 
		 * S'ajoute automatiquement comme parent de ce node
		 */
		public Node? right {
			get { return _right; }
			set {  _right = value; _right.parent = this; setRightNode (value); }
		}
		
		public string name { get; set; }
		public string description { get; set; }
		public string declencheur { get; set; }
		public NodeType type;
		public NodeInfluence influence;
		
		/**
		 * Crée un node
		 */
		public Node () {
			
		}
		/**
		 * Crée un node
		 * 
		 * @n: parent du node
		 */
		public Node.with_parent (Node n) {
			this.parent = n;
			this.rang = this.parent.rang + 1;
		}
		
		/**
		 * Destructeur du Node
		 */
		~Node () {
			/*
			 * Il faut changer ça !
			 * 
			 * On vérifie qu'il existe une vue,
			 * Si oui on demande si elle possède un parent
			 * Si oui on supprime la vue du parent
			 *  (entrainant sa destruction)
			 */
			if (this.view != null && this.view is Clutter.Actor) {
				var p = this.view.get_parent ();
				if (p != null) {
					p.remove_child (this.view);
				}
			}
		}
		
		/**
		 * Supprime la branche de gauche
		 */
		public void delete_left () {
			/*
			 * Destruction de la référence 
			 * vers le node suivant,
			 * entrainant sa destruction (en chaîne)
			 */
			this._left = null;
		}
		
		/**
		 * Supprime la branche de droite
		 */
		public void delete_right () {
			/*
			 * Destruction de la référence 
			 * vers le node suivant,
			 * entrainant sa destruction (en chaîne)
			 */
			this._right = null;
		}
	}
}
