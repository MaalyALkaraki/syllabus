# Creating Tables
**Creating and Modifying the Structure of the Database**

## Objectives
* To know how to create new tables
* To be able to add columns to a table
* To be able to drop unwanted tables
* To be able to create and drop indexes on tables
* To understand some of the complexities of DB design

---
## Creating a Table
Use the SQL command CREATE TABLE...

    CREATE TABLE invoice_items (
      invoice_id    INTEGER NOT NULL,
      item_no       INTEGER NOT NULL,
      charge_type   VARCHAR(20) NOT NULL,
      charge_time   TIMESTAMP,
      amount        NUMERIC(6,2) NOT NULL,
      disputed      BOOLEAN DEFAULT FALSE
    );

The CREATE TABLE command can be quite long and complex but if you made a mistake you would have to retype the whole command...!!!  So…

Put the command into a text file using your favourite editor then you can run the file from the CLI.

You can run several commands from one file, so you can include any INSERT commands to load initial data.

Once you have created a file containing commands you want to execute, you can do so using the `\include` (or `\i`) psql command, for example:

    \include my-file.sql

You might consider modifying the commands slightly, so that subsequent re-runs don't give errors:

my-file.sql

    DROP TABLE IF EXISTS invoice_items;
    CREATE TABLE invoice_items (
      invoice_id    INTEGER NOT NULL,
      item_no       INTEGER NOT NULL,
      charge_type   VARCHAR(20) NOT NULL,
      charge_time   TIMESTAMP,
      amount        NUMERIC(6,2) NOT NULL,
      disputed      BOOLEAN DEFAULT FALSE
    );
    ...

### Rules for CREATE TABLE
*   Names (tables, columns) should start with a letter and can contain letters, digits and underscore
*   Columns have a datatype that describes the kind of data that can be stored in that column
*   Columns can be declared as NOT NULL, meaning the column must hold a value in every row

---
## Exercise: Create Table

Create the invoice items table using a command script file as described above. Don't add any INSERT commands yet.

