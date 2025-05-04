
-- uses docker secret battlenet_secret
select vault.create_secret(
	(select pg_read_file('/run/secrets/battlenet_secret' , 0 , 1000000)),
    'battlenet_clientsecret',
	'The client secret for battlenet API.');

-- uses docker secrets battlenet_client
select vault.create_secret(
	(select pg_read_file('/run/secrets/battlenet_client' , 0 , 1000000)),
    'battlenet_clientid',
	'The client secret for battlenet API.');