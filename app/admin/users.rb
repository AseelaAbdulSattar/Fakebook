ActiveAdmin.register User do
  permit_params :name, :state, :email
  config.per_page = 10

  batch_action :Activate do |ids|
    batch_action_collection.find(ids).each do |user|
      if(user.state == 'inactive')
        user.update(state: 'active')
      end
    end
    redirect_to collection_path, alert: 'The users have been Activated.'
  end
  batch_action :Deactivate do |ids|
    batch_action_collection.find(ids).each do |user|
      if(user.state == 'active')
        user.update(state: 'inactive')
      end
    end
    redirect_to collection_path, alert: 'The users have been Deactivated.'
  end

  filter :friends
  filter :email, filters: [:contains, :equals, :starts_with, :ends_with]
  filter :name, filters: [:contains, :equals, :starts_with, :ends_with]

  controller do
    def show
      User.where(id: params[:id]).first!
    end
  end

  index do
    selectable_column
    column "Id", :id
    column "Name", :name
    column "Email", :email
    column "Friends", :friends
    column "Friend Request Sent", :friendships_requests_sent
    column "Friend Requests Recieved", :friendships_requests_received
    actions
  end
end
