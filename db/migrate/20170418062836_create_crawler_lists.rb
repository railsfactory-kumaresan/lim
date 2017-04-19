class CreateCrawlerLists < ActiveRecord::Migration[5.0]
  enable_extension 'hstore' unless extension_enabled?('hstore')

  def change
    create_table :crawler_lists do |t|
      t.string :url
      t.hstore :content

      t.timestamps
    end
    add_index :crawler_lists, :content, using: :gin
  end
end
