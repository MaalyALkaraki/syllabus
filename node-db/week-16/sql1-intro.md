# Introduction to SQL
### Using Databases for Simple Queries
---
## Objectives
* Understand the use of databases and the structure of relational databases
* Install PostgreSQL on Ubuntu (if not yet done)
* Use basic single table query commands in SQL
* Choose which values are returned by a query
* Restrict the rows returned by a query
---
## What is a Database?

"A structured set of data held in a computer, especially one that is accessible in various ways.” (OED)

Key words/phrases are:
* Structured
* Data
* Accessible in Various Ways
---
## Why Use Databases?

Why not just a plain file?
* Databases define the structure of the data and the relationships between entities
* Databases provide data checking
* Can eliminate redundancy and duplication
* Can be used to answer varied questions
---
## What Kind of Database?
* There are many kinds of database but the most frequently used is the Relational kind
* Other kinds include Key/Value, Graph, Document (all often generically called NoSQL databases)
* We’re going to look at Relational Database, the most widely used and supported by standards
---
## What is SQL?
* SQL (Structured Query Language) is used to access relational and other databases
    * Pronounced S-Q-L or Sequel (many people use both)
* Provides for query, update, insert and delete
* Can create and alter the data structure
* SQL is non-procedural (no loops, no if-then-else…)
* You specify what you want and the RDBMS works out how to achieve it
---
## What's an RDBMS?
* RDBMS (Relational Database Management System) is a layer of software between the application and the file system.
* It processes requests in SQL from application code and returns query results and status.
* Stores data in tables of rows and columns
---
## Tables, Columns, Rows
![Table diagram](table-diagram.png)
---
## Why Not Combine the Data?
![Combined table diagram](combined-diagram.png)
* What happened to Thomas Jones?
* What do we need to do if Sally changes her phone number?
## ***DON'T DO THIS!***

---
## Let's Get Started
We shall use PostgreSQL - a widely used relational database. It's open-source and free to use.

If you have Ubuntu as your operating system you can install it using:
```
    $ sudo apt-get install postgresql postgresql-contrib
```

For this command you must confirm that you are happy to install the packages and any needed dependencies that the package manager identifies. Generally just type `Y` or `y` to proceed.

The default installation provides only one user and no databases. To verify your installation enter the following commands:
```
    $ sudo -u postgres psql --version
```
Enter your Ubuntu user password when prompted - this is required by the sudo part of the command. The command should display something like this:

    psql (PostgreSQL) 10.5 (Ubuntu 10.5-0ubuntu0.18.04)

---
## Create the Database
PostgreSQL initially uses an authorisation mode that depends on the operating system username; that is why we had to use sudo and switch to user 'postgres' to verify our installation.
PostgreSQL also assumes that each user that logs in has a database that has the same name as the user - this makes it very easy to log in - you don't need to remember a new password nor specify the database.
To create a database and your new user you'll have to use the postgres user again - but only this once more...
```
    $ sudo -u postgres createdb <your user name>
    $ sudo -u postgres createuser <your user name>
```

REMEMBER \<your user name\> is the username you use to log in to Ubuntu.

From here onwards you shouldn't need to switch to the postgres user again. You can get into the PostgreSQL command-line tool using just:
```
    $ psql
```
The output from this command should look something like this:
```
    psql (10.5 (Ubuntu 10.5-0ubuntu0.18.04))
    Type "help" for help.

    <your user name>=# 
```
The last line (`<your user name>=#`) is the `psql` command prompt, made up of your user name plus '=#'. Clearly the actual prompt will have your user name, so if the username is `keith` then the prompt will be:
```
    keith=#
```
Note that to exit psql back to the terminal prompt use the command `\q`.

