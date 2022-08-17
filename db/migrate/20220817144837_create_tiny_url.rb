class CreateTinyUrl < ActiveRecord::Migration[6.0]
  def change
    create_table :tiny_urls do |t|
      t.string :long_url, null: false
      t.string :slug, null: false
      t.timestamps
    end

    add_index :tiny_urls, :slug, unique: true
  end
end
