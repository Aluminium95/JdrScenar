using Gtk;

namespace Jdr.Control {
	public class NodeEdition : Object {
		private int _props = 0x0;
		
		// Normalement il ne peut être null ... 
		public weak Jdr.Model.Node? current;
		
		private Entry _nom;
		private Button _appliquer;
		private Button _new_left;
		private Button _new_right;
		private Button _delete_left;
		private Button _delete_right;
		
		/*
		 * Les widget de modification
		 * 
		 * (null par défaut ... donc il faut IMPÉRATIVEMENT les mettres)
		 * 
		 * Création d'un compteur (_props) qui vérifie que tout est bien là
		 * (moche ... à changer ... )
		 */
		public Entry nom { 
			get { return _nom; }
			set {
				if (value != null) {
					_nom = value;
					_props = _props | 0x1;
				}
			}
		}
		
		public Button appliquer {
			get { return _appliquer; }
			set {
				if (value != null) {
					_appliquer = value;
					_props = _props | 0x10;
				}
			}
		}
			
		public Button new_left {
			get { return _new_left; }
			set {
				if (value != null) {
					_new_left = value;
					_props = _props | 0x100;
				}
			}
		}
		
		public Button new_right {
			get { return _new_right; }
			set {
				if (value != null) {
					_new_right = value;
					_props = _props | 0x1000;
				}
			}
		}
		
		public Button delete_right {
			get { return _delete_right; }
			set {
				if (value != null) {
					_delete_right = value;
					_props = _props | 0x10000;
				}
			}
		}
		
		public Button delete_left {
			get { return _delete_left; }
			set {
				if (value != null) {
					_delete_left = value;
					_props = _props | 0x100000;
				}
			}
		}
		
		public NodeEdition () {
			
		}
		
		public void set_current_node (Jdr.Model.Node n) {
			this.current = n;
			this.nom.text = n.name;
			
			update_buttons ();
		}
		
		private void update_buttons () {
			if (_props == 1118465) {
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
		}
		
		public void save () {
			if (_props == 1118465) {
				/**
				 * Regarde les entrées ... et 
				 * sauvegarde sur le node ...
				 */
				this.current.name = this.nom.text;
			}
			
		}
	}
}
