class AddLivedatetimeToMicroposts < ActiveRecord::Migration[5.2]
  def change
    add_column :microposts, :livedatetime, :timestamp
  end
end
