class Post < FauxRecord
  
end

KathyLee.define(:post) do
  post = Post.new(options)
  post
end

KathyLee.define(:post_with_user, :attributes_for => :post) do
  has_one :user

  post = Post.new(options)
  post
end