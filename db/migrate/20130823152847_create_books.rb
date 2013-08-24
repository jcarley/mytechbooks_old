class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.string :ean
      t.string :isbn
      t.integer :pages
      t.string :binding
      t.integer :edition
      t.string :formatted_price
      t.string :asin
      t.string :amount
      t.string :details_url
      t.string :description
      t.string :small_img_url
      t.string :medium_img_url
      t.string :large_img_url
      t.string :publisher
      t.date :published_on

      t.timestamps
    end
  end
end
