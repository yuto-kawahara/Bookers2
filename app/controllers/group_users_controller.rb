class GroupUsersController < ApplicationController
  def create
    group = Group.find(params[:group_id])
    group_user = group.group_users.new(user_id: current_user.id)
    group_user.save
    redirect_to groups_path
  end

  def destroy
    group = Group.find(params[:group_id])
    group_user = group.group_users.find_by(user_id: current_user.id)
    group_user.destroy
    redirect_to groups_path
  end
end
