#!/usr/bin/make -f

SIZE= 16 20 22 24 32 36 40 48 64 72 96 128 192 256

all:
	# requires inkscape and imagemagick to be installed
	@if [ ! -x /usr/bin/convert ]; then \
	    echo "ERROR: imagemagick not installed!" ; \
	    false ; \
	fi

	@if [ ! -x /usr/bin/inkscape ]; then \
	    echo "ERROR: inkscape not installed!" ; \
	    false ; \
	fi

	for i in ${SIZE}; do \
	    mkdir -p "hicolor/$${i}x$${i}/apps" ; \
	    for k in $$(ls *svg); do \
	        kstrip=$$(echo $${k} | awk -F . {'print $$1'}) ; \
	        inkscape --export-width=$${i} \
	            --export-height=$${i} \
	            --export-png="$(CURDIR)/hicolor/$${i}x$${i}/apps/$${kstrip}.png" \
	                $(CURDIR)/$${kstrip}.svg ; \
	    done; \
	done

	mkdir -p pixmaps

	cd hicolor/32x32/apps; \
	for i in $$(ls *png); do \
	    kstrip=$$(echo $${i} | awk -F . {'print $$1'}); \
	    convert $${i} ../../../pixmaps/$${kstrip}.xpm; \
	done;

	cd hicolor/16x16/apps; \
	for i in $$(ls *png); do \
	    kstrip=$$(echo $${i} | awk -F . {'print $$1'}) ; \
	    convert $${i} ../../../pixmaps/$${kstrip}-16.xpm; \
	done;

	mkdir -p hicolor/scalable
	cp *.svg hicolor/scalable	

clean:
	$(RM) -r hicolor
	$(RM) -r pixmaps
