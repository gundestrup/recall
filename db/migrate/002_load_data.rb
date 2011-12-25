require 'active_record/fixtures'
class LoadData < ActiveRecord::Migration
  def self.up
      #Creating an admin user
      #Please change your email, and use the "forgot password" function for create a password
      @user = User.new
      @user.login = 'Admin'
      @user.name = 'Administrator'
      @user.title = 'admin title'
      @user.email = 'admin@email.now'
      @user.admin = 'true'
      @user.crypted_password = 'some cryped password'
      @user.salt = 'some salt'
      @user.activated_at = Time.now
      @user.save
  end

  def self.down
      User.delete_all
      Category.delete_all
      Pile.delete_all
      Card.delete_all
  end
end