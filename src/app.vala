using GLib;
using Gtk;
using Clutter;

/**
 * Application en elle-même
 */
public class MyApp : Object {
	private Stage st;
	private Jdr.Control.Timeline ctrl_time;
	// private Jdr.Control.NodeEditor ctrl_editor;
	
	private Jdr.Control.NodeEdition ctrl_node;
	
	private Jdr.View.Node _current;
	
	/**
	 * Le Node sélectionné actuellement,
	 * sa mise à jour met à jour les controleurs
	 */
	public Jdr.View.Node selected {
		get { return _current; }
		set {
			this.ctrl_node.set_current_node (value.model);
			this.ctrl_time.set_current_node (value);
			this._current = value;
		}
	}
	
	public MyApp () {
		this.ctrl_node = new Jdr.Control.NodeEdition ();
		create_gtk_layout ();
		create_clutter_layout ();
	}
	
	/**
	 * Crée tout ce qui est dans la 
	 * zone Clutter
	 */
	private void create_clutter_layout () {
		this.st.set_layout_manager (new BoxLayout ());
		
		this.ctrl_time = new Jdr.Control.Timeline ();
		
		ctrl_timeline_signals ();
		
		// (this.st.layout_manager as BoxLayout).pack (ctrl_editor.get_display_actor (), true, true, true, 0, 0);
		
		(this.st.layout_manager as BoxLayout).pack (ctrl_time.get_display_actor (), true, true, true, 0, 0);
		
		create_tree ();
		
		this.ctrl_time.changeCurrentNode (this.ctrl_time.model.root_node.view);
		
		this.st.show ();
	}
	
	/**
	 * 	Crée le layout gtk global et connecte ses actions
	 */
	private void create_gtk_layout () {
		var builder = new Gtk.Builder ();
		builder.add_from_file ("/home/aluminium95/Code/Vala/JdrScenar/data/main.ui");
		
		var window = builder.get_object ("window") as Window;
		var layout = builder.get_object ("gb") as Gtk.Box;
		var zone_dessin = new GtkClutter.Embed ();
		layout.add (zone_dessin);
		this.st = zone_dessin.get_stage () as Stage;
		this.ctrl_node.nom = builder.get_object ("entry_name") as Gtk.Entry;
		var appliquer = builder.get_object ("appliquer") as Gtk.Button;
		
		appliquer.clicked.connect (() => {
			this.ctrl_node.save ();
		});
		
		var new_left = builder.get_object ("new-left") as Gtk.Button;
		this.ctrl_node.new_left = new_left;
		new_left.clicked.connect (() => {
			if (this.selected.model.left == null) {
				var n = new Jdr.Model.Node ();
				this.selected.model.left = n;
				this.selected = this.selected;
			}
		});
		
		var new_right = builder.get_object ("new-right") as Gtk.Button;
		this.ctrl_node.new_right = new_right;
		new_right.clicked.connect (() => {
			if (this.selected.model.right == null) {
				var n = new Jdr.Model.Node ();
				this.selected.model.right = n;
				this.selected = this.selected;
			}
		});
		
		var delete_left = builder.get_object ("delete-left") as Gtk.Button;
		this.ctrl_node.delete_left = delete_left;
		delete_left.clicked.connect (() => {
			if (this.selected.model.parent != null) {
				this.selected.model.delete_left ();
				this.selected = this.selected;
			}
		});
		
		var delete_right = builder.get_object ("delete-right") as Gtk.Button;
		this.ctrl_node.delete_right = delete_right;
		delete_right.clicked.connect (() => {
			if (this.selected.model.parent != null) {
				this.selected.model.delete_right ();
				this.selected = this.selected;
			}
		});
		
		window.show_all ();
		window.destroy.connect (() => {Gtk.main_quit (); });
	}
	
	/**
	 * Connecte les signaux du controleur timeline
	 */
	private void ctrl_timeline_signals () {
		
		
		this.ctrl_time.view.timeline.nodeClicked.connect ((node) => { 
			selected = node;
		});
		
		this.ctrl_time.changeCurrentNode.connect ((new_node) => {
			// stdout.printf ("Salut tout le monde \n");
			selected = new_node;
		});
	}
	
	/** 
	 * ?
	 */
	private void update_infos () {
		
	}
	
	/**
	 * Fonction qui crée un arbre de démonstration ... 
	 */
	private void create_tree () {
		var node = ctrl_time.model.root_node;
		
		/*
		 * Peut-être qu'une API avec des fonctions 
		 * comme node.set_left () serait plus jolie ?
		 */
		
		// Sample tree ... Créer un constructeur depuis un fichier !
		node.left = new Jdr.Model.Node ();
		node.left.name = "Test";
			node.left.left = new Jdr.Model.Node ();
			node.left.left.name = "Aliaume";
				node.left.left.left = new Jdr.Model.Node ();
				node.left.left.left.name = "Yann";
				node.left.left.right = new Jdr.Model.Node ();
				node.left.left.right.name = "Thomas";
			node.left.right = new Jdr.Model.Node ();
			node.left.right.name = "Bastien";
				node.left.right.right = new Jdr.Model.Node ();
				node.left.right.right.name = "Ludivine";
				node.left.right.left = new Jdr.Model.Node ();
				node.left.right.left.name = "Éline";
	
		node.right = new Jdr.Model.Node ();
		node.right.name = "Autre test";
			/*node.right.left = new Jdr.Model.Node ();
				node.right.left.left = new Jdr.Model.Node ();
				node.right.left.right = new Jdr.Model.Node ();*/
			node.right.right = new Jdr.Model.Node ();
			node.right.right.name = "Salut tout ...";
				node.right.right.right = new Jdr.Model.Node ();
				node.right.right.name = "Hey jude !";
				// node.right.right.left = new Jdr.Model.Node ();
				
		// this.ctrl_time.draw_tree (); -- Obsolète 
	}
}
