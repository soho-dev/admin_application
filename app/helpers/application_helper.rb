module ApplicationHelper

  def application_status_class
    {"pending" => "warning", "approved" => "success", "rejected" => "danger"}
  end
end
