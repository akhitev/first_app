require 'faker'

namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    admin = User.create!(:name => "Example User",
                 :email => "example@railstutorial.org",                 
                 :password => "foobar",
                 :password_confirmation => "foobar")

    admin.toggle!(:admin)
    make_users
    make_microposts
    make_relationships
    make_appreciations
  end
  end

    def make_users
    99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password  = "password"
      User.create!(:name => name,
                   :email => email,
                   :password => password,
                   :password_confirmation => password)
    end
    end
def make_microposts
    User.all(:limit => 6).each do |user|
      50.times do
        user.microposts.create(:content => Faker::Lorem.sentence(5))
      end
    end
  end

  def make_relationships
    users = User.all
    user = users.first
    following = users[1..50]
    followers = users[3..30]
    following.each { |followed| user.follow!(followed)}
    followers.each { |follower| follower.follow!(user)}

  end

def make_appreciations
  users = User.all
  user = users.first
  users[2].microposts.each {|post| user.like! post}
  post = users[2].microposts[1]
  users[2..10].each {|user|
    user.like! post
  }
end
