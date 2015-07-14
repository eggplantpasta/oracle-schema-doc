-- use if creating package and directory in a separate schema to the one being documented
-- modify as appropriate for your environment

set define off;

-- run as sys
drop user ddd cascade;
create user ddd identified by ddd;
grant connect, resource to ddd;
grant create database link, create procedure to ddd;
grant create any directory to ddd; -- allows user to read and write to the filesystem of the db server
grant select any dictionary to ddd; -- allows user to select from dba_* tables
grant execute on utl_file to ddd;

-- connection to our newly created user to create the package and directory
connect ddd/ddd@localhost;
create or replace directory ddd_files as '/files';

-- compile the vendor packages
@../vendor/types.sql

@../vendor/string_util_pkg.pks
@../vendor/file_util_pkg.pks
@../vendor/json_util_pkg.pks

@../vendor/string_util_pkg.pkb
@../vendor/file_util_pkg.pkb
@../vendor/json_util_pkg.pkb
