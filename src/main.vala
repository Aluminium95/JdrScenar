using GLib;
using Clutter;
using Gtk;

void main (string[] args)
{
	GtkClutter.init (ref args);
	
	var app = new MyApp ();
	Gtk.main ();
	
}
