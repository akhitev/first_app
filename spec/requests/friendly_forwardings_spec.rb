require 'spec_helper'

describe "FriendlyForwardings" do

  it "should forward to the requested page after signin" do
    user = Factory(:user)
    visit edit_user_path(user)
    # The test automatically follows the redirect to the signin page.
    fill_in 'session_email', :with => user.email
    fill_in 'session_password', :with => user.password
    click_button "Sign in"
    # The test follows the redirect again, this time to users/edit.
    save_and_open_page
    page.should have_selector('.editUser')
  end
  
  

end 