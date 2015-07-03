class Event < ActiveRecord::Base

  validates_presence_of :name

  belongs_to :user

  has_many :attendees
  belongs_to :category

  delegate :name, :to => :category, :prefix => true, :allow_nil => true

  has_many :event_groupships
  has_many :groups, :through => :event_groupships

  has_many :taggings
  has_many :tags, :through => :taggings

  has_attached_file :logo, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :logo, :content_type => /\Aimage\/.*\Z/

  def tag_list
    self.tags.map{ |x| x.name }.join(",")
  end

  def tag_list=(str)
    ids = str.split(",").map do |tag_name|
      tag_name.strip!
      tag = Tag.find_by_name( tag_name ) || Tag.create( :name => tag_name )
      tag.id
    end

    self.tag_ids = ids
  end

end
