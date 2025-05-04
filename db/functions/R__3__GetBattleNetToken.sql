create or replace function get_battlenet_token() returns text AS $$
select regexp_replace((content::json->'access_token')::TEXT, '"', '', 'g')
  FROM http((
         'POST',
         'https://oauth.battle.net/token',
 		  ARRAY[
http_header(
  'Authorization',
  'Basic ' ||  get_battlenet_auth())    		
],
  			'application/x-www-form-urlencoded',
  			'grant_type=client_credentials'
        )::http_request);
$$ language sql;
