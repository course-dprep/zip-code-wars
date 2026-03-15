.PHONY: all data-preparation-base data_exploration data-preparation analysis clean

all: analysis

data-preparation-base:
	make -C data-preparation ../../gen/temp/research_project_filtered.csv

data_exploration: data-preparation-base
	make -C data_exploration

data-preparation: data_exploration
	make -C data-preparation

analysis: data-preparation
	make -C analysis

clean:
	R -e "unlink('../data', recursive = TRUE)"
	R -e "unlink('../gen', recursive = TRUE)"
