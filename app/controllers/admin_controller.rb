class AdminController < ApplicationController
  before_filter :login_required, :admin
  
  def index    	
           @path ="#{RAILS_ROOT}/log"
            @total_piles = Pile.count
            @total_cards = Card.count
            @total_users = User.count
            @total_categories = Category.count
           if !File.exist?(@path+"/development.log")
            f = File.new(@path+"/development.log", "w+")
                puts f.gets
                f.close
           end
           if !File.exist?(@path+"/fastcgi.crash.log")
              c = File.new(@path+"/fastcgi.crash.log", "w+")
                puts c.gets
               c.close
           end
           if !File.exist?(@path+"/production.log")
                p = File.new(@path+"/production.log", "w+")
                puts p.gets
                p.close
           end
            @development = File.open(@path+"/development.log", "r")
            @production = File.open(@path+"/production.log", "r")
            @fastcgi = File.open(@path+"/fastcgi.crash.log", "r")
        
      end


	def list        
		    @users = User.find(:all)    	
    end

  def user      
      if (params[:id]) == nil
          redirect_to :action => 'list'
          flash[:notice] = 'No user ID givin, please try again'
      else
        @user = User.find(params[:id])
      end
  end

   protected

def admin
     if current_user.admin?
     else
       flash[:error] = 'Sorry you are not and admin'
       redirect_to :controller => "accounts", :action => 'user'
     end
end

end
