#############################################################################

PACKAGE=italic-man
VER=1.0
REL=1

#############################################################################
# help

all:
	@echo $(MAKE) cygwin to build cygwin src and bin packages
	@echo $(MAKE) install to install files and configure /etc/man_db.conf
	@echo $(MAKE) uninstall to remove files and unconfigure

#############################################################################
# build variables

DESTDIR=
prefix=$(DESTDIR)/usr
bindir=$(prefix)/bin
datadir=$(prefix)/share
mandir=$(prefix)/share/man
rundir=$(datadir)/$(PACKAGE)

vars:
	echo prefix $(prefix)
	echo rundir $(rundir)

#############################################################################
# installation

install:	installfiles
	sh ./postinstall

installfiles:
	for s in 1 2 3 4 5 6 7 8; do if ls *.$$s 2>/dev/null; then mkdir -p $(mandir)/man$$s; cp *.$$s $(mandir)/man$$s/; fi; done
	mkdir -p $(rundir)
	cp -fp grotty iroff $(rundir)/

uninstall:	uninstallfiles
	sh ./preremove

uninstallfiles:
	for s in 1 2 3 4 5 6 7 8; do if ls *.$$s 2>/dev/null; then rm -f $(mandir)/man$$s/$(PACKAGE).$$s; fi; done
	rm -f $(rundir)/grotty $(rundir)/iroff
	rmdir $(rundir)

#############################################################################
# package files

STUFF=italic-man.cygport LICENSE
FILES=grotty iroff italic-man.7 postinstall preremove Makefile README.md $(STUFF)

#############################################################################
# cygwin packages

cygwin:	bin src

TARUSER := --owner=root --group=root --owner=man --group=italic

man:
	for s in 1 2 3 4 5 6 7 8; do if ls *.$$s 2>/dev/null; then mkdir -p usr/share/man/man$$s; cp *.$$s usr/share/man/man$$s/; fi; done
	gzip -f usr/share/man/man*/*.[1-8]

deploy:
	if [ -f postinstall ]; then mkdir -p etc/postinstall; cp -fp postinstall etc/postinstall/$(PACKAGE).sh; fi
	if [ -f preremove ]; then mkdir -p etc/preremove; cp -fp preremove etc/preremove/$(PACKAGE).sh; fi

perpetual:
	cd etc/postinstall; ln -f $(PACKAGE).sh zp_$(PACKAGE).sh

bin:	man deploy perpetual
	mkdir -p usr/share/$(PACKAGE)
	cp -fp grotty iroff usr/share/$(PACKAGE)/
	tar cJf $(PACKAGE)-$(VER)-$(REL).tar.xz --exclude="*~" $(TARUSER) usr etc

src:
	mkdir -p $(PACKAGE)
	cp -fp $(FILES) $(PACKAGE)
	tar cJf $(PACKAGE)-$(VER)-$(REL)-src.tar.xz --exclude="*~" $(TARUSER) $(PACKAGE)

origsrc:
	tar czf $(PACKAGE)-$(VER).tar.gz $(TARUSER) $(FILES)

#############################################################################
# end
