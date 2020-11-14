CREATE USER my_app identified by secret;
grant create session to my_app;
grant resource to my_app;
grant unlimited tablespace to my_app;
