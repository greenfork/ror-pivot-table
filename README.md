Pivot table in Postgres implementation;

Code is in `app/controllers/stocks_controller.rb` and `app/views/stocks/index.html.erb`.

Run these commands to test:

```
rails db:setup
psql -d inventory_development -f db/seed.sql
psql -d inventory_development -c 'create extension tablefunc;'
rails server
# visit http://localhost:3000
```
