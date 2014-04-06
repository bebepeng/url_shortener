require 'sequel'

Sequel.migration do
  up do
    URL_DATABASE.create_table(:urls) do
      primary_key :id
      String :original_url
      Integer :visits, :default => 0
    end
    URL_TABLE = URL_DATABASE[:urls]
  end

  down do
    drop_table(:urls)
  end
end

=begin
Hey,

Bebe and I have been working on incorporating a database into the URL Shortener app
and are running into a little trouble with the migrations piece.

Are any of you available today for 15 minutes or so?

Here are a couple questions we have:

Where to put the migration file
How to access the file
Where does the migration file connect to the database
=end
