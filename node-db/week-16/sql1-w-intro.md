# Introduction to SQL for Windows

## Let's Get Started
We shall use PostgreSQL - a widely used relational database. It's open-source and free to use.

**Note that you must be logged in as a user with Administrator privileges on Windows for all these steps.**

If you have Windows as your operating system you can install PostgreSQL from the installer executable. Download this from https://www.postgresql.org/download/windows/ but make sure you choose PostgreSQL version 10 and the appropriate platform for your PC (64 or 32-bit). Once you have downloaded the installer then run the file (postgresql-10.6-1-windows-x64.exe or similar). The installer prompts for various information as it initialises and you can mostly take the default values. Make a note of the installation folder when prompted for it - you don't need to change it. You must, however, provide a password for the postgres user - make sure you remember this password!

The default installation provides only one user and no databases. To verify your installation open the Command Prompt and enter the following command:
```
    C:\...> psql -U postgres --version
```
Enter the password for user `postgres` (defined during installation) when prompted. The command should display something like this:

    psql (PostgreSQL) 10.5

---
## Create the Database
PostgreSQL initially uses an authorisation mode that depends on the operating system username; that is why we had to switch to user 'postgres' to verify our installation because the installer only creates this user.

PostgreSQL also assumes that each user that logs in has a database that has the same name as the user - this makes it very easy to log in - you don't need to remember a new password nor specify the database.

To create a database and your new user you'll have to use the postgres user again - but only this once more...
```
    $ createdb -U postgres <your user name>
    $ createuser -U postgres <your user name>
```
You must supply the password for the `postgres` user for each of these commands.

REMEMBER &lt;your user name> is the username you use to log in to Windows.

You need to modify a configuration file to allow passwordless logins from your own PC. For this you need to locate the file `pg_hba.conf` in the installation directory's `data` subdirectory. For example, if the installation directory is:

    C:\Progam Files\PostgreSQL\10

then look for `pg_hba.conf` in `C:\Program Files\PostgreSQL\10\data`.

Open this file using your favourite text editor (Visual Studio should work OK). Scroll down past all the comment lines (starting with `#`) until you find the header line:

    # TYPE  DATABASE        USER            ADDRESS                 METHOD

You should find a number of non-comment lines below this - these define login methods for different situations. Enter the following line just below the header line:

    host    sameuser        all             ::1/128                 trust

Save the changes.

Finally you must restart the PostgreSQL service so that the configuration changes are used. To do this right click in the taskbar at the bottom of the screen and choose Task Manager. Click the Services tab and locate the postgresql service (named `postgresql-x64-10` or similar). Right click and choose Restart.

From here onwards you shouldn't need to switch to the postgres user again, enter a password nor specify a database. You can get into the PostgreSQL command-line tool using just:
```
    $ psql
```
This connects you to the database with your username and connects as the same username as your Windows user.

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

You can continue with the main lesson from **"Run the psql Command Line Interface (CLI)"** now but note that the Linux prompt (where it is shown) is not the same as the Windows prompt that you will see.
---
