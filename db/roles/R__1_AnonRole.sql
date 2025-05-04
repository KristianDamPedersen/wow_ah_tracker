-- Reset permissions
DO
$$
    BEGIN
        IF EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'web_anon') THEN
            ALTER DEFAULT PRIVILEGES FOR ROLE web_anon REVOKE ALL ON TABLES FROM web_anon;
            REASSIGN OWNED BY web_anon TO postgres;
            DROP OWNED BY web_anon;
        END IF;
    END
$$;

-- (Re)create the role
DROP ROLE IF EXISTS web_anon;
CREATE ROLE web_anon NOLOGIN;
GRANT web_anon to postgres; -- Ensures that the postgres role can edit these properties

-- Grant privileges
GRANT USAGE ON SCHEMA api TO web_anon;
GRANT SELECT ON api.todos TO web_anon;
GRANT USAGE, SELECT ON SEQUENCE api.todos_id_seq TO web_anon;