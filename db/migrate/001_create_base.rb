class CreateBase < ActiveRecord::Migration
  def self.up
    #Sessions
        create_table :sessions do |t|
          t.column      :session_id,                  :string
          t.column      :data,                        :text
          t.column      :updated_at,                  :datetime
        end
        add_index       :sessions, :session_id
        add_index       :sessions, :updated_at

    #Create users
    	  create_table "users", :force => true do |t|
    	    t.column      :login,                       :string
          t.column      :email,                       :string
          t.column 	    :title,								        :string
          t.column      :name,								        :string
          t.column 	    :pile_last,							      :integer
          t.column 	    :last_visit,						      :datetime
          t.column 	    :admin,								        :boolean, :default => false
          t.column      :crypted_password,            :string, :limit => 40
          t.column      :salt,                        :string, :limit => 40
          t.column      :created_at,                  :datetime
          t.column      :updated_at,                  :datetime
          t.column      :remember_token,              :string
          t.column      :remember_token_expires_at,   :datetime
          t.column      :activation_code,             :string, :limit => 40
          t.column      :activated_at,                :datetime
          t.column      :password_reset_code,         :string, :limit => 40
        end
        add_index       :users, :login

    #Create piles
        create_table "piles", :force => true do |t|
          t.column	    :name,					              :string
          t.column	    :user_id,				              :integer
          t.column	    :category_id,			            :Integer
          t.column      :created_at,                  :datetime
          t.column      :updated_at,                  :datetime
          t.column      :popularity,                  :integer, :default => 1
        end
        add_index       :piles, :name

    #Create categories
      create_table "categories_types", :force => true do |t|
    	  t.column	      :category_type,	  				    :string
    	end

    #Create categories
    	  create_table "categories", :force => true do |t|
    		  t.column	    :name,							          :string
    		  t.column	    :categories_types_id,			    :integer
        end
        add_index       :categories, :name


    #Create cards
        create_table "cards", :force => true do |t|
          t.column    :head,                            :string
          t.column    :front,                           :text
          t.column    :back,                            :text
          t.column    :note,                            :text
          t.column    :user_id,                         :integer
          t.column    :pile_id,                         :integer
          t.column    :created_at,                      :datetime
    		  t.column    :updated_at,                      :datetime
    	    t.column    :position,                        :integer
        end
        add_index     :cards, :head

  end

  def self.down
  	drop_table      :users
  	drop_table      :sessions
    drop_table      :piles
    drop_table	    :cards
  	drop_table	    :categories
  	drop_table	    :categories_types
	end

end