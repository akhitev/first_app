require 'spec_helper'

describe "UsersIntegration" do
  describe "signup " do
    describe "failure" do

      it "should not make new user" do
        lambda do
          visit signup_path
          fill_in "Name", :with => ""
          fill_in "Email", :with => ""
          fill_in "Password", :with => ""
          fill_in "Confirmation", :with => ""
          click_button "Sign up"
          page.should have_selector("h1", :content =>'Sign up')
          page.should have_selector("div#error_explanation")
        end.should_not change(User, :count)
      end
    end

    describe "success" do
      it "should make new user" do
        lambda do
          visit signup_path
          fill_in "Name", :with => "Alex"
          fill_in "Email", :with => "aa@ya.ru"
          fill_in "Password", :with => "foobar"
          fill_in "Confirmation", :with => "foobar"

          click_button "Sign up"
          page.should have_selector("table[summary='Profile information']")
          page.should have_selector("div.flash.success", :content => "User created")
        end.should change(User, :count).by(1)
      end

    end
  end

  describe "sign in/out" do

    describe "failure" do
      it "should not sign a user in" do
        user = User.new
        visit signin_path
        puts user.email
        fill_in 'session_email', :with => user.email
        fill_in 'session_password', :with => user.password
        click_button "Sign in"
        page.should have_selector("div.flash.error", :content => "Invalid")
      end
    end

    describe "success" do
      it "should sign a user in and out" do
        user = Factory(:user)
        integration_sign_in user
        click_link("Sign out")
        page.should have_content("Sign in")
      end
    end
  end

end
