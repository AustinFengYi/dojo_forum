class AddColumnInPostModel < ActiveRecord::Migration[5.2]
  def change
    add_column :posts,:status,:boolean,default:false
    add_column :posts,:authority,:string,default: "All" 
  end
end