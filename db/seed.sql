TRUNCATE products CASCADE;
ALTER SEQUENCE products_id_seq RESTART WITH 1;
ALTER SEQUENCE variants_id_seq RESTART WITH 1;
ALTER SEQUENCE stocks_id_seq RESTART WITH 1;
DROP INDEX index_stocks_on_product_id;
DROP INDEX index_stocks_on_variant_id;

WITH words AS (
  SELECT string_to_table(pg_read_file('/usr/share/dict/words'), E'\n') AS word
)
INSERT INTO products (name)
SELECT word
FROM words
ORDER BY random()
LIMIT 10000;

INSERT INTO variants (id, product_id, sku)
SELECT id + 100, id, (id + 716)::varchar
FROM products;

INSERT INTO stocks (product_id, variant_id, warehouse_name, quantity, datetime)
SELECT products.id, variants.id, 'koledino', trunc(random() * 100), date
FROM products
JOIN variants ON products.id = variants.product_id
JOIN (
  SELECT d.date
  FROM (
    SELECT generate_series('2024-01-01'::timestamp, '2024-02-02'::timestamp, '1 day'::interval) AS date
  ) d
) date ON TRUE;

CREATE INDEX index_stocks_on_product_id ON stocks(product_id);
CREATE INDEX index_stocks_on_variant_id ON stocks(variant_id);
