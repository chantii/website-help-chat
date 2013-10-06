class LiveChat < ActiveRecord::Base
  attr_accessible :from, :message, :to
end
