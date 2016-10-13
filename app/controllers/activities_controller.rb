class ActivitiesController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]

  def create
    @activity = current_user.activities.build activity_params
    if @activity.save
      flash[:success] = t "activity.created"
    else
      flash[:danger] = t "activity.create_error"
    end
    redirect_to root_url
  end

  def destroy
    @activity = Activity.find_by id: params[:id]
    if @activity.destroy
      flash[:success] = t "activity.deleted"
    else
      flash[:danger] = t "activity.delete_error"
    end
    redirect_to root_url
  end

  private
  def activity_params
    params.require(:activity).permit :action_type, :target_id
  end
end
