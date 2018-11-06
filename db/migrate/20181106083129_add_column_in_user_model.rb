class AddColumnInUserModel < ActiveRecord::Migration[5.2]
  def change
    add_column :users,:name,:string
    add_column :users,:introduction,:text
    add_column :users,:role,:string,default: "normal"
    add_column :users,:avatar,:string
  end
end