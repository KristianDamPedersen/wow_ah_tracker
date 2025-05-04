create or replace function get_battlenet_auth() returns text as $$
	select regexp_replace(
			encode(
				convert_to(
					rtrim(get_secret('battlenet_clientid')) || ':' || rtrim(get_secret('battlenet_clientsecret')),
					'UTF8'
				),
				'base64'
			),
			'\r|\n', 
			'',
			 'g'
)as id;
$$ language sql;