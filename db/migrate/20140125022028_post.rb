class Post < ActiveRecord::Migration
  def up
  	create_table :posts do |t|
  		t.string :title
  		t.text :text

  		t.timestamps
  	end
  end

  def down
  	drop_table :posts
  end
end
