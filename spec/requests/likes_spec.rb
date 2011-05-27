require 'spec_helper'


describe "Appreciations " do
  before(:each) do
    Capybara.current_driver = :selenium
    @user = Factory(:user)
    # following user
    @other_user = Factory(:user, :email => Factory.next(:email), :name => 'SecondUser')
    @user.follow!(@other_user)

    10.times do
      Factory(:micropost, :user => @other_user)
    end
    integration_sign_in @user
    page.should have_content("Sign out")

  end
  
  after(:all) do
	  Capybara.use_default_driver
	end

  describe " follow functionality " do
    it " should follow user " do
      visit user_path @other_user
      page.should have_css("input[value='Unfollow']")
      click_button "Unfollow"
      page.should have_css("input[value='Follow']")
    end
  end

  describe " like functionality ", :js => true do
    it " should create/destroy appreciation " do
      lambda do
        visit root_path
        page.should have_css("input[value='Like']")
        click_button "Like"
        save_and_open_page
        page.has_content?("Unlike")
      end.should change(Appreciation, :count).by(1)

      lambda do
        visit root_path
        page.should have_css("input[value='Unlike']")
        click_button "Unlike"
        save_and_open_page
        page.should have_css("input[value='Like']")
      end.should change(Appreciation, :count).by(-1)
    end
  end
end
