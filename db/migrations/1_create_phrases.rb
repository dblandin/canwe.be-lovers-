Sequel.migration do
  up do
    create_table(:phrases) do
      primary_key :id
      String :phrase, :null => true
    end
  end
  down do
    drop_table(:phrases)
  end