create or replace function get_secret(text) returns text as $$
select decrypted_secret 
from vault.decrypted_secrets 
where name=$1 and decrypted_secret is not null;
$$ language sql;

