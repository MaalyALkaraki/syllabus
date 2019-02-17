# Introduction to SQL for Ubuntu

## Let's Get Started
We shall use PostgreSQL - a widely used relational database. It's open-source and free to use.

If you have Ubuntu as your operating system you can install it using:
```
    $ sudo apt-get install postgresql postgresql-contrib
```

Enter your ubuntu password when asked for it.

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

**REMEMBER** &lt;your user name> is the username you use to log in to Ubuntu.

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

You can continue with the main lesson from **"Run the psql Command Line Interface (CLI)"** now.

---