---
## Run the psql Command Line Interface (CLI)
Open a terminal on your laptop (we'll assume the username is `cyf` for the purpose of demonstration):
```
    cyf@cyfvm:~$ psql
    psql (10.5 (Ubuntu 10.5-0ubuntu0.18.04))
    Type "help" for help.
```
The help command is the entry point into the local copy of online documentation. It gives you a number of further options and some basic help. Here is the output from the `help` command:
```
    cyf=# help
      You are using psql, the command-line interface to PostgreSQL.
      Type:  \copyright for distribution terms
             \h for help with SQL commands
             \? for help with psql commands
             \g or terminate with semicolon to execute query
             \q to quit
    cyf=# \q
    cyf@cyfvm:~$
```

---
## Populate the Hotel Database
Load the initial data (so that you can start practising) from the supplied scripts. You will need the following SQL script files:
* build-hotel.sql
* custo9mers.sql
* fixup-dates.sql
* invoices.sql
* reservations.sql
* rooms.sql
* room-types.sql

These can be downloaded from [SQL scripts](https://github.com/KeithBremer/syllabus/node-db/sql), moved to your own directory then run using:
```
    $ cd path/to/scripts
    $ psql
    ...
    cyf=# \include build-hotel.sql
    ...
```

Note: Replace `path/to/scripts` with your specific path to the script files.

You can list all the available tables using the `\d` command:
```
    cyf=# \d
                    List of relations
    Schema |        Name         |   Type   | Owner 
    --------+---------------------+----------+-------
    public | customers           | table    | keith
    public | customers_id_seq    | sequence | keith
    public | invoices            | table    | keith
    public | invoices_id_seq     | sequence | keith
    public | reservations        | table    | keith
    public | reservations_id_seq | sequence | keith
    public | room_types          | table    | keith
    public | rooms               | table    | keith
    (8 rows)
```
Note that psql prints the list of more than just tables in the database - this list also includes sequences (as above) and views (we don't have any of those). We'll explain those later in the course.

---
## The SELECT Statement
To get data out of a table you use the SELECT statement (or command):

    SELECT ... FROM ...;

For example:

    SELECT name, phone, country FROM customers;

SQL commands entered in the psql command line tool are terminated with a semicolon (;). The SQL command can extend across sevaral lines, but each keyword, name or value must be on just one line. For example:
```
    SELECT name,
           phone,
           country
      FROM
        customers;
```
is the same as the previous example.

You can use `SELECT * FROM ...` to return all the columns of the table. For example:
```
    SELECT * FROM rooms;
```
This is useful for development and testing when you may not be sure of all the column names. Don't use this syntax in production applications without having a very good reason. 

Note that the use of UPPER/lower case is only to emphasise and differentiate the SQL keywords from the other names (e.g. columns and tables). SQL keywords are not case-sensitive.

Also note that some SQL implementations (including postgreSQL) allow you to omit the FROM clause, as in:

    SELECT 'The area of a 5m diam circle is : ', 3.14159 * 2.5 * 2.5;

---
## Changing the Order and Appearance of Columns
You can return columns in any order:

    SELECT country, name, phone FROM customers;

Display rows vertically:

    SELECT country, name, phone FROM customers\G

Note the use of `\G` instead of `;` at the end of the last command.

---
## Exercise
1. List the name, phone and email of all customers
2. List all the details of rooms
3. List all room types in vertical format

---
## Some Useful `psql` Commands
Display a list of available tables in the database:

    \d

Display the definition of a table:

    \d <table name>

Display a summary of the psql (backslash) commands:

    \?

Exit (quit) from psql:

    \q

---
## Displaying More Than Just Columns
You can use expressions in SQL:

    SELECT room_no, rate * 0.85 FROM rooms;
    +---------+-------------+
    | room_no | rate * 0.85 |
    +---------+-------------+
    |     101 |     72.2500 |
    |     102 |     72.2500 |
    |     103 |     72.2500 |
    ...

Use a column alias give the expression a meaningful name:

    SELECT room_no,
           rate * 0.85 AS discounted_rate
        FROM rooms;
    +---------+-----------------+
    | room_no | discounted_rate |
    +---------+-----------------+
    |     101 |         72.2500 |
    |     102 |         72.2500 |
    |     103 |         72.2500 |

Here, the query uses the alias as the column heading. Aliases can also be used in other contexts - more on this later...

---
## Expressions in SQL
As with Javascript you can use a variety of 'operators' to define expressions in SQL.

Arithmetic:
* \*    Multiply
* \/    Divide
* \+    Add
* \-    Subtract
* \%    Modulo (remainder)
* (...) Parenteses (to override precedence)

String:
* ||    Concatenate

Functions:  These are not part of the SQL standard and so each vendor has their own set of functions. Refer to the vendor's documentation (for MySQL see [MySQL_docs](https://dev.mysql.com/doc/refman/5.7/en/))

---
## Using SQL Functions
You can use the built-in functions of SQL just as you can in JavaScript, but note that they are different (this is true of most programming languages) but there are also differences between SQL implementations.

You use functions change values, usually of columns, wherever you can use a column, for example, in the selected list of values:

    SELECT name, length(name) namelen, upper(email)
      FROM customers;

This query also uses a column alias (namelen) to provide a meaningful column heading.

Functions are available that operate on all different datatypes.

Country names are mixed case so to make sure we always match regardless of the stored case we can use the `lower` function to find all customers from Manchester, UK:

    SELECT * FROM customers
       WHERE lower(country) = 'uk'
         AND city = 'Manchester';

List room rates after VAT increases to 23.5% (from 20%), but round to the nearest pound:

    SELECT room_no, room_type, rate AS old_rate,
           round(rate * 5/6 * 123.5/100) AS new_rate
       FROM rooms;

---
## Date and Time in SQL
In SQL dates and times are held in an internal format but are represented externally (when entering values and displaying them) as strings;
*   Text date format:   'YYYY-MM-DD'    e.g. '2018-07-21' = 21 July 2018
*   Time format:        'HH:mm:SS.ddd'  e.g. '14:32'
*   Date/Time format:   'YYYY-MM-DD HH:mm:SS.ddd'   e.g. '2018-07-21 15:26:04'

You can perform arithmetic on dates and times, for example:

    SELECT cust_id, room_no, checkin_date,
           checkout_date - checkin_date AS nights
       FROM reservations
       WHERE checkout_date = current_date + 1;

This query performs subtraction of one date from another (checkout_date - checkin_date) to calculate the number of nights the customer has stayed. It also performs addition (current_date + 1) to get tomorrow's date so that it lists all reservations that will be checking out tomorrow.

Note: current_date is a postgres function that returns the current date.

Also note that there are many ways to get the same result - you may explore those for yourself.

You can also represent time intervals but the representations can be complicated and we shall not cover them here.

---
## Exercise
1.  Write a query to check that all booking dates are before their checkin dates
2.  We plan to offer a discount of 10% on all Premier and Premier Plus rooms next month. How much would we gain on each room if occupancy rose by 5 nights over the month.
3.  List all reservations for Aug 2018 and the number of nights booked.

---
## Eliminating Duplicates
"Which nationalities visit our hotel?":

    SELECT country FROM customers;

But how many values do you see returned for each country? If two customers come from a particular country that country will appear twice in the output. If more than two come from the same country then... But we only need to know the different countries.

To see each country only once, use the keyword DISTINCT, as follows:

    SELECT DISTINCT country FROM customers;

The keyword DISTINCT must appear immediately after the keyword SELECT. If more than one column is selected then DISTINCT applies to the combined values of those columns.

---
## Ordering the Returned Rows
If you want to see the data in a specific order, e.g. "List all customers alphabetically by name within each country":

    SELECT id, name, phone, email, country
        FROM customers
        ORDER BY country, name;

You can can add ASC (ascending, the default) or DESC (descending) after each column name in the ORDER BY clause to control the direction of sorting.

For example:

    SELECT id, name, country, city
        FROM customers
        ORDER BY country DESC, city;

This will sort the data into descending alphabetic order of country then ascending order of city name within each country. The output will look something like this:
```
 id  |          name           |   country    |       city        
-----+-------------------------+--------------+-------------------
  28 | Kelvin Leong            | USA          | Allentown
  96 | Juri Yoshido            | USA          | Boston
 132 | Valarie Franco          | USA          | Boston
 100 | Allen Nelson            | USA          | Brickhaven
  46 | Miguel Barajas          | USA          | Brickhaven
  43 | Leslie Taylor           | USA          | Brickhaven
  37 | Julie King              | USA          | Bridgewater
 130 | Sue Taylor              | USA          | Brisbane
 124 | Steve Thompson          | USA          | Burbank
  29 | Juri Hashimoto          | USA          | Burlingame
  36 | Jerry Tseng             | USA          | Cambridge
  70 | Marta Hernandez         | USA          | Cambridge
 112 | Dan Lewis               | USA          | Glendale
  52 | Mary Young              | USA          | Glendale
  13 | Jean King               | USA          | Las Vegas
  89 | Brian Chandler          | USA          | Los Angeles
  97 | Dorothy Young           | USA          | Nashua
  83 | William Brown           | USA          | Newark
 120 | Violeta Benitez         | USA          | New Bedford
  79 | Wing Huang              | USA          | New Bedford
 116 | Leslie Murphy           | USA          | New Haven
```

Note: you can order by columns that are not returned by the query.

---
## Limiting the Number of Rows
You can reduce the number of rows returned by using the LIMIT clause at the end of the query:

    SELECT id, name, phone, email, country
      FROM customers
      ORDER BY country, name
      LIMIT 20;

The LIMIT clause is not normally used without the ORDER BY clause - without the ORDER BY clause rows can be returned in any arbitrary sequence.

Not all SQL implementations of SQL support LIMIT, some use TOP while Oracle uses ROWNUM.

---
## Exercise

1.  List the different room types and rates for all rooms avoiding duplicates.
2.  List customers' names addresses and phone numbers in alphabetic order of names.
3.  List customers' names, addresses, city and country in ascending order of country then reverse order of city within country.
4.  List the room number, type and the cost of staying 5 nights in each of the top 15 most expensive rooms.

---
## Choosing the Rows
You can choose which rows to display by specifying some condition that must be matched:

    SELECT id, name, phone, email, country
      FROM customers
      WHERE country = 'France';

     id  |        name        |      phone       |            email            | country 
    -----+--------------------+------------------+-----------------------------+---------
     9   | Laurence Lebihan   | 91.24.4555       | laurence.lebihan@xmzx.net   | France
     12  | Carine Schmitt     | 40.32.2555       | carine.schmitt@dftu.net     | France
     15  | Janine Labrune     | 40.67.8555       | janine.labrune@dlsh.net     | France
     25  | Mary Saveley       | 78.32.5555       | mary.saveley@yppl.net       | France
     34  | Martine Rancé      | 20.16.1555       | martine.rancé@xeqs.net      | France
     35  | Marie Bertrand     | (1) 42.34.2555   | marie.bertrand@glut.net     | France
     49  | Frédérique Citeaux | 88.60.1555       | frédérique.citeaux@vekn.net | France
     59  | Annette Roulet     | 61.77.6555       | annette.roulet@lgha.net     | France
     62  | Daniel Da Silva    | +33 1 46 62 7555 | daniel.da.silva@hijy.net    | France
     63  | Daniel Tonini      | 30.59.8555       | daniel.tonini@mxvw.net      | France
     91  | Laurence Lebihan   | 91.24.4555       | laurence.lebihan@xmzx.net   | France
     92  | Paul Henriot       | 26.47.1555       | paul.henriot@uwua.net       | France
     106 | Dominique Perrier  | (1) 47.55.6555   | dominique.perrier@bdim.net  | France
    (13 rows)

You can use comparison operators =, <, >, <=, >=, != (or <>)

Note: use only one = (equals) symbol to test for equality

When comparing numbers no punctuation is needed around the value, for example, `WHERE rate > 100`.

When comparing character data or dates you must enclose the values in single quotes (apostrophes), for example, `WHERE name = 'Mary Saveley'`.

Only the rows that match the comparison test (called a predicate) are returned by the query. The predicate can use columns not returned by the query,

---
## Combining Tests in a Predicate
Use AND and OR to combine tests:

    SELECT * FROM reservations
       WHERE room_no >= 200
         AND room_no < 300
         AND checkin_date >= '2018-01-01';

This lists reservations for rooms on the second floor since the start of 2018. Note the format of the date value - this conforms to the ISO 8601 standard and should be used in preference to any other format to avoid ambiguity.

Another example - to find cheap or Premier rooms on floors 1 and 2 - we might try this to start with:

    SELECT * FROM rooms
       WHERE room_type = 'PREMIER'
          OR rate < 100.00
         AND room_no < 300;

This isn't quite right - it returns rooms on the 3rd and 4th floors. Why?

---
## Overriding Evaluation Order
Just like any programming language, SQL has an evaluation order (precedence). For example, multiply and divide take precedence over add and subtract, so that:

    SELECT rate + 20 * 0.85 ...

is not the same as:

    SELECT (rate + 20) * 0.85 ...

We can override the normal precedence by using parentheses `(...)` around parts of the expression, just as in JavaScript.

With compound predicates AND takes precedence over OR, so that to make the query give the intended results we need to use:

    SELECT * FROM rooms
       WHERE (room_type = 'PREMIER'
          OR rate < 100.00)
         AND room_no < 300;

---
## More Predicate Types
The BETWEEN operator has the form `a BETWEEN b AND c` : checks that a is in the range b - c inclusive. For example:

    SELECT ... WHERE price BETWEEN 100 AND 250 ...

Note that the AND in this case is not combining multiple predicates, it's part of the BETWEEN operator.

The IN operator, `a IN (b, c, d, ...)` checks if the value of a is equal to any of b, c, d, etc... For example:

    SELECT ... WHERE room_no IN (201, 202, 204, 206) ...

Both the BETWEEN and the IN operators can be inverted using:

    ... a NOT BETWEEN b AND c ...

    a NOT IN (b, c, d, ...)

The LIKE operator tests for a match against a wildcard string as `a LIKE b` where a is being tested and b is the wildcard string. The wildcard string contains text to be matched along with wildcard symbols '%' and '_'.
* `%` (percent)     matches any number of any characters
* `_` (underscore)  matches exactly one of any character

For example:

`name LIKE 'A%'`    matches names starting with 'A'

`name LIKE '_a%'`   matches names that have 'a' as the 2nd character

`name LIKE '%ow%'`  matches names containing the sequence 'ow'

LIKE can be inverted using `a NOT LIKE b`

If you need to match for a string that includes one of the wildard characters (% or _) you can use the 'escape' character, which defaults to '\' (backslash). For example:

`str LIKE '% discount = 5\% %'`    matches any value in str that contains ' discount = 5% '

LIKE is case sensitive in many SQL implementations so to make a case insensitive match you should either convert the tested value to either all upper or all lower case, for example:

`lower(name) LIKE '%b%'`    matches any name that contains the letter B or b

Note: PostgreSQL also has the non-standard operator ILIKE that can perform a case-insensitive comparison - but avoid this to make code more portable.

---
## Exercise
1.  Which customers are from Norway?
2.  Which rooms can accommodate more than two people?
3.  Which invoices are dated after 5th July 2018?
4.  How would July invoices change if we gave a discount of 15%
5.  List all customers whose second name starts with 'M' (hint: there's a space before the second name)

---
## Summary
In this lesson you have learned the use of databases and how relational databases are structured. You've also learned how to use basic single-table query commands in SQL and some of the special 'backslash' commands in `psql`. You have used the SELECT command to control the columns and values that are returned, the DISTINCT, ORDER BY and LIMIT clauses to control the order and numbers of rows returned and you've used the WHERE clause to choose the rows that you access.

You can now go on to more complex query constructs including joins and subqueries.

---
## Homework
1.  If you haven't completed all the exercises from this lesson then do that first.
2.  In your browser go to https://www.w3schools.com/sql/default.asp and try the SQL tutorial.
3.  Recap material that we have already covered but some topics will be new. Try to make sure you recap all we have done so far.
4.  Look at Insert, Update and Delete, Null values, Min and Max, Count, Avg, Sum, Joins and Inner Join. If you have time please do look at other sections of the tutorial as well.

After you have completed the w3schools tutorial parts mentioned above, use your knowledge to insert some new data into the room_types and rooms tables, as follows:
1.  Make a new room type of PENTHOUSE with a default rate of £185.00
2.  Add new rooms, 501 and 502 as room type PENTHOUSE and set the room rate of each to the default value (as in the new room type).
3.  Add a new room 503 as a PREMIER PLUS type similar to the other PREMIER PLUS rooms in the hotel.
4.  Update the rate for room 503 to 143.00 to reflect its improved views over the city.
5.  Find the grand total revenue from all invoices and the average invoice total.
6.  How many invoices have not yet been paid and what is the total owed?
7.  Find the customer id, checkin and checkout dates for all unpaid invoices.

