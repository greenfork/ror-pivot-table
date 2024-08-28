class StocksController < ApplicationController
  def index
    # This should be in production:
    # today = Time.zone.today
    # @range = today.beginning_of_month .. today.end_of_month
    @range = "2024-01-01".to_datetime .. "2024-02-02".to_datetime
    dates = @range.to_a.map.with_index { |_, i| "dat#{i}" }
    date_columns = dates.map { "#{_1} integer" }.join(", ")
    sort_keys = %w[name sku warehouse] + dates
    sort_key = "name"
    sort_key = params[:sort] if sort_keys.include?(params[:sort])

    query_results = ActiveRecord::Base.connection.execute <<~SQL
      SELECT *
      FROM crosstab(
        'SELECT name, sku, warehouse_name, datetime, quantity
         FROM stocks
         JOIN products ON products.id = stocks.product_id
         JOIN variants ON variants.product_id = stocks.product_id
         ORDER BY 1,2',
        'SELECT d FROM generate_series(
          ''#{@range.begin.rfc3339}''::timestamp,
          ''#{@range.end.rfc3339}''::timestamp,
          ''1 day''::interval
         ) d'
      ) AS t(name varchar, sku varchar, warehouse varchar, #{date_columns})
      ORDER BY #{sort_key}
      LIMIT 100
    SQL

    @table_data = query_results.values
  end
end
