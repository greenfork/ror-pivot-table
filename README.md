Code is in `app/controllers/stocks_controller.rb` and `app/views/stocks/index.html.erb`.

Run these commands to test:

```
rails db:setup
psql -d inventory_development -f db/seed.sql
rails server
# visit http://localhost:3000
```
