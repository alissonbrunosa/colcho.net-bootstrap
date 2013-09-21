module UsersHelper

  def no_user_signed_in?
    !user_signed_in?
  end
end