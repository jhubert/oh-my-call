class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.integer :user_id
      t.string :phone_number
      t.string :fullname
      t.string :nickname
      t.boolean :active

      t.timestamps
    end

    add_index :people, ['user_id', 'phone_number'], name: 'index_people_on_user_and_phone_number'
  end
end
