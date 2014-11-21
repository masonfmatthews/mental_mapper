class CreateGraphCaches < ActiveRecord::Migration
  def change
    create_table :graph_caches do |t|
      t.text :unit_ids
      t.text :parentage_depths
      t.text :precedence_depths
      t.text :parentage_structure

      t.timestamps
    end
  end
end
