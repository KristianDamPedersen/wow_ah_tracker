REASSIGN OWNED BY web_anon TO postgres;  -- some trusted role
DROP OWNED BY web_anon;

drop role if exists web_anon;
create role web_anon nologin;

grant usage on schema api to web_anon;
grant select on api.todos to web_anon;
