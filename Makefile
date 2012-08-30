PROG = timeline
BUILD = build

SRC = src/main.vala \
		src/app.vala \
		"src/Modele"/*.vala \
		"src/Vue"/*.vala \
		"src/Controleur"/*.vala
		
PKG = --pkg clutter-1.0 --pkg cairo --pkg clutter-gtk-1.0


CC = valac --enable-experimental -X -lm -g

.PHONY: all

all:
	$(CC) $(SRC) $(PKG) -o $(BUILD)/$(PROG)


