require 'spec_helper'

describe Appreciation do
  before(:each) do
    @liker = Factory(:user)
    @author = Factory(:user,:email => Factory.next(:email))
    @liked = @author.microposts.create!(:content => "value for content",
             :user_id => @author.id)

    @appreciation = @liker.appreciations.build(:liked => @liked)
  end

  it "should create a new instance given valid attributes" do
    @appreciation.save!
  end

  describe "follow methods" do

    before(:each) do
      @appreciation.save
    end

    it "should have a liked_id attribute" do
      @appreciation.should respond_to(:liked)
    end

    it "should have the right liked " do
      @appreciation.liked.should == @liked
    end

    it "should have a followed attribute" do
      @appreciation.should respond_to(:liker)
    end

    it "should have the right liker user" do
      @appreciation.liker.should == @liker
    end

    describe "validations" do

      it "should require a liked_id" do
        @appreciation.liked_id = nil
        @appreciation.should_not be_valid
      end

      it "should require a liker_id" do
        @appreciation.liker_id = nil
        @appreciation.should_not be_valid
      end

      it "should not allow to like self posts" do
        @liked = @liker.microposts.create!(:content => "post",
                 :user_id => @liker.id)
        @appreciation = @liker.appreciations.build(:liked => @liked)
        @appreciation.should_not be_valid
      end

      it "should allow to like others posts" do
        @appreciation.should be_valid
      end

    end
  end

end
