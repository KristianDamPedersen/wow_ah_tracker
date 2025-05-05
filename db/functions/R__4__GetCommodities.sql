-- get commodities
create or replace function get_commodities() returns table(id json,itemid json,quantity json,unitprice json,timeleft json) as $$
select json_array_elements(content::json->'auctions')->'id' as auctionid,
json_array_elements(content::json->'auctions')->'item'->'id' as itemid,
json_array_elements(content::json->'auctions')->'quantity' as quantity,
json_array_elements(content::json->'auctions')->'unit_price' as unitprice,
json_array_elements(content::json->'auctions')->'time_left' as timeleft
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
