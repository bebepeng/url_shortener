Sequel.migration do
  up do
    add_column :urls, :vanity, String, :unique => true
  end

  down do
    drop_column :urls, :vanity
  end
end