Sequel.migration do
  up do
    add_column :job_applications, :applicant_curriculum, String
  end

  down do
    drop_column :job_applications, :applicant_curriculum
  end
end
