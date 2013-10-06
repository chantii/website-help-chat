class LiveChatRecord < ActiveRecord::Base
  attr_accessible :fromorto, :message, :subdomain, :userid
end
