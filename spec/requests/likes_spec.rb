require 'spec_helper'


describe "Appreciations " do
  before(:each) do
    Capybara.default_driver = :selenium
    @user = Factory(:user)
    # following user
    @other_user = Factory(:user, :email => Factory.next(:email), :name => 'SecondUser')
    @user.follow!(@other_user)

    10.times do
      Factory(:micropost, :user => @other_user)
    end
    visit signin_path
    fill_in 'Email', :with => @user.email
    fill_in 'Password', :with => @user.password
    puts @user.email
    click_button "Sign in"
    save_and_open_page
    page.should have_content("Sign out")

  end

  describe " follow functionality " do
    it " should follow user " do
      visit user_path @other_user
      page.should have_css ("input[value='Unfollow']")
      click_button "Unfollow"
      puts page.body
      page.should have_css ("input[value='Follow']")
    end
  end

  describe " like functionality " , :js => true do
    Capybara.default_driver = :selenium
    it " should create appreciation " do
      lambda do
        visit root_path
        puts page.body
        page.should have_css("input", :value => "zzzLike")
        click_button "Like"
        save_and_open_page
        page.has_content?("Unlike")
      end.should change(Appreciation, :count).by(1)
    end
  end
end
