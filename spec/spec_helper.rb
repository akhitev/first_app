# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  # == Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr
  config.mock_with :rspec

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path               = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  def test_sign_in(user, controller)
    controller.sign_in(user)
    #controller.stub(:logged_in?).and_return(true)
  end

  def integration_sign_in(user)
    visit signin_path
    fill_in :email, :with => user.email
    fill_in :password, :with => user.password
    click_button
  end

# TODO fixme this should be in some common place 
#  describe "for signed-in users" do
#
#      it "should require matching users for 'edit'" do
#        wrong_user = Factory(:user)
#        wrong_user.email = "user@example.net"
#        test_sign_in(wrong_user, controller)
#        get :edit, :id => @user
#        response.should redirect_to(root_path)
#      end
#
#      it "should require matching users for 'update'" do
#        put :update, :id => @user, :user => {}
#        response.should redirect_to(root_path)
#      end
#    end
  


end
