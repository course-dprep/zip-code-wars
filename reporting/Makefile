REPORT = Team_5_Report.pdf
RMD = Team_5_Report.Rmd

all: $(REPORT)

$(REPORT): $(RMD)
	Rscript -e "rmarkdown::render('$(RMD)', output_format='pdf_document')"

clean:
	rm -f $(REPORT)

.PHONY: all clean