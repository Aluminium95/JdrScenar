using Clutter;
using GLib;

namespace Jdr.View {
	/**
	 * Améliorer la classe pour permette l'ajout simple
	 * des éléments (UI fixe) 
	 *		- toolbar
	 *		- pane
	 *		- central
	 */
	public class MainLayout : Actor {
		public MainLayout () {
			this.background_color = Color.from_string ("orange");
			this.set_layout_manager (new BoxLayout ());
			(this.layout_manager as BoxLayout).vertical = false;
		}
		
		public void add_elem (Actor a, bool f = false, bool ff = false, bool fff = false) {
			(this.layout_manager as BoxLayout).pack (a,f, ff, fff, 0, 0);
		}
		
		public void add_elem_full (Actor a, bool f = true, bool ff = true, bool fff = true) {
			(this.layout_manager as BoxLayout).pack (a,f, ff, fff, 0, 0);
		}
	}
}
