# SQL With Node
**Using SQL with Node.js, express and PostgreSQL**

---
## Objectives
* Use Nodejs and Express with SQL
* Create endpoints (routes) to execute queries that return multiple rows
* Create endpoints to execute queries that return one row
* Create endpoints to insert new data into a table
* Create endpoints to delete a row from a table
* Create endpoints to update values in an existing row

---
## Setting Up the Environment
1.  Create a directory for a new node project, say, `hotel-db`.
2.  Use the `npm init` command to initialise the project.
    1. Change the entry point from `index.js` to `server.js`.
    2. Provide a description (optional).
3.  Install required packages:
    1. `npm install express --save`
    2. `npm install body-parser --save`
4.  Create an empty file, `server.js` (hint: use `touch server.js`)
5.  Add the minimum JavaScript required for a basic server:
```
    const express = require("express");
    const app = express();

    // Your code goes here...

    app.listen(3000, function() {
    console.log("Server started on port 3000.");
    });
```
Obviously the comment `// Your code goes here...` is optional.

---
## Preamble
To access your database from Node you should give yourself a password. This is very easy...

From the terminal, log in to your database with `psql` and issue the SQL command:

    ALTER ROLE <your user name> PASSWORD '<password>';

Note: &lt;your user name> is your O/S user; the &lt;password> can be anything you choose. Quit from psql using the \q command.

Install the Nodejs support for postgres (from the terminal in your project directory):

    npm install pg --save

Edit your server.js file so that you can access your database. First add these lines near the top of the file:

    const Pool = require('pg').Pool;

    const db = new Pool({
      user: '<yourUserName>',      // Your O/S user name
      host: 'localhost',
      database: '<yourUserName>',  // ... and again.
      password: '<password>',      // The one you gave yourself above
      port: 5432,
    });

## Starting with SQL in Express
When you've provided the preamble above you can execute SQL using:

    . . .
    db.query('<put SQL here>', function(err, rows) {
      if (err) {
        throw err;
      }
      <process rows here>
    });

## Exercise
Check that you can connect and run SQL from node. Create a file, say, sqltest.js containing something like this (note: this does not use express):

    const Pool = require('pg').Pool;  // initialise a connection pool

    const db = new Pool({          // establish a new connection
      user: '<yourUserName>',      // Your Ubuntu user name
      host: 'localhost',
      database: '<yourUserName>',  // ... and again.
      password: '<password>',      // The one you gave yourself above
      port: 5432,
    });

    db.query('SELECT * FROM customers WHERE id = 32', (err, result) => {
      if (err) {
        throw err;
      }
      console.log(result);
    });

You can run the command from the terminal using:

    node sqltest.js

This should display a complex object that contains a `rows` element with the details for customer 32, as follows:

    Result {
    command: 'SELECT',
    rowCount: 1,
    oid: null,
    rows:
     [ { id: 32,
        name: 'Keith Franco',
        email: 'keith.franco@dlha.net',
        phone: '2035557845',
        address: '149 Spinnaker Dr., Suite 101',
        city: 'New Haven',
        postcode: '97823',
        country: 'USA' } ],
    fields:
    ...

Notice the structure of the `rows` element - it's an array with each element an object representing one row (there is only one row in this case, of course). Think carefully about how you can access each column value returned.

Change your code so that it logs each returned column to a separate line along with its column name. (Hint: use `for (var x in y) {...}`).

---
## Starting with SQL in Express

We need to create the code for the `/customers` endpoint so that it returns all customers; the code in `server.js` would be:

    app.get("/customers", function(req, res) {
      var sql = "SELECT name, email, phone," +
                " address, city FROM customers";
      db.query(sql, function (err, result) {
        result.rows.forEach(function (row) {
          console.log(row.name, row.email, row.phone,
                    row.address, row.city);
        });        // ends forEach...
      });          // ends db.query callback function
    });

Looking at the details of the above, we see:

      var sql = "SELECT name, email, phone," +
                " address, city FROM customers";

This is fairly obvious - it's a variable `sql` that is set to a string value representing an SQL SELECT statement to retrieve details for all customers (there's no WHERE clause).

