class StocksController < ApplicationController
  def index
    today = Time.zone.today
    @range = today.beginning_of_month .. today.end_of_month
    @table_data = [
      {
        product_name: "Tovar",
        variant_sku: "1020304",
        warehouse_name: "Koledino",
        stocks: {}
      }
    ]
  end
end
