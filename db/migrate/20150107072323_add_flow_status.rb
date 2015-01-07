class AddFlowStatus < ActiveRecord::Migration
  def change
    add_column :flows , :status , :string
  end
end
