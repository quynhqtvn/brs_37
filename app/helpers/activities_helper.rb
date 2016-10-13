module ActivitiesHelper
  def add_activity  action_type, target_id
    @activity = current_user.activities.build action_type: action_type,
      target_id: target_id
    @activity.save
  end

  def remove_activity action_type, target_id
    @activity = current_user.activities.find_by action_type: Activity.action_types[action_type],
      target_id: target_id
    @activity.destroy
  end
end
