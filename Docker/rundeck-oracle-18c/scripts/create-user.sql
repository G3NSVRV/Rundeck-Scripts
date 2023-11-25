alter session set "_ORACLE_SCRIPT"=true;
create tablespace rundeck datafile 'rundeck.dat' size 10M autoextend on;
create user rundeckuser identified by rundeckpassword default tablespace rundeck;
grant create session to rundeckuser;
grant create sequence to rundeckuser;
grant create table to rundeckuser;
grant unlimited tablespace to rundeckuser;
select USERNAME from SYS.ALL_USERS;