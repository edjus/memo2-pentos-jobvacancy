Sequel.migration do
  up do
    add_column :job_applications, :applicant_bio, String
  end

  down do
    drop_column :job_applications, :applicant_bio
  end
end
