class AddReplyCountDefaultInPostModel < ActiveRecord::Migration[5.2]
  def change
    remove_column :posts,:replies_count
    add_column :posts,:replies_count,:integer,default:0
  end
end
