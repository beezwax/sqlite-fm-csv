## sqlite-fm-csv

A SQLite extension for importing CSV (Comma Seperated Values).

Compared to the sqlite's `.import` command, two key differences are:

- allows use of CR (carriage return) line delimiters
- can be called from SQLite's C API

The reason for the optional use CR delimited line endings was to allow easy importing of FileMaker .csv exports from macOS systems, which always use CR's instead of newlines, and will be included with the bBox FileMaker plug-in.

The C code is very much based on the original CSV extension provided at sqlite.com.

---
### References

- https://www.rfc-editor.org/rfc/rfc4180
- https://www.sqlite.org/src/artifact?ci=trunk&filename=ext/misc/csv.c
- https://www.sqlite.org/c3ref/load_extension.html


