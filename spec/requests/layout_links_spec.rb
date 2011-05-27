require 'spec_helper'

describe "LayoutLinks" do


  it "should have a Home page at '/'" do
    visit '/'
    page.should have_selector('title', :content => "Home")
  end

  it "should have a Contact page at '/contact'" do
    visit '/contact'
    page.should have_selector('title', :content => "Contact")
  end

  it "should have an About page at '/about'" do
    visit '/about'
    page.should have_selector('title', :content => "About")
  end

  it "should have a Help page at '/help'" do
    visit '/help'
    page.should have_selector('title', :content => "Help")
  end

    it "should have a signup page at '/signup'" do
    visit '/signup'
    page.should have_selector('title', :content => "Sign up")
    end

  it "should have the right links on the layout" do
     visit root_path
     click_link "About"
     page.should have_selector('title', :content => "About")
     click_link "Help"
     page.should have_selector('title', :content => "Help")
     click_link "Contact"
     page.should have_selector('title', :content => "Contact")
     click_link "Home"
     page.should have_selector('title', :content => "Home")
     click_link "Sign up now!"
     page.should have_selector('title', :content => "Sign up")
  end

  describe "when not signed in" do
      it "should have a signin link" do
        visit root_path
        page.should have_selector("a", :href => signin_path,
                                           :content => "Sign in")
      end
    end
  
  describe "when signed in" do

    before(:each) do      
      @user = Factory(:user)
      integration_sign_in(@user)
    end

    it "should have a signout link" do
      visit root_path
      page.should have_selector("a", :href => signout_path,
                                         :content => "Sign out")
    end

    it "should have a profile link" do
     visit root_path
     click_link "Profile"
     page.should have_selector('title', :content => @user.name)
    end
  end
  
  end
