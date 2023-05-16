# Tools for processing Genericode codelists

This repository contains few XSLT utilities for working with OASIS Genericode codelists.

## [`gc2html.xsl`](xsl/gc2html.xsl)

This transformation converts codelist into simple HTML table. 

By default all columns are output. It is possible to filter columns by setting parameter `columns` to regular expression that will match only specific column IDs. E.g. `id|name|description`.

## [`gc2md.xsl`](xsl/gc2md.xsl)

This transformation converts codelist into simple Markdown. 

By default all columns are output. It is possible to filter columns by setting parameter `columns` to regular expression that will match only specific column IDs. E.g. `id|name|description`.



