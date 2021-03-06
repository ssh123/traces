class Post < ActiveRecord::Base
  has_many :comments, :dependent => :destroy
  belongs_to :admin
  has_and_belongs_to_many :terms
  
  validates_presence_of :title, :content
  #validates_uniqueness_of :slug
  
  scope :created, lambda { where("created_at <= ? ", Time.zone.now) }
  scope :recent, created.order("created_at DESC LIMIT 5")
  
  def tag_attributes=(tag_attributes)
    tag_attributes.split(',').each do |attributes|
      t_attributes = Hash.new
      t_attributes[:looking] = "tag"
      t_attributes[:name] = attributes
      terms.build(t_attributes)
    end
  end
  
  def tags_to_add=(tags_to_add)
    tags_to_add.each do |tag_id|
      tag = Term.find(tag_id)
      terms << tag
    end    
  end
  
  #def to_param
    #{}"#{title.gsub(/[^a-z0-9]+/i, '-')}"
    #{}"#{id}-#{title.parameterize}"
    #{}"#{id}-#{slug}"
  #end
  
end
