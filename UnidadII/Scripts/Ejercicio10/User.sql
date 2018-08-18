--Crear nuevo usuario(esquema) con el password "PASSWORD" 
CREATE USER PLAYSTORE
  IDENTIFIED BY "oracle"
  DEFAULT TABLESPACE USERS
  TEMPORARY TABLESPACE TEMP;
--asignar cuota ilimitada al tablespace por defecto  
ALTER USER PLAYSTORE QUOTA UNLIMITED ON USERS;

--Asignar privilegios basicos
GRANT create session TO PLAYSTORE;
GRANT create table TO PLAYSTORE;
GRANT create view TO PLAYSTORE;
GRANT create any trigger TO PLAYSTORE;
GRANT create any procedure TO PLAYSTORE;
GRANT create sequence TO PLAYSTORE;
GRANT create synonym TO PLAYSTORE;
GRANT create materialized view TO PLAYSTORE;