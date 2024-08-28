Run these commands to test:

```
rails db:setup
psql -d inventory_development -f db/seed.sql
rails server
# visit http://localhost:3000
```
