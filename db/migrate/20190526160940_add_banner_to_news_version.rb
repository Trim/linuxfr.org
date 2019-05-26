class AddBannerToNewsVersion < ActiveRecord::Migration[5.2]
  def change
    add_column :news_versions, :banner, :string, limit: 255
  end
end
