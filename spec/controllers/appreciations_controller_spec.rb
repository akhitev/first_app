require 'spec_helper'

describe AppreciationsController do
  render_views
  
  describe "access control" do

    it "should deny access to 'create'" do
      post :create
      page.should redirect_to(signin_path)
    end

    it "should deny access to 'destroy'" do
      delete :destroy, :id => 1
      page.should redirect_to(signin_path)
    end
  end
  describe "POST 'create'" do
    before(:each) do
      @user = test_sign_in(Factory(:user))
      @author = Factory(:user, :email => Factory.next(:email))
      @liked = @author.microposts.create!(:content => "content")
      puts @liked
    end

    it "should create a appreciation " do
      lambda do
        xhr :post, :create, :appreciation => { :liked_id => @liked}
        page.should be_success
      end.should change(Appreciation, :count).by(1)
    end
  end
end
