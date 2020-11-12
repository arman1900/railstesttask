class UpdateColumns < ActiveRecord::Migration[5.2]
  def change
    change_table :users do |t|
      t.change :role, :integer
    end
  end
end
