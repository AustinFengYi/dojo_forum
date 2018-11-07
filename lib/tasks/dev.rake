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

  task fake_post: :environment do
    Post.destroy_all
    120.times do |i|
      file = File.open("#{Rails.root}/public/posimage/image#{rand(1..10)}.jpg")

      Post.create!(
        title: FFaker::Lorem::sentence(10),
        content: FFaker::Lorem::sentence(40),
        image: file,
        user_id: User.all.sample.id,
        category_id: Category.all.sample.id
        )
    end

    puts "have create fake posts"
    puts "now you have #{Post.count} posts"
  end

  task fake_reply: :environment do
    Post.all.each do |post|
      5.times do |i|
        Reply.create!(
          content:FFaker::Lorem::sentence(20),
          user_id: User.all.sample.id,
          post_id: post.id
        )
      end
    end
    puts "have create fake replies"
    puts "now you have #{Reply.count} replies"
  end

  task fake_favorite: :environment do
    Favorite.destroy_all

    @posts = Post.all
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

end  
