# quarto-julia

Julia interface to the [Quarto](https://github.com/quarto-dev/quarto-cli/wiki) CLI.

Quarto is an academic, scientific, and technical publishing system built on [Pandoc](https://pandoc.org).

In addition to the core capabilities of Pandoc, Quarto includes:

1.  Support for embedding output from Python, R, and Julia via integration with [Jupyter](https://jupyter.org/) and [knitr](https://yihui.org/knitr/) .
2.  A project system for rendering groups of documents at once.
3.  Flexible ways to specify rendering options, including project-wide options and per-format options.
4.  Cross references for figures, tables, equations, sections, listings, proofs, and more.
5.  Sophisticated layout for panels of figures, tables, and other content.
6.  HTML output based on [Bootstrap](https://getbootstrap.com/) (including support for [Bootswatch](https://bootswatch.com/) themes).
7.  Automatic installation of required LaTeX packages when rendering PDF output.

The overall design of Quarto is influenced heavily by [R Markdown](https://rmarkdown.rstudio.com/), however unlike R Markdown the architecture is language agnostic. In it's current iteration, Quarto can render plain markdown, Rmd documents, and Jupyter notebooks.

For additional documentation, see the [Quarto Wiki](https://github.com/quarto-dev/quarto-cli/wiki).

To get started with using the Julia Jupyter kernel with Quarto, see the documentation on [Jupyter Markdown](https://github.com/quarto-dev/quarto-cli/wiki/Jupyter-Markdown).
