class AddCountToUserPostModel < ActiveRecord::Migration[5.2]
  def change
    add_column :users,:user_replies_count,:integer,default:0

    add_column :posts,:viewed_count,:integer,default:0
  end
end
