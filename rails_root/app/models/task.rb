class Task < ActiveRecord::Base
  has_many :pages
  validates_presence_of :seed_url, :number
end
