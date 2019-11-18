class AddFigureToNews < ActiveRecord::Migration[5.2]
  def change
    add_column :news, :figure_image, :string
    add_column :news, :figure_alternative, :string
    add_column :news, :figure_caption, :string
  end
end
