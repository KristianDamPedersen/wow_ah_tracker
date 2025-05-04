create role authenticator noinherit login password 'mysecretpassword';
grant web_anon to authenticator;
