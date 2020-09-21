class AddLiveplaceToMicroposts < ActiveRecord::Migration[5.2]
  def change
    add_column :microposts, :liveplace, :string
  end
end
