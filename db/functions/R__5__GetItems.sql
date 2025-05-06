drop function if exists get_items;
create or replace function get_items() returns table(id BIGINT, itemid BIGINT, quantity BIGINT, unitprice BIGINT, timeleft TEXT) as $$
select
    (json_array_elements(content::json->'auctions')->'id')::text::BIGINT as id,
    (json_array_elements(content::json->'auctions')->'item'->'id')::text::BIGINT as itemid,
    (json_array_elements(content::json->'auctions')->'quantity')::text::BIGINT as quantity,
    (json_array_elements(content::json->'auctions')->'buyout')::text::BIGINT as unitprice,
    (json_array_elements(content::json->'auctions')->'time_left')::text::TEXT as timeleft
from http(
     ('get', 'https://eu.api.blizzard.com/data/wow/connected-realm/1403/auctions?namespace=dynamic-eu',
     array[
         http_header('authorization', 'bearer ' || get_battlenet_token())
         ],
     null,
     null
     )::http_request);
$$ language sql;