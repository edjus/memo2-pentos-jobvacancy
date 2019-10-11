Given('{string} offer exists') do |title|
  create_offer title
end

Given('I fill the search bar with {string}') do |search|
  fill_in('search-input', with: search)
end

When('I click search') do
  click_button('search')
end

When('I click clear search') do
  click_button('clear search')
end
