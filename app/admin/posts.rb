ActiveAdmin.register Post do

  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  config.per_page = 10
  permit_params do
    permitted = [:text, :user_id]
    permitted << :other if params[:action] == 'create' && current_user.admin?
    permitted
  end

end
