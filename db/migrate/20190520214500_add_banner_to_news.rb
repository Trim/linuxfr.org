class AddBannerToNews < ActiveRecord::Migration[5.2]
  def change
    add_column :news, :banner, :string, limit: 255
  end
end
