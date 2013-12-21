module ApplicationHelper
  def stylesheet_namespace
    controller_namespace = controller.controller_path.gsub(/\//) { "_" }
    "#{controller_namespace} #{controller.action_name}"
  end
end
