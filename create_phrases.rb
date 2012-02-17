DB.create_table :phrases do
  primary_key :id
  String :phrase
end

phrases = DB[:phrases] # Create a dataset

# Populate the table
phrases.insert(:phrase => 'Phrase 1')
phrases.insert(:phrase => 'Phrase 2')
phrases.insert(:phrase => 'Phrase 3')