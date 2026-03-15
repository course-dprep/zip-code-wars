.PHONY: all src reporting clean
all: src reporting

src:
	make -C src

reporting: 
	make -C reporting

clean:
	R -e "unlink('../data', recursive = TRUE)"
	R -e "unlink('../gen', recursive = TRUE)"
