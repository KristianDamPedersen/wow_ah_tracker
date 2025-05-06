drop function if exists get_commodities;
create or replace function get_commodities() returns table(id BIGINT,itemid BIGINT,quantity BIGINT,unitprice BIGINT,timeleft text) as $$
select (json_array_elements(content::json->'auctions')->'id')::text::BIGINT as id,
(json_array_elements(content::json->'auctions')->'item'->'id')::text::BIGINT as itemid,
(json_array_elements(content::json->'auctions')->'quantity')::text::BIGINT as quantity,
(json_array_elements(content::json->'auctions')->'unit_price')::text::BIGINT as unitprice,
(json_array_elements(content::json->'auctions')->'time_left')::text as timeleft
from http((
'get',
'https://eu.api.blizzard.com//data/wow/auctions/commodities?namespace=dynamic-eu',
	array[
		http_header('authorization', 'bearer ' || get_battlenet_token())
	],
	null,
 	null
)::http_request);
$$ language sql;
