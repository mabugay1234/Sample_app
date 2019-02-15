class MicropostsController < ApplicationController
  before_action :logged_in_user, only: %i(create destroy)
  before_action :correct_user, only: %i(destroy)

  def create
    @micropost = current_user.microposts.build micropost_params

    if @micropost.save
      created
    else
      not_found
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = t "microposts.destroy.success"
    redirect_to request.referrer || root_url
  rescue StandardError
    flash[:danger] = t "microposts.destroy.danger"
    redirect_to users_path
  end

  private

  def created
    flash[:success] = t "microposts.create.success"
    redirect_to root_url
  end

  def not_found
    @feed_items = current_user.microposts.order_desc.page(params[:page])
                              .per Settings.page_limit
    flash[:danger] = t "microposts.create.danger"
    render "static_pages/home"
  end

  def micropost_params
    params.require(:micropost).permit :content, :picture
  end

  def correct_user
    @micropost = current_user.microposts.find_by id: params[:id]

    return if @micropost
    flash[:danger] = t "microposts.micropost.destroy.correct_danger"
    redirect_to root_url
  end
end
