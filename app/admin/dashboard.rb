ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    div class: "blank_slate_container", id: "dashboard_default_message" do
      span class: "blank_slate" do
        span I18n.t("active_admin.dashboard_welcome.welcome")
      end
    end

    columns do
      column do
        panel "Recent Posts" do
          ul do
            Post.includes(:comments).order("created_at DESC").limit(6).map do |post|
              li link_to(post.text, admin_post_path(post))
            end
          end
        end
      end

      column do
        panel "Info" do
          para "Dear #{current_user.name}, Welcome to ActiveAdmin."
        end
      end
    end
  end
end
