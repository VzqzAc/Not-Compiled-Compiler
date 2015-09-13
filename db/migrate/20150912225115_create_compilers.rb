class CreateCompilers < ActiveRecord::Migration
  def change
    create_table :compilers do |t|
      t.text :source_code

      t.timestamps null: false
    end
  end
end
