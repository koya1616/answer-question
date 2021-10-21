class CreateQAndARelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :q_and_a_relationships do |t|
      t.references :question, foreign_key: true
      t.references :answer  , foreign_key: true

      t.timestamps
    end
  end
end
