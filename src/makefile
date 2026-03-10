.PHONY: all data-preparation data_exploration analysis clean

all: data-preparation data_exploration analysis

data-preparation:
	make -C data-preparation

data_exploration: data-preparation
	make -C data_exploration

analysis: data-preparation data_exploration
	make -C analysis

clean:
	R -e "unlink('../data', recursive = TRUE)"
	R -e "unlink('../gen', recursive = TRUE)"