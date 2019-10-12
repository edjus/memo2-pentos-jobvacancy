Given('I am at registration page') do
  visit '/register'
end

Given('I fill the name with {string}') do |name|
  fill_in('user[name]', with: name)
end

Given('I fill the email with {string}') do |email|
  fill_in('user[email]', with: email)
end

Given('I fill the password with {string}') do |password|
  fill_in('user[password]', with: password)
end

Given('I fill the password confirmation with {string}') do |password_confirmation|
  fill_in('user[password_confirmation]', with: password_confirmation)
end

When('I confirm the registration') do
  click_button('Create')
end

Then('I am redirected to home page') do
  expect(page.current_path).to eq('/')
end
