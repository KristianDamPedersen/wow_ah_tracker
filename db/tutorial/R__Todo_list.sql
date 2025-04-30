create or replace function api.sanitize_html(text) returns text as $$
  select replace(replace(replace(replace(replace($1, '&', '&amp;'), '"', '&quot;'),'>', '&gt;'),'<', '&lt;'), '''', '&apos;')
$$ language sql;

--- %2$s in this means to use 0 prepended spacing, use argument 2 from todos (done) as a string
create or replace function api.html_todo(api.todos) returns text as $$
  select format($html$
    <div class = "container">
      <%2$s>
        %3$s
      </%2$s>
      %4$s
    </div>
    $html$,
    $1.id,
    case when $1.done then 's' else 'span' end,
    api.sanitize_html($1.task),
    case when $1.done then '<input type="checkbox" / checked>' else '<input type="checkbox" />' end
  );
$$ language sql stable;

--if string:agg returns null, select coalesce will return the second item, in this case
-- nothing left to do.
create or replace function api.html_all_todos() returns text as $$
  select coalesce(
    string_agg(api.html_todo(t), '<hr/>' order by t.id),
    '<p><em>There is nothing else to do.</em></p>'
  )
  from api.todos t;
$$ language sql;