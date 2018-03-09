class Users::ConfirmationsController < Devise::ConfirmationsController
  def show
    super
    @confirmation = resource # Needed for Merit / Must be AFTER the super
  end
end