require 'spec_helper'

describe "kathy_lee" do

  describe "attributes" do
    
    it "should do something" do
      KathyLee.attributes(:user).should == {:name => 'Mark Bates', :email => 'foo@example.com', :bio => 'This is my bio!'}
    end
    
    it "should do something" do
      KathyLee.attributes(:user, :bio => 'I like things.').should == {:name => 'Mark Bates', :email => 'foo@example.com', :bio => 'I like things.'}
    end
    
  end
  
  describe "build" do
    
    it "should do something" do
      user = KathyLee.build(:user)
      user.should be_kind_of(User)
      user.should be_new_record
      user.id.should be_nil
      user.name.should == 'Mark Bates'
      user.email.should == 'foo@example.com'
      user.bio.should == 'This is my bio!'
    end
    
    it "should do something else" do
      post = KathyLee.build(:post)
      post.should be_kind_of(Post)
      post.should be_new_record
      post.id.should be_nil
    end
    
    it "should do another thing" do
      post = KathyLee.build(:post, :title => 'My Title')
      post.should be_kind_of(Post)
      post.should be_new_record
      post.id.should be_nil
      post.title.should == 'My Title'
    end
    
    it "should do yet another thing" do
      post = KathyLee.build(:post_with_user)
      post.should be_kind_of(Post)
      post.should be_new_record
      post.id.should be_nil
      post.user.should be_new_record
      post.user.id.should be_nil
      post.user.name.should == 'Mark Bates'
      post.user.email.should == 'foo@example.com'
      post.user.bio.should == 'This is my bio!'
    end
    
    it "should do yet another thing 2" do
      user = KathyLee.build(:user, :name => 'Mark!')
      post = KathyLee.build(:post_with_user, :user => user)
      post.should be_kind_of(Post)
      post.should be_new_record
      post.id.should be_nil
      post.user.should === user
      post.user.should be_new_record
      post.user.id.should be_nil
      post.user.name.should == 'Mark!'
      post.user.email.should == 'foo@example.com'
      post.user.bio.should == 'This is my bio!'
    end
    
  end
  
  describe "create" do
    
    it "should do something" do
      user = KathyLee.create(:user)
      user.should be_kind_of(User)
      user.should_not be_new_record
      user.id.should_not be_nil
      user.name.should == 'Mark Bates'
      user.email.should == 'foo@example.com'
      user.bio.should == 'This is my bio!'
    end
    
    it "should do something" do
      user = KathyLee.create(:user, :bio => 'I like Things.')
      user.should be_kind_of(User)
      user.should_not be_new_record
      user.id.should_not be_nil
      user.name.should == 'Mark Bates'
      user.email.should == 'foo@example.com'
      user.bio.should == 'I like Things.'
    end
    
    it "should do something else" do
      user = KathyLee.create(:user_with_posts)
      user.should be_kind_of(User)
      user.should_not be_new_record
      user.id.should_not be_nil
      user.name.should == 'Mark Bates'
      user.email.should == 'foo@example.com'
      user.bio.should == 'This is my bio!'
      blog = user.blog
      blog.should be_kind_of(Blog)
      blog.title.should == 'My Title'
      blog.id.should_not be_nil
      blog.should_not be_new_record
      user.posts.size.should == 2
      user.posts.each do |post|
        post.should be_kind_of(Post)
        post.should_not be_new_record
      end
    end
    
  end
  
  describe "sweatshop" do
    
    it "should return an array of new objects" do
      results = KathyLee.sweatshop(:user)
      results.size.should == 2
      results.each do |user|
        user.should be_kind_of(User)
        user.should be_new_record
        user.id.should be_nil
        user.name.should == 'Mark Bates'
        user.email.should == 'foo@example.com'
        user.bio.should == 'This is my bio!'
      end
    end
    
  end
  
  describe "sweatshop!" do
    
    it "should return an array of new objects" do
      results = KathyLee.sweatshop!(:user, 3)
      results.size.should == 3
      results.each do |user|
        user.should be_kind_of(User)
        user.should_not be_new_record
        user.id.should_not be_nil
        user.name.should == 'Mark Bates'
        user.email.should == 'foo@example.com'
        user.bio.should == 'This is my bio!'
      end
    end
    
  end

end
