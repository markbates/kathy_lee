class User < FauxRecord
  
end

KathyLee.attributes(:user) do
  name 'Mark Bates'
  email {'foo@example.com'}
  bio 'This is my bio!'
end

KathyLee.define(:user_with_posts, :attributes_for => :user) do
  has_many :posts, :size => 2
  
  has_one :blog do |user|
    blog = Blog.new
    blog.title = 'My Title'
    blog
  end
  
  user = User.new(options)
  user.posts = []
  user
end