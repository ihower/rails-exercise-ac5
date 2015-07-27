namespace :dev do

  task :ben => :environment do

    require 'benchmark'

    n = 100
    Benchmark.bm do |x|
      x.report {
        n.times { Event.first }
      }
      x.report {
        n.times { Event.select(:id).first }
      }
    end

  end

  task :fake_product => :environment do
    Product.delete_all

    100.times do
      Product.create!( :title => Faker::App.name,
                       :price => ( rand(100)+1 ) * 100 ,
                       :image_url => Faker::Avatar.image,
                       :qty_in_stock => rand(10),
                       :description => Faker::Lorem.paragraph )
    end
  end

  task :fix_user_auth_token => :environment do
    User.find_each do |u|
      puts "Update #{u.id} token"
      u.generate_authentication_token
      u.save!
    end
  end

  task :fake_todos => :environment do
    Todo.delete_all

    20.times do |i|
      Todo.create( :title => Faker::App.name )
    end

  end

  task :fix_events_friendly_id => :environment do
    Event.all.each do |e|
      e.friendly_id = SecureRandom.hex(10)
      e.save!
    end
  end

  task :parse_104 => :environment do
    conn = Faraday.new(:url => 'http://www.104.com.tw' )
    res = conn.get '/job/?jobno=3azzu&jobsource=104_bank1&hotjob_chr='
    doc = Nokogiri::HTML(res.body)

    puts doc.css(".company a")[0].content
  end

  task :get_ubike => :environment do
    conn = Faraday.new(:url => 'http://data.taipei' )
    res = conn.get '/opendata/datalist/apiAccess?scope=resourceAquire&rid=ddb80380-f1b3-4f8e-8016-7ed9cba571d5'
    data = JSON.parse( res.body )

    # Create or Update
    data["result"]["results"].each do |u|
      ubike = Ubike.find_by_iid( u["iid"] )
      if ubike
        ubike.name = u["sna"]
        ubike.data = u["data"]
        ubike.save!
        puts "Update ubike: #{ubike.id}"
      else
        ubike = Ubike.create!( :name => u["sna"], :iid => u["iid"], :data => u )
        puts "Create ubike: #{ubike.id}"
      end
    end

    # Delete
    source_ids = data["result"]["results"].map{ |x| x["iid"] }
    our_ids = Ubike.all.map{ |x| x.iid }
    deleting_ids = our_ids - source_ids
    deleting_ids.each do |i|
      puts "Delete ubike iid: #{i}"
      Ubike.find(i).destroy
    end

  end

  task :rebuild => ["db:drop", "db:setup", :fake]
  #task :rebuild => ["db:drop", "db:create", "db:schema:load", "db:seed", :fake]

  task :fake => :environment do
    User.delete_all
    Event.delete_all
    Attendee.delete_all

    puts "Creating fake data!"

    user = User.create!( :email => "ihower@gmail.com", :password => "12345678")

    50.times do |i|
      e = Event.create( :name => Faker::App.name )
      10.times do |j|
        e.attendees.create( :name => Faker::Name.name )
      end
    end

  end

end