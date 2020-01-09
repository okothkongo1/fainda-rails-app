Feature: User Signup
	I want to signup
	So that I can have an account

	Scenario: User Succefully Create Account
		Given I am on the create account page
		Then I should see "First name"
		And I should see "Last name"
		And I should see "Email"
		And I should see "Password"
		And I should see "Password confirmation"
		And I should see "Create User" button
		When I fill in "First name" with "Jane"
		And I fill in "Last name" with "Doe"
		And I fill in "Email" with "janedoe@email.com"
		And I fill in "Password" with "Stronger*than123Usual"
		And I fill in "Password confirmation" with "Stronger*than123Usual"	
		And I click Create user 
		Then I shoud be redirect to show page
		And I should see "First name: Jane"
		And I should see "Last name: Doe"
		And I should see "Email: janedoe@email.com"

	Scenario: User With Wrong Password
		Given I am on the create account page
		And I should see "Create User" button
		When I fill in "First name" with "Jane"
		And I fill in "Last name" with "Doe"
		And I fill in "Email" with "janedoe@email.com"
		And I fill in "Password" with "Strongerthan123Usual"
		And I fill in "Password confirmation" with "Strongerthan123Usual"	
		And I click Create user 
		Then I should see "Complexity requirement not met. Length should be at least 8 characters and include: 1 uppercase, 1 lowercase, 1 digit and 1 special character"

	Scenario: User with None Match Password
		Given I am on the create account page
		When I fill in "First name" with "Jane"
		And I fill in "Last name" with "Doe"
		And I fill in "Email" with "janedoe@email.com"
		And I fill in "Password" with "Stronger*than123Usual"
		And I fill in "Password confirmation" with "Stronger*tn123Usua"	
		And I click Create user 
		Then I should see "Password confirmation doesn't match Password"

	Scenario: User With Existing Email	
		Given a registered user with the email "janedoe@gmail.com"  exists
		Given I am on the create account page		
		When I fill in "First name" with "Jane"
		And I fill in "Last name" with "Doe"
		And I fill in "Email" with "janedoe@gmail.com"
		And I fill in "Password" with "Stronger*than123Usual"
		And I fill in "Password confirmation" with "Stronger*than123Usual"
		And I click Create user			 
		Then I should see "Email has already been taken"

	Scenario: User With Wrong Email		
		Given I am on the create account page
		When I fill in "First name" with "Jane"
		And I fill in "Last name" with "Doe"
		And I fill in "Email" with "janedoeemail.com"
		And I fill in "Password" with "Stronger*than123Usual"
		And I fill in "Password confirmation" with "Stronger*than123Usual"	
		And I click Create user 
		Then I should see "Email is invalid"

	Scenario: User With Long First Name
		Given I am on the create account page
		When I fill in "First name" with "JaneJaneJaneJaneJaneJaneJaneJaneJaneJaneJane"
		And I fill in "Last name" with "Doe"
		And I fill in "Email" with "janedoe@email.com"
		And I fill in "Password" with "Stronger*than123Usual"
		And I fill in "Password confirmation" with "Stronger*than123Usual"	
		And I click Create user 
		Then I should see "First name is too long (maximum is 30 characters)"

	Scenario: User With Long Last  Name
		Given I am on the create account page
		When I fill in "First name" with "Doe"
		And I fill in "Last name" with "JaneJaneJaneJaneJaneJaneJaneJaneJaneJaneJane"
		And I fill in "Email" with "janedoe@email.com"
		And I fill in "Password" with "Stronger*than123Usual"
		And I fill in "Password confirmation" with "Stronger*than123Usual"	
		And I click Create user 
		Then I should see "Last name is too long (maximum is 30 characters)"	
	 