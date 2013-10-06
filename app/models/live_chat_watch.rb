class LiveChatWatch < ActiveRecord::Base
  attr_accessible :fromuser, :message, :touser
end
