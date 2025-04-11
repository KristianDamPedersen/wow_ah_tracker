-- Seeds the database with sample data
DROP FUNCTION IF EXISTS seed; -- Nescessary in case we change the signature
CREATE OR REPLACE FUNCTION seed() RETURNS UUID AS $$
    DECLARE
        prefix UUID;
    BEGIN
        -- generate prefix
        SELECT gen_random_uuid() into prefix;

        -- Insert into the item
        INSERT INTO items (item_id, name) VALUES
        (gen_random_uuid(), prefix || '_item #1'),
        (gen_random_uuid(), prefix || '_item #2'),
        (gen_random_uuid(), prefix || '_item #3');
        
        RETURN prefix;
    END;
$$ LANGUAGE plpgsql;

-----------------
-- TEST SUITE  --
-----------------
DROP FUNCTION IF EXISTS test_seed; -- Nescessary in case we change the signature
CREATE OR REPLACE FUNCTION test_seed() RETURNS SETOF TEXT AS $$
    DECLARE
        prefix UUID;
    BEGIN 
        SELECT seed() into prefix;

        RETURN QUERY SELECT is(
            (
                SELECT COUNT(*)::int FROM items
                WHERE name like prefix || '%'
            ),
            3
        )
        RETURN;
    END;
$$ LANGUAGE plpgsql;