---
### Datatypes
Most SQL databases provide for different datatypes, for example:
*   Number (integer, float, decimal…)
*   Text (variable or fixed length)
*   Date/Time
*   Boolean (not always available or done as integer)
*   Others: BLOB (Binary Large OBject), etc...
(also see https://www.postgresql.org/docs/10/datatype.html)

How to declare datatype sizes in postgreSQL:

    NUMERIC(w,d)        w=width, d=decimal places
        e.g. (6, 2) gives digit places ±9999.99
        Note DECIMAL is a synonym for NUMERIC

    VARCHAR(w)        w=max length
    SMALLINT, INTEGER, BIGINT : 16, 32 & 64-bit integers
    REAL, DOUBLE PRECISION : 6 & 15 significant digits

How to enter different data types:

    Numeric:      123    123.456    1.23456E02
    Text:         'Text value here'        'He didn''t say.'
    Date/Time:    '2018-06-14'    '2018-06-14 16:25:13.123'
    Boolean:      TRUE    FALSE    't' 'f' 'true' 'false' '1' '0'

Use the datatype DATE or TIMESTAMP to store date or date-and-time information.

Use the ISO standard 'YYYY-MM-DD' for dates and 'YYYY-MM-DD hh:mm:ss.ddd' for date-and-time.

(see also https://www.postgresql.org/docs/10/datatype-datetime.html)

---
## Exercise: Initial Data
Modify your script file that creates the invoice_items table and add a few rows each for invoices 22, 31 and 44. You can invent the data (e.g. meals, drinks, laundry) but use item numbers starting from 1 for each invoice. For example:

    INSERT INTO invoice_items VALUES
        (22, 1, 'Restaurant', '2018-09-15 20:24', 31.85, FALSE),
        (22, 2, 'Bar', '2018-09-15 22:32:21', 12.87, FALSE),
        (22, 3, 'Laundry', '2018-09-16 07:30', 10.30, FALSE);

Rerun the script then use a query to check that the table contains what you expect.

---
### Adding a New Column to a Table
We need to record customer comments for invoice items:

    ALTER TABLE invoice_items ADD COLUMN comment VARCHAR(240);

Now insert a new row with a comment:

    INSERT INTO invoice_items (invoice_id, item_no,
        item_type, item_time, amount, comment)
      VALUES (16, 1,
        'RESTAURANT', '2018-06-12 19:30', 36.95,
        'Great food!');

---
## Exercise
1.  Insert new rows into invoice items for invoices 19 and 20 for restaurant and bar, some with and some without customer comments.
2.  Query to check the data.

---
## Primary Keys
New table rule:

**We must be able to uniquely identify each row in a table.**

To do this we must have one or more columns whose value(s) match only one row - this is the **primary key (PK)**.

*   Primary keys must be unique inside the table
*   Primary keys cannot have any NULL values

### Choosing Primary Keys
Ideally natural attributes of the ‘thing’ we are representing. These must be easily accessible in the 'real' world.

Discussion…

In practice an artificially generated key can help.
(Problem: generated keys don't store any useful information about the thing represented by the row)

### Defining Primary Keys
We use a constraint to specify the primary key of a table:

    CREATE TABLE rooms (
        room_no      INTEGER NOT NULL,
        -- other columns...,
        PRIMARY KEY (room_no)
    );

In most SQL variants the use of NOT NULL with PRIMARY KEY is redundant, PRIMARY KEY implies NOT NULL. It is OK to specify it if you prefer.

You can also use an alternative in-line syntax when the Primary Key is just one column, as follows:

    CREATE TABLE rooms (
        room_no      INTEGER PRIMARY KEY,
        -- other columns...
    );

### Auto-incrementing Primary Keys
The database can generate the key as an incrementing integer such that only unique values are generated:
1.  Declare a column as SERIAL PRIMARY KEY (usually 1st column)
2.  Omit that column from INSERT commands to generate its value

Note: There may be gaps in the incrementing sequence.

(Other databases have different ways of defining autoincrementing keys)

### Defining an Autoincrementing PK
Create the table with id (or similar name) as 1st column and datatype SERIAL with PRIMARY KEY:

    CREATE TABLE reservations (
      id          SERIAL PRIMARY KEY,
      customer_id INTEGER NOT NULL,
      etc...
    );

Omit the id column from the INSERT:

    INSERT INTO reservations (customer_id, ... )
        VALUES (155, ... );

## Exercise
1.  Look at the customers table definition (hint: \d)
2.  Try to insert a row into the table but supply the PK value, equal to an existing customer id. What happens?
3.  Modify your INSERT so that you don't supply the id column and try again. Is your new customer stored?
4.  Create a table for inventory items with columns id and type (e.g. 'Bed', 'TV', etc.), so that it uses an auto-incrementing id.
5.  Insert inventory items 'Double bed', 'Single bed', 'TV 36in' but don't provide a value for id. e.g.:
    `INSERT INTO inventory (type) VALUES ('Arm Chair');`
6.  Check the data using a query.

---
## Defining Relationships: Foreign Keys
The word “Relational” is significant in Relational Database. All the data in a database is related to other data in some way.

![Foreign Key Diagram](foreign-key.png)

For example, an order must be for one customer. A customer may have zero or more orders.

We define these relationships using Foreign Keys.

A foreign key is one or more columns in the table at the ‘many’ end of a relationship.

The foreign key column(s) must match the primary key of the table at the ‘one’ end of the relationship (usually).

Foreign key definitions are part of the create table command, usually at the end.

    ...
    FOREIGN KEY (cust_id) REFERENCES customers(id)

For example, an updated version of the invoice_items table:

    CREATE TABLE invoice_items (
      invoice_id     INTEGER NOT NULL,
      item_no        INTEGER NOT NULL,
      charge_type    VARCHAR(30) NOT NULL,
      charge_time    TIMESTAMP,
      amount         NUMERIC(6,2) NOT NULL,
      disputed       BOOLEAN DEFAULT FALSE,
      PRIMARY KEY (invoice_id, item_no),
      FOREIGN KEY (invoice_id) REFERENCES invoices(id)
    );

### Foreign Key Enforcement
When you have a foreign key constraint defined:
*   You cannot insert a new row with a non-matching FK
*   You cannot update a FK to a non-matching value
*   You cannot delete a row that is referenced by a FK
*   You cannot drop a table that is referenced by a FK

---
## Exercise
1.  Modify the CREATE TABLE command for your invoice_items table and add a foreign key for invoice_items.invoice_id. Re-run the command script.
2.  Try to insert an invoice item with the same invoice id and item no as an existing row. What happens?
3.  Try to insert an invoice item for invoice number 9999. What happens?
4.  Create a charge types table so that users can't put arbitrary charge types into invoice items. Just one column is needed, charge_type, which is also the PK.
```
    Some suggested charge types:
        RESTAURANT                ROOM SERVICE
        LAUNDRY                   BAR
        ROOM (rate * nights)      etc...
```
5.  Add a foreign key from invoice items to enforce the new requirement.


---
## Designing for Performance
Databases must often handle a large number of actions every second, often accessing tables containing millions of rows, so it's important to ensure adequate performance.

One way to help make queries faster is to provide appropriate indexes that provide a shortcut to the relevant data, rather like an index in a book.

You can define indexes to improve access to particular column values. Such indexes are used when you specify the column value in WHERE clauses, etc.

### How Indexes Work

![Indexes Diagram](indexes.png)

The RDBMS automatically maintains indexes to correspond to changing row contents.
*   If a new row is added then its indexed column value is added to the index.
*   If a row is deleted its indexed value is removed from the index.
*   If an indexed column value is updated then the index is updated accordingly.

You can use the CREATE INDEX command to define an index. For example, it *might* be beneficial to define an index on the name column in the customers table:

    CREATE INDEX cust_name ON customers(name);

This creates an index named `cust_name` on the values of the name column in the customers table.

You can define an index on multiple columns:

    CREATE INDEX res_room_date
      ON reservations (room_no, checkin_date);

You can define a UNIQUE index that prevents duplicate values in one or more columns:

    CREATE UNIQUE INDEX cust_email ON customers(email);

This is equivalent to using a UNIQUE constraint:

      ...  
      email    VARCHAR(120) NOT NULL UNIQUE,
      ...

or you can define the UNIQUE constraint at the end of the table definition:

      UNIQUE (email)

### An Interesting Question...
What is the only guaranteed performance effect of adding an index to a table?

Discuss...

---
