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

Then('I am still in Registration page') do
  expect(page.current_path).to eq('/users/create')
end

Given('a user with email {string} exists') do |email|
  step 'I am at registration page'
  step 'I fill the name with "UserName"'
  fill_in('user[email]', with: email)
  step 'I fill the password with "Pasw0rd!"'
  step 'I fill the password confirmation with "Pasw0rd!"'
  step 'I confirm the registration'
end
