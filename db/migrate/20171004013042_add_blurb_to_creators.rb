class AddBlurbToCreators < ActiveRecord::Migration[5.1]
  def change
    add_column :creators, :name, :string
    add_column :creators, :blurb, :string
  end
end
