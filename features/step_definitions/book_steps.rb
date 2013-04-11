### GIVEN ###

### WHEN ###
When(/^I go to the add a book page$/) do
  visit '/books/new'
end

When(/^I register the ISBN of '(\d+)'$/) do |isbn|
  fill_in "book_isbn", :with => isbn
  click_button "Add Book"
end

### THEN ###
Then(/^I should see a successful registered book message$/) do
  page.should have_xpath('//*[@id="messages"]/span')
end

