## sqlite-fm-csv

A SQLite extension for importing CSV (Comma Seperated Values).

Compared to the sqlite's `.import` command it has fewer features, but has two key benefits:

- optional use of CR (carriage return) line delimiters
- can be used from SQLite's C API

The main reason for this extension was to allow easy importing of data exported from FileMaker databases. CSV exports created using FileMaker's Export Records function on macOS or Linux systems uses CR (ASCII 13) characters instead of newlines (ASCII 10) to delimit records (this is not the case on Windows however). The main symptom you'll see if attempting to import CR delimited CSV files into sqlite is that only the first row/record will be imported.

If you don't mind a small extra dependency, and are using the `sqlite` command's `.import` function anyway, you can use a command like this to convert the line endings:

```
tr "my/input/file" "\r" "\n" >"my/output/file"
```
One big caveat with the above -- what if there is an embeded CR character in a field? The `tr` command has no concept of CSV fields, and will chop the field and its record in two. 

FileMaker CSV exports do not include headers, so you will typically need to use the `schema=` parameter to create the fields you need in SQLite.

This extension will be included in version 1.04 and up of the bBox FileMaker plug-in as an enhancement to its `bBox_SQLiteExec` function. The plug-in is a free download available at https://beezwax.net/products/bbox.

The C code is very much based on the original CSV extension provided at sqlite.com.

---
## Usage Examples

Here are examples of loading and using the compiled extension assuming using `sqlite` command:

```
# Load the extension into sqlite
.load ./fm_csv

# Import the .csv file, using CR delimited lines, and creating a table with the column names we want.
CREATE VIRTUAL TABLE examples.temp USING fm_csv(crlines,filename='/private/tmp/examples.csv',schema='CREATE TABLE csv(category TEXT,create_date TEXT,enabled_t INTEGER)');
```

---
### References

- https://www.sqlite.org/src/artifact?ci=trunk&filename=ext/misc/csv.c
- https://www.rfc-editor.org/rfc/rfc4180
- https://www.sqlite.org/c3ref/load_extension.html
- https://sqlite.org/loadext.html


