DO
$do$
BEGIN
   IF EXISTS (
      SELECT FROM pg_catalog.pg_roles
      WHERE  rolname = 'web_anon') THEN

      RAISE NOTICE 'Role "web_anon" already exists. Skipping.';
   ELSE
      CREATE ROLE web_anon LOGIN PASSWORD 'my_password';
   END IF;
END
$do$;

REASSIGN OWNED BY web_anon TO postgres;  -- some trusted role
DROP OWNED BY web_anon;

drop role if exists web_anon;
create role web_anon nologin;
drop role if exists authenticator;
create role authenticator noinherit login password 'mysecretpassword';
grant web_anon to authenticator;
grant usage on schema api to web_anon;
grant usage on schema public to web_anon;
grant select on api.todos to web_anon;
grant select on items to web_anon;
