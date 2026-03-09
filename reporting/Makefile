all: report

report:
	Rscript -e "rmarkdown::render('Week2 Deliverable - Team 5.Rmd', output_format='pdf_document')"

clean:
	rm -f "Week2 Deliverable - Team 5.pdf"

.PHONY: all report clean