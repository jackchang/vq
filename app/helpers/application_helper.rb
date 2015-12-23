module ApplicationHelper

  def get_share_token level
     "Level:#{level}".tr(VRecord::DEC, VRecord::ENC)
  end

end
