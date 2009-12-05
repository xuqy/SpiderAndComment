class Page < ActiveRecord::Base
    validates_presence_of :url, :html, :size
    has_many :comments
end
