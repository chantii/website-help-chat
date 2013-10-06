class ChatsController < ApplicationController
  def room
    if (cookies[:userid].blank?)
    cookies[:userid] = {
      :value => Time.now.to_i -  9090,
      :expires => 6.months.from_now          
    }           
   end 
  end
  def oldchat
   @oldchats = LiveChatRecord.where("userid = ? AND subdomain = ?",  params[:userid],  params[:subdomain])
    respond_to do |format|
      format.html  # admin.html.erb
      format.json  { render :json => @oldchats }
    end
  end
  def admin
    if (cookies[:userid].blank?)
    cookies[:userid] = {
      :value => "admin",
      :expires => 6.months.from_now          
    }
    end

    @chats = LiveChatRecord.select(:userid).where("subdomain = ?",params[:subdomain]).uniq
    @bchats = LiveChatRecord.where("fromorto = 'broadcast' AND subdomain = ?",params[:subdomain])
	
    respond_to do |format|
      format.html  # admin.html.erb
      format.json  { render :json => @chats }
    end


  end
  def new_message  
    
      t = LiveChatRecord.new
      t.message = params[:message]
      t.subdomain = params[:subdomain]
	
    if (params[:from] == "admin")
      if (params[:to] == "broadcast")
	@channel = "/messages/private/#{params[:subdomain]}/broadcast"
        @message = { :username => params[:from], :msg => params[:message] }
        t.fromorto = "broadcast"
        t.userid = params[:to]
      else
      	@channel = "/messages/private/#{params[:subdomain]}/#{params[:to]}"
      	@message = { :username => params[:from], :msg => params[:message] }
        t.fromorto = "to"
        t.userid = params[:to]
      end 	
    else
	logger.info("From user to admin")
        @channel = "/messages/private/#{params[:subdomain]}/admin"
        @message = { :username => params[:from], :msg => params[:message] }
        t.userid = params[:from]
        t.fromorto = "from"
    end
        t.save
  respond_to do |f|
    f.js
  end
end
end
