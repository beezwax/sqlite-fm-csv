## sqlite-fm-csv

A SQLite extension for importing CSV (Comma Seperated Values).

Compared to the sqlite's `.import` command, two key differences are:

- allows use of CR (carriage return) line delimiters
- can be called from SQLite's C API

The reason for the optional use of CR delimited line endings was to allow easy importing of FileMaker .csv exports from macOS systems, which always use CR's instead of newlines. This extension will also be included as part of the free bBox FileMaker plug-in, available at https://beezwax.net/products/bbox.

The C code is very much based on the original CSV extension provided at sqlite.com.

---
## Usage Examples

Here are examples of loading and using the compiled extension assuming using `sqlite` command:

```
# Load the extension into sqlite
.load ./fm_csv

# Import the .csv file, using CR delimited lines, and creating a table with the column names we want.
CREATE VIRTUAL TABLE examples.temp USING fm_csv(crlines=YES,filename='/private/tmp/examples.csv',schema='CREATE TABLE csv(category TEXT,create_date TEXT,enabled_t INTEGER)');
```

---
### References

- https://www.rfc-editor.org/rfc/rfc4180
- https://www.sqlite.org/src/artifact?ci=trunk&filename=ext/misc/csv.c
- https://www.sqlite.org/c3ref/load_extension.html


