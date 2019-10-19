Sequel.migration do
  up do
    add_column :job_applications, :remuneration_min, Numeric
    add_column :job_applications, :remuneration_max, Numeric
  end

  down do
    drop_column :job_applications, :remuneration_min
    drop_column :job_applications, :remuneration_max
  end
end
