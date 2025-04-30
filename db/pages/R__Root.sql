create or replace function api.index() returns "text/html" as $$
    select $html$
     <!DOCTYPE html>
    <html>
    <head>
      <meta charset="utf-8">
      <meta name="viewport" content="width=device-width, initial-scale=1">
      <title>Wow AH Tracker</title>
      <!-- Pico CSS for CSS styling -->
      <link href="https://cdn.jsdelivr.net/npm/@picocss/pico@next/css/pico.min.css" rel="stylesheet" />
    </head>
    <body>
      <main class="container">
        <article>
          <h5 style="text-align: center;">
            World of warcraft AH items tracker.
          </h5>
        </article>
        $html$
        ||html_all_items()||
        $html$
      </main>
      <!-- Script for Ionicons icons -->
      <script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
      <script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
    </body>
    </html>
    $html$
$$ language sql;