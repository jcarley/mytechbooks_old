Feature: Add a book
  In order to add new books
  A registered user
  Should have access to the add a book page

    @javascript @vcr
    Scenario: User adds a book
      Given I am logged in
       When I go to the add a book page
       And  I register the ISBN of '0321659368'
       Then I should see a successful registered book message

