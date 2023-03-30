class AddOrganisationIdToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :organisation_id, :integer, index: true
  end
end
