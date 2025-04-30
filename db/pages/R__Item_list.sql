create or replace function item_list(items) returns text as $$
  select format($html$
    <div class = "container">
      <p>Name: %1$s</p>
    </div>
    $html$,
    api.sanitize_html($1.name)
  );
$$ language sql stable;

create or replace function html_all_items() returns text as $$
  select coalesce(
    string_agg(item_list(i), '<hr/>' order by i.name),
    '<p><em>There are currently no items in the database</em></p>'
  )
  from items i;
$$ language sql;