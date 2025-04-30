create or replace function api.sanitize_html(text) returns text as $$
  select replace(replace(replace(replace(replace($1, '&', '&amp;'), '"', '&quot;'),'>', '&gt;'),'<', '&lt;'), '''', '&apos;')
$$ language sql;