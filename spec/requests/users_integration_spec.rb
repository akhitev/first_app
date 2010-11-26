require 'spec_helper'

describe "UsersIntegration" do
  describe "signup " do
    describe "failure" do

      it "should not make new user" do
        lambda do
        visit signup_path
        fill_in "Name" , :with => ""
        fill_in "Email" , :with => ""
        fill_in "Password" , :with => ""
        fill_in "Confirmation" , :with => ""

        click_button
        response.should render_template('users/new')
        response.should have_selector("div#error_explanation")
          end.should_not change(User, :count) 
      end
    end

    describe "success" do
      it "should make new user" do
        lambda do
        visit signup_path
        fill_in "Name" , :with => "Alex"
        fill_in "Email" , :with => "aa@ya.ru"
        fill_in "Password" , :with => "foobar"
        fill_in "Confirmation" , :with => "foobar"

        click_button
        response.should render_template('users/show')
        response.should have_selector("div.flash.success", :content => "User created")
          end.should change(User, :count).by(1)
      end

    end
  end

    describe "sign in/out" do

    describe "failure" do
      it "should not sign a user in" do
        integration_sign_in(User.new)
        response.should have_selector("div.flash.error", :content => "Invalid")
      end
    end

    describe "success" do
      it "should sign a user in and out" do
        user = Factory(:user)
        visit signin_path
        fill_in :email,    :with => user.email
        fill_in :password, :with => user.password
        click_button
        puts controller.inspect
        controller.should be_signed_in
        click_link("Sign out")
        controller.should_not be_signed_in
      end
    end
    end
  
end