Then there is:

      db.query(sql, function (err, result) {

This uses the `db` database connection initialised in the preamble to issue the SQL command in `sql` to the database then provides a callback function to process the resulting data.

        result.rows.forEach(function (row) {
          console.log(row.name, row.email, row.phone,
                    row.address, row.city);
        });        // ends forEach...

Is the body of the callback function which iterates over all the elements of the `result.rows` array and sends the name, email, phone, address and city column values to the console.

### Check the Endpoint Works
Start (or restart) the server.js file (in a terminal):

    $ ^C              # this terminates the server if running
    $ node server.js  # restart the server

In the browser, enter the URL for the customers endpoint:

    http://localhost:3000/customers

Back to the terminal - can you see the list of customers logged to the console?

If not you need to correct any mistakes (ask your mentor if you are stuck).

---
## Return Results as JSON
To be useful the endpoint must return the results to the browser. We’re going to use JSON. Edit the endpoint:

    ...
    db.query(sql, function (err, rows) {
      rows.forEach(function (row) {
        console.log(row.name, row.email, ...);
      });
      res.status(200).json({        // Add these lines...
          customers: rows           // here...
      });                           // and here.
    });
    ...

Note: for the moment we'll leave the console log of records in place, in case there's a problem with the new code. It then shows we've run the callback function even if the JSON isn't returned.

Restart the server using `^C` to stop the previous server and then type `node server.js` to restart it with the new code.

In the browser reload the customers endpoint page. The previous time you did this the page was just blank - you should now see the returned JSON structure with details of all customers.

Note: different browsers render the JSON differently - some provide more features than others.

### Use Postman to Check the Response
We can ensure we see a consistent view of the returned JSON by using another tool to manage the Express API. We've previously installed Postman - find it on your system and run it (it's slow to start - be patient). If you see a "Signup" window at first just close it - there is no need to sign up. The initial window (as below, with the Create New tab) can also be closed.

![Postman Initial Window](Postman-init.png)

You can use the main Postman window (below) to initiate requests to and handle responses from web servers. In our case this is the local server we have set up using NodeJS.

![Postman main window](postman-initial.png)

Ensure that the HTTP request method is set to GET (if not then change it using the drop-down list).

Enter the customers endpoint url (http://localhost:3000/customers) in the field that has "Enter request URL" initially.

Click the blue Send button.

You should see the returned JSON in a fairly readable format (under the Pretty tab) as in the following snippet:

    {
        "customers": [
            {
                "id": 1,
                "name": "John Smith",
                "email": "j.smith@johnsmith.org",
                "phone": "0151 123 4567",
                "address": "11 New Road",
                "city": "Liverpool"
            },
            {
                "id": 2,
                "name": "Sue Jones",
                ... etc ...

### Being More Selective
Returning all the customers is fine for a small number of rows, but if we have 200,000 customers it becomes a bit unwieldy.

If we know the id of the customer we can query for just one.

Add code for a new endpoint: /customers/:id

    app.get("/customers/:id", function(req, res) {
      // TODO: add code here
    });

First, get the id from the request:

    var id = req.params.id;

Next, use the id in the SQL query:

    db.query("SELECT ... FROM customers WHERE id = $1", [id],
                function (err, row){
        // we’ll add code here next ...
    });

Note the $1 placeholder in SQL matches the id in the array (2nd param). The value of id will replace the $1 when the SQL is executed. (Note that the placeholders are numbered from 1 - not 0)

If you need to provide more than one value you can use placeholders $2, $3, $4, etc...

Finally, we return the row from the query:

    db.query("SELECT ... FROM customers WHERE id = $1", [id],
        function (err, result){
        res.status(200).json({
            customer: result.rows[0]
        });
    });

Note that we return only the first element (`rows[0]`) of the rows array because we know that `id` matches only one row. If the query could return more than one row then we need to return the whole array (as we did in the case for all customers).

So now the full endpoint looks like this:

    app.get('/customers/:id', function(req, res) {
        var id = parseInt(req.params.id);
        var sql = "SELECT id, name, email, phone," +
                    " address, city FROM customers WHERE id = $1";
        db.query(sql, [id], function (err, result) {
            res.status(200).json({
                customer: result.rows[0]
            });
        });
    });

Use Postman to check the response, the URL for customer id = 3 is: `http://localhost:3000/customers/3`

---
## Exercise
1.  Make sure you have defined the endpoints for:
    1.  Getting all customers
    2.  Getting a single customer by id
2.  Using a method similar to the one used to get a customer by id, define an endpoint that can get customers by matching part of the name (e.g. endpoint /customers-by-name/:name).

> Remember there may be more than one matching row!

3.  Test all these endpoints with Postman and ensure the results are as expected.

---
## Inserting Rows Using Node.js
To insert rows into our tables we use a POST instead of a GET method. We define an endpoint in server.js:

    app.post("/customers/", function (req, res) {
        // add code here to insert row...
    });

We are going to use body-parser to process JSON sent from the browser (or Postman). You probably need to install body-parser and configure it in server.js:

    npm install body-parser --save

You must configure it in server.js using the following code near the top of the file:
```
    var bodyParser = require('body-parser');
    app.use(bodyParser.json());
```
The browser sends the values for the new row as JSON. By using body-parser we can extract them from `req.body` into variables:

    var nam = req.body.name;
    var phn = req.body.phone;
    var eml = req.body.email;
    var add = req.body.address; // ...etc.

(Note: if using the "formidable" middleware, use `req.fields` instead of `req.body`)

Issue an SQL INSERT command with values and use $n placeholders for inserted values, for example:

    db.query("INSERT INTO customers " +
                "(name, email, phone, address) " +
                "VALUES ($1, $2, $3, $4)",
            [nam, eml, phn, add],
        function(err) {
            // callback code goes here
        });

We use the db.query method even though this isn't strictly a query - think of query as any form of SQL for this purpose.

### What Can We Do After an Insert?
*   We should start checking for errors! Not just for inserts!
*   If the table uses an autoincrementing PK we might return the value (that could be useful).
*   We could console.log the inserted data

And so forth...

#### Check for Errors
We should really provide error handling in each endpoint to deal with database errors that could occur anywhere we execute SQL. This should include queries.

The callback function always includes an error parameter as the first parameter. It’s undefined if the command succeeded, or a message if an error occurred.

    db.query(..., function (err) {
        if (err == null) {
            // do stuff for success
        } else {
            res.status(500).json({error: err});
        };
    });

 Calling res.status with parameter 500 signals an error response to the browser, terminates the endpoint action and sends the error message as JSON so the browser can display it or take some other action.

#### Return the Primary Key Value for an Insert
With auto-generated primary keys it might be helpful for the browser to be given the value of the new key after an insert.  In postgres the simplest way to do this is by modifying the INSERT statement, as follows:

    INSERT INTO table (cola, colb, colc, ...)
        VALUES (expr1, expr2, expr3, ...)
        RETURNING id;

The RETURNING clause is not standard SQL but is very useful in this context in PostgreSQL as it allows the insert to also perform a very efficient query after successfully inserting the new row. You can try this in psql.

In the case of SQL executed through Node and Javascript we need to add the RETURNING clause to the INSERT statement then pick up the value from the result of the query. That looks something like this:

    db.query("INSERT INTO customers " +
                "   (name, email, phone, address) " +
                " VALUES ($1, $2, $3, $4)" +
                " RETURNING id",
            [nam, eml, phn, add],
        function(err, result) {
          if (err == null) {
            var newId = result.rows[0].id;
            ...
          }
        })

### INSERT - Putting it All Together

    app.post("/customers/", function (req.res) {
        var nam = req.body.name;
        var eml = req.body.email;
        var phn = req.body.phone;
        var add = req.body.address;
        // etc...
        db.query("INSERT INTO customers (name, email, phone, address)" +
                   "  VALUES ($1, $2, $3, $4)" +
                   "  RETURNING id",
              [nam, phn, eml, add],
          function(err, result) {
            if (err == null) {
                var newId = result.rows[0].id;  //get the PK
                console.log("New customer id = ${newId}");
                res.status(200).json({lastId: newId});  // return the PK
            } else {
                res.status(500).json({error: err});
            };
        });
    });

To test the Insert command from Postman:
1. Change the method to POST
2. Change the 'Params' just below the method to Body
3. On the line below select 'raw'
4. Select JSON(application/json) instead of Text (dropdown list)
5. Type in the JSON for the new customer in the input area. This should look like:
```
    {
        "name": "Fred Bloggs",
        "email": "fred.bloggs@wxyz.net",
        "phone": "+44 7890 123456",
        "address": "123 High Street"
    }
```
6. Click Send then check the Params tab for the new id

Note: this would normally be done in React by JS code to send via Ajax after completing the form with new details.

---
### Exercise
Using the same approach we used for customers, you can write an endpoint to insert new reservations to the database. Remember that a reservation reserves a room for a customer for a specified date or date range and for a number of guests.
1.  Add error checking to all your endpoints.
2.  Create the endpoint using the POST method for endpoint /reservations.
3.  Ensure that you provide all the needed values in the form data.
4.  Use Postman to check that your endpoint inserts the new reservation and returns the new id value.

---
## Deleting Rows
To delete rows we must provide some way to identify the row (or rows) that we wish to delete. We have already queried customers based on id - we could use a similar technique to delete rows using id.

Create an endpoint for customers using the DELETE method and passing a parameter for the id of the customer to be deleted, as below:

    app.delete("/customers/:id", function(req, res) {
      // TODO add code here
      });

---
### Exercise
Using what you already know of SQL and NodeJS/express you should be able to complete that endpoint with the relevant steps to delete a customer when given the id of that customer.
1.  Remember to provide a WHERE clause to govern the rows deleted.
2.  Ensure you include error checking code in your endpoint.
3.  You don't need to return anything to the browser except status (or error message if an error occurs).

---
## Transactions
By default, PostgreSQL runs each INSERT, UPDATE or DELETE in its own transaction - it either succeeds or fails. But the ACID rules require us to be able to make several changes that either all succeed or all fail. To do this we use a transaction.

For example, in banking, a money transfer between accounts must debit the ‘from’ account and credit the ‘to’ account as a single operation - but this needs two update commands. So...

Start a transaction using the command:

    BEGIN TRANSACTION;

… then issue INSERT, UPDATE and/or DELETE commands

End the transaction with either:

    COMMIT;        -- make changes permanent

or:

    ROLLBACK;    -- undo changes since last BEGIN

---
### Exercise - Using Transactions
1.  In the psql command line tool, issue the commands:
```
    BEGIN TRANSACTION;
    UPDATE reservations SET room_no = 310 WHERE id = 10;
```
Now open a new terminal session (leaving the first still open) and in psql do:
```
SELECT * FROM reservations WHERE id = 10;
```
What do you notice about room_no? Leave this session open as well.

2.  Go back to the first terminal session (which should still be open in psql). Issue the following command:
```
COMMIT;
```
then return to the second terminal session and requery reservation 10. What has changed?

3.  Repeat step 1 of this exercise (use the same two terminal sessions if you wish).

4.  In the second terminal session issue the command:
```
UPDATE reservations SET room_no = 304 WHERE id = 10;
```
What happens?

5.  Leaving the second terminal open, go back to the first session and issue the command:
```
ROLLBACK;
```
Now check what has happened in the second session. Why do you think that happened? Requery reservation id 10 and check the room number.

---
### ACID Rules
ACID is a mnemonic for:

* Atomic - all related changes succeed or all fail
* Consistent - committed changes leave the database
consistent (all rules obeyed)
* Isolation - users always see a consistent image, can’t see
incomplete changes
* Durable - committed changes are permanent (even after
power failure)

---
### Implementing Transactions in Nodejs/express
This is rather more complicated than when using psql. A transaction must always be started and completed inside the same database connection. So far we've cheated a bit and used a shortcut that only accepts a single SQL command - the `db.query(...)` call.

To use a transaction we must use a different mechanism because we need to issue at least three commands (BEGIN TRANSACTION, SQL to change data, COMMIT or ROLLBACK).

For example, if we need to change the room number for a reservation in a transaction then, in `psql`, we use the SQL:

    BEGIN TRANSACTION;
    UPDATE reservations SET room_no = 213 WHERE id = 34;
    COMMIT;

In a corresponding endpoint we must create a new connection that can process more than one SQL command:

    db.connect(function (err, client, release) => {
      if (err) {
        // handle error when establishing connection
      }
      // execute multiple SQL commands here
    });

The multiple SQL commands are, of course, asynchronous, so we need to nest the SQL queries inside the callback functions, one per SQL command. We also need to change the function call to execute SQL inside the db.connect call, as follows:

    db.connect(function (err, client, release) => {
      if (err) {
        // handle error when establishing connection
      }
      // execute multiple SQL commands here
      client.query("BEGIN TRANSACTION", function(err) {
        if (err == null) {
          console.log("Done BEGIN TRANSACTION");
          // etc...
    });

Subsequent SQL commands must be done inside the previous SQL command's callback so that we can guarantee the sequence of operations. So, if the next SQL command is an UPDATE, it would appear as follows:

    db.connect(function (err, client, release) => {
      if (err) {
        // handle error when establishing connection
      }
      // execute multiple SQL commands here
      client.query("BEGIN TRANSACTION", function(err) {
        if (err == null) {
          console.log("Done BEGIN TRANSACTION");
          client.query("UPDATE customers SET email = $2 WHERE id = $1",
                function(err) {
            if (err == null) {
              // etc...
            }
          }
    });

And so on...

### Locking

Whenever you make a change to a row or rows the RDBMS locks the affected rows (some lock entire tables, others lock the whole database!) These locks prevent another user making conflicting changes at the same time.

You can take out locks explicitly in SQL, especially row locks when you execute a `SELECT` command. The syntax for this new feature is quite simple:

    SELECT ...
      FROM ...
      WHERE ...
      FOR UPDATE;

You just add the `FOR UPDATE` clause to the end of the`SELECT` and each of the rows returned is locked. Make sure that:
1. You don't lock very large numbers of rows at a time
2. The rows belong to just one table

Locks should be held for the shortest possible length of time to avoid causing other users delays.

### Optimistic Locking

Let's look at a multi-user scenario:

| User 1 | User 2 |
| --- | --- |
| Query row x | |
| User looks at row x | Query row x |
| Change row x on screen | User looks at row x |
| time passes... | User changes row x on screen |
| User hits Submit | time passes... |
| DB changes row x | time passes... |
| | User hits Submit |

**Now what happens ?!?!** Not necessarily what we want...

What could we do about this? How about locking the row when the user makes the initial query? User 2 must wait and can't work (bad) until User 1 completes their changes and when User 2 eventually gets the row it includes the changes made by User 1 (good). Unfortunately this won't work in NodeJS because when the user hits Submit they start a completely new session.  All previously obtained locks have been lost.

We need another way.

One approach could have the application (browser) sending both the original row and the changed row when the user hits Submit. The browser must keep a copy of the original row but allow the user to make changes to a second copy.

The server then performs a more complex transaction to perform the update. First initiate a transaction (if necessary) with `BEGIN TRANSACTION`. Next re-query the row and lock it at the same time (`SELECT ... FOR UPDATE`) before comparing the row with the original row sent by the browser. If the row and original copy are the same then no other user has changed it and we can then issue an `UPDATE` to apply the changes and finally `COMMIT` to make the changes permanent.

For example, code to update customer's email address:

```
//
// Function to compare two objects for equality of properties
//
function objEqual (a, b) {
  for (var item in a) {
    if (a[item] != b[item]) {
        return false
    }
  };
return true
}

app.put('/customers/email/:id', function(req, res) {
    // EXPECTED JSON Object:
    //  { original: {
    //      email: 'fred@bloggs.org',
    //    },
    //    update: {
    //      email: 'fred.bloggs@bloggs.com'
    //    }
    //  }
    var uemail = req.body.update.email;

    var custId = parseInt(req.params.id);

    var sql1 = "SELECT email " +
          "FROM customers " +
          "WHERE id = $1 " +
          "FOR UPDATE";
    var sql2 = "UPDATE customers " +
          "SET email = $2 " +
          "WHERE id = $1";

    db.connect((err, client, release) => {
      if (err) {
        console.error('Error acquiring client', err.stack);
        res.status(500).json({error: err});
        return;
      }

      const checkErr = function(err, reason) {
        if (err) {
          console.log("Error: ${reason} - ${err}");
          client.query("ROLLBACK", function(err) {
            console.log("ERROR in ROLLBACK - ${err}");
          });
          release();
          res.status(500).json({error: err});
        }
        return !!err;
      }

      client.query("BEGIN TRANSACTION", function(err) {
        if (err == null) {
          console.log("Done BEGIN TRANSACTION");
          client.query(sql1, [custId], function(err, result) {
            if (err == null) {
              console.log("Done SELECT ... FOR UPDATE");
              if (objEqual(result.rows[0], req.body.original)) {
                console.log("Done - record matches");
                client.query(sql2,
                  [custId, uemail],
                  function(err) {
                    if (err == null) {
                      console.log("Done UPDATE...");
                      client.query("COMMIT", function(err) {
                        if (err == null) {
                          console.log("Done COMMIT");
                          release();
                          res.status(200).json({done: "Update completed."});
                          return;
                        } else {
                          console.log("ERROR in COMMIT: ${err}");
                          client.query("ROLLBACK");
                          release();
                          return res.status(500).json({error: err});
                        }
                      })
                    } else {
                      checkErr(err, "UPDATE");
                      return;
                    }
                  })
              } else {
                console.log("Row modified by another user - try again");
                release();
                res.status(400).json({error: "Row modified by another user - try again"});
                return;
              }
            } else {
              checkErr(err, "SELECT FOR UPDATE");
              return;
            }
          })
        } else {
          checkErr(err, "BEGIN TRANSACTION");
          return;
        }
      });
    });
  });
```

As you can see the above is much more complex than the simple calls to `db.query()` in our previous endpoint code. Note the extra functions, `objEqual` and `checkErr` that are used to simplify the main part of the code.

---
### Using async/await for Transactions
By using the Javascript async and await constructs you can avoid the difficulty of deep nesting of callback functions (also known as "Callback Hell"). Such problems happen when you need to issue many SQL commands in sequence because each must be done in the callback function of its predecessor to ensure correct ordering.

We also use the `try ... catch ...` syntax to execute the await functions thus also reducing the complexity of error checking because await will throw an exception if an error occurs.

Below you can find the complete code for an endpoint to update a customer's phone number:

```
//
// Endpoint to update customer phone number using async/await
//
app.put('/customers/phone/:id', (req, res) => {
    // EXPECTED JSON Object:
    //  { original: {
    //      phone: '01234 567 890',
    //    },
    //    update: {
    //      phone: '0161 123 4567'
    //    }
    //  }
  var custId = parseInt(req.params.id);

  var phoneNos = req.body.update;

  const sql1 = "SELECT phone FROM customers WHERE id = $1 FOR UPDATE";

  const sql2 = "UPDATE customers SET phone = $2 WHERE id = $1";

  let result;

  (async function() {     // look up Immediately Invoked Function Expression (IIFE)
    let client;
    try {
      client = await db.connect();
      await client.query("BEGIN TRANSACTION");
      result = await client.query(sql1, [custId]);
      if (objEqual(result.rows[0], req.body.original)) {
        await client.query(sql2, [custId, phoneNos.phone]);
        await client.query("COMMIT");
      } else {
        await client.query("ROLLBACK");
        client.release();
        res.status(400).json({error: "Row modified by another user - try again"});
        return;
      }
      client.release();
      res.status(200).send("Update completed successfully");
      return;
    } catch(err) {
      if (client != null) {
        client.query("ROLLBACK");
        client.release();
      }
      console.log("ERROR: " + err);
      res.status(500).send("ERROR: " + err)
      return;  
    }
  })();
});
```

This endpoint uses the same `objEqual` function to compare the row object returned by `SELECT ... FOR UPDATE` as the original approach. Compare this with the more traditional code that uses callbacks to sequence the SQL commands.

---
### Using a Row Version Column
Rather than comparing the whole row another approach adds a column to the table, say, `row_version`, that is incremented each time the row is updated. The browser only needs to send back the original row's version rather than the whole row. If another user has changed the row then the version number will have been updated and the browser's copy will be different. This useful in the case where an update may change a large number of column values but does require a new column that doesn't hold any useful business data.

---
### Exercise
Change all your endpoints that change the rows in the database (that is, use UPDATE or DELETE) such that each of the changes take place in the context of a transaction. Use optimistic locking to ensure multi-user consistency.

You can choose whether to use callbacks or async/await.

You can also choose whether to add a row_version column or compare the whole row.  To add a row_version olumn to a table use the SQL:
```
    ALTER TABLE table_name ADD COLUMN row_version;
```

If you choose to use a row_version column remember you must also ensure that its value is always updated whenever a row is updated.

---
## Homework
1.  If you haven't yet completed all the exercises from this lesson then please do that first.
2.  Create an endpoint that allows for changes to the customer details. This uses the PUT html method and the UPDATE statement in SQL.
  1. Consider how you'll identify the row to be updated.
  2. Consider how to pass in the values to be changed.
  Hint: see the single record query and the insert new record cases
3. Create other endpoints for the reservations table (e.g. query all reservations for a customer, query reservations for a room, delete a reservation, etc…)
4. We haven't covered everything you need in SQL - take time to study the w3schools lessons on SQL:
  1.  Left Join, Right Join, Full Join
  2.  Data Definition Language (DDL) to create, alter and drop tables
  3.  Indexes to improve (or disrupt?) performance
5. Look at other sources discussing the topics we have already covered to get a broader view.

Ask your mentor if you need to know more...
