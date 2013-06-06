module UsersHelper
  def temporary_password
    return (0...16).map{ ('a'..'z').to_a[rand(26)] }.join
  end
end
