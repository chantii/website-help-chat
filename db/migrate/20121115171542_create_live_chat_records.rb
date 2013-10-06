class CreateLiveChatRecords < ActiveRecord::Migration
  def change
    create_table :live_chat_records do |t|
      t.string :userid
      t.text :message
      t.string :fromorto
      t.string :subdomain

      t.timestamps
    end
  end
end
