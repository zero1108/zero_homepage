class User < ActiveRecord::Base
  has_many :comments
  validates_presence_of :name
end
