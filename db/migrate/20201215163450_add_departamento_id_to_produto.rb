class AddDepartamentoIdToProduto < ActiveRecord::Migration[5.2]
  def change
    add_column :produtos, :departamento_id, :interger
  end
end
