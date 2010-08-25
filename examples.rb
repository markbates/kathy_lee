# Define attributes:
KathyLee.attributes(:user) do
  name 'Mark Bates'
  email fake(:email)
  bio 'This is my bio!'
end

# Retrieve attributes:
KathyLee.attributes(:user) # => {:name => 'Mark Bates', :email => 'foo@example.com', :bio => 'This is my bio!'}
KathyLee.attributes(:user, :bio => 'I like things.') # => {:name => 'Mark Bates', :email => 'foo@example.com', :bio => 'I like things.'}

# Build an object, will try User, unless a factory is defined:
user = KathyLee.build(:user)
user.new_record? # => true
user.id # => nil
user.name # => 'Mark Bates'
user.email # => 'foo@example.com'
user.bio # => 'This is my bio!'

# Create an object:
user = KathyLee.create(:user)
user.new_record? # => false
user.id # => 1
user.name # => 'Mark Bates'
user.email # => 'foo@example.com'
user.bio # => 'This is my bio!'

user = KathyLee.create(:user, :bio => 'I like Things.') # => User.new(KathyLee.attributes(:user))
user.new_record? # => false
user.id # => 1
user.name # => 'Mark Bates'
user.email # => 'foo@example.com'
user.bio # => 'I like things.'

# Define a new factory:
KathyLee.define(:post) do
  post = Post.new(options)
  post
end

post = KathyLee.build(:post)
post.new_record? # => true
post.id # => nil

post = KathyLee.build(:post, :title => 'My Title')
post.new_record? # => true
post.id # => nil
post.title # => 'My Title'

# Define a new factory, specifying which attributes to use
KathyLee.define(:post_with_user, :attributes_for => :post) do
  has_one :user

  post = Post.new(options)
  post
end

post = KathyLee.build(:post_with_user)
post.new_record? # => true
post.id # => nil
post.user.new_record? # => true
post.user.id # => nil
post.user.name # => 'Mark Bates'
post.user.email # => 'foo@example.com'
post.user.bio # => 'This is my bio!'

KathyLee.define(:user_with_posts, :attributes_for => :user) do
  has_many :posts, :size => 2
  
  has_one :blog do
    blog = Blog.new
    blog.title = "My Title: #{parent.name}"
    blog
  end
  
  user = User.new(options)
  user.posts = []
  user
end

user = KathyLee.create(:user_with_posts)
blog = user.blog
blog.title # => 'My Title'
blog.id # => 1
blog.new_record? # => false
user.posts.size # => 2