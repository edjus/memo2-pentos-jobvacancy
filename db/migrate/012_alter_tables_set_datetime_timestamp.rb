Sequel.migration do
  up do
    # postgresql's equivalent to datetime is timestamp
    change_timestamp_column_type(:job_applications, 'timestamp')
    change_timestamp_column_type(:users, 'timestamp')
    change_timestamp_column_type(:job_offers, 'timestamp')
  end

  down do
    change_timestamp_column_type(:job_applications, :Date)
    change_timestamp_column_type(:users, :Date)
    change_timestamp_column_type(:job_offers, :Date)
  end
end

def change_timestamp_column_type(table, type)
  alter_table(table) do
    set_column_type :created_on, type
    set_column_type :updated_on, type
  end
end
