module Admin::PermissionsHelper
  def permissions
    {
      "view" => "View",
      "create tickets" => "Create Tickets",
      "delete tickets" => "Delete Tickets"
    }
  end
end
