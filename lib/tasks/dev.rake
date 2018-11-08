namespace :dev do
  # 請先執行 rails dev:fake_user，可以產生 20 個資料完整的 User 紀錄
  # 其他測試用的假資料請依需要自行撰寫
  task fake_user: :environment do
    User.where.not(role: "admin").destroy_all
    20.times do |i|
      name = FFaker::Name::first_name
      file = File.open("#{Rails.root}/public/avatar/user#{rand(1..8)}.png")

      user = User.create!(
        name: name,
        email: "#{name}@example.com",
        password: "12345678",
        introduction: FFaker::Lorem::sentence(30),
        avatar: file
      )
      puts user.name
    end
    puts "have create fake users"
    puts "now you have #{User.count} users"
  end

  task fake_post_submit: :environment do
    Post.where(status: true ).destroy_all
    120.times do |i|
      file = File.open("#{Rails.root}/public/posimage/image#{rand(1..10)}.jpg")

      Post.create!(
        title: FFaker::Lorem::sentence(5),
        content: FFaker::Lorem::sentence(40),
        image: file,
        status:true,
        user_id: User.all.sample.id,
        )
    end

    puts "have create fake submit posts "
    puts "now you have #{Post.where(status:true).count} submit posts"
  end

  task fake_post_draft: :environment do
    Post.where(status: false ).destroy_all

    User.all.each do |user|
      3.times do |i|
        file = File.open("#{Rails.root}/public/posimage/image#{rand(1..10)}.jpg")

        Post.create!(
          title: FFaker::Lorem::sentence(5),
          content: FFaker::Lorem::sentence(40),
          image: file,
          status:false,
          user_id: User.all.sample.id,
          )
      end
    end
    puts "have create fake draft posts"
    puts "now you have #{Post.where(status:false).count} draft posts"
  end

  task fake_post_category: :environment do
    Post.all.each do |post|
      post.categories << Category.all.sample(rand(1..3))
    end
    puts "All posts have at least one category."
  end

  task fake_reply: :environment do
    Post.where(status: true).each do |post|
      5.times do |i|
        Reply.create!(
          content:FFaker::Lorem::sentence(15),
          user_id: User.all.sample.id,
          post_id: post.id
        )
      end
    end
    puts "have create fake replies"
    puts "now you have #{Reply.count} replies"
  end

  task last_reply: :environment do
    Post.all.each do |post|  
      post.last_replied_at = post.replies.order(created_at: :desc).first.created_at
      post.save 
    end
    puts "done"
  end

  task fake_favorite: :environment do
    Favorite.destroy_all

    @posts = Post.where(status:true)
    @users = User.all 

      100.times do |i|
        Favorite.create!(
          user_id: @users.sample.id,
          post_id: @posts.sample.id,
          )
      end

    puts "have created fake 100 collects data."
    puts "now you have #{Favorite.count} Collects data"
  end

  task fake_friend: :environment do
    Friendship.destroy_all

    200.times do |i|
      user = User.all.sample
      friend_id = User.all.sample.id
      friendship = Friendship.where(user: User.find(friend_id), friend_id: user.id).first
      
      if friendship == nil && user.id != friend_id
        Friendship.create(
          user: user,
          friend_id: friend_id,
        )
      end
    end

    puts "Now there are #{Friendship.count} possible friendships"
  end

end  
