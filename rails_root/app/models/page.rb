class Page < ActiveRecord::Base
    validates_presence_of :url, :html, :size
    belongs_to :task
    has_many :comments
end
