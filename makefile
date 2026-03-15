all: data-preparation data_exploration analysis reporting

data-preparation:
	make -C data-preparation

data_exploration: data-preparation
	make -C data_exploration

analysis: data-preparation data_exploration
	make -C analysis

reporting: 
	make -C reporting

clean:
	R -e "unlink('../data', recursive = TRUE)"
	R -e "unlink('../gen', recursive = TRUE)"
