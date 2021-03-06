class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :signed_in?, :correct_user?, :admin?, :liked?, :liked
  before_action :get_categories

  def current_user
  	@current_user ||= User.find_by_remember_token(cookies[:remember_token]) if cookies[:remember_token]
  end

  def correct_user?(user)
    user == current_user
  end

  def signed_in?
  	!!current_user
  end

  def require_user
  	unless signed_in?
  		flash[:error] = t('flash.user.signin')
  		redirect_to '/signin'
  	end
  end

  def get_categories
    @categories = Category.all
  end

  def admin_user
    unless admin?
      flash[:error] = t('flash.user.admin')
      redirect_to root_path
    end
  end

  def admin?
    signed_in? && current_user.admin?
  end

  def liked?(type)
    @like = Like.find_by(likeable: type, user: current_user) 
  end

  def liked(type)
    @like = Like.find_by(likeable: type, user: current_user)
    if @like
      return @like.like
    else
      return false
    end
  end  
end
