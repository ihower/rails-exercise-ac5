class Event < ActiveRecord::Base

  STATUS = ["published", "draft"]

  validates_inclusion_of :status, :in => STATUS

  attr_accessor :_remove_logo

  validates_presence_of :name, :friendly_id

  validates_uniqueness_of :friendly_id

  validates_format_of :friendly_id, :with => /\A[a-z0-9\-]+\z/

  belongs_to :user

  has_many :attendees
  belongs_to :category

  delegate :name, :to => :category, :prefix => true, :allow_nil => true

  has_many :event_groupships
  has_many :groups, :through => :event_groupships

  has_many :taggings
  has_many :tags, :through => :taggings

  has_attached_file :logo, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png",
                           :storage => :s3,
                           :s3_credentials => "#{Rails.root}/config/s3.yml",
                           :s3_host_name => "s3-ap-northeast-1.amazonaws.com"


  validates_attachment_content_type :logo, :content_type => /\Aimage\/.*\Z/

  include RankedModel
  ranks :row_order

  before_validation :setup_defaults

  before_save :check_remove_logo

  accepts_nested_attributes_for :attendees,
                                :allow_destroy => true,
                                :reject_if => :all_blank
  def to_param
    self.friendly_id
  end

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

  protected

  def check_remove_logo
   if self._remove_logo == "1"
      self.logo = nil
   end
  end

  def setup_defaults
    self.name.try(:strip!) # 把前後空白去除
    self.status ||= "draft"
    self.friendly_id ||= SecureRandom.hex(8)
  end

end
