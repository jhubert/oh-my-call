class SetPersonToActiveByDefault < ActiveRecord::Migration
  def change
    change_column :people, :active, :boolean, default: true
  end
end
