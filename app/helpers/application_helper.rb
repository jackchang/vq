module ApplicationHelper

  DEC = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789:-"
  ENC = "5KuoPRAJwypHnfQvb1C4dI:he0BFG3SlVLZXzxa8Ec-isDk7M9rtgU2TNOYj6Wqm"

  def get_share_token level
     "Level:#{level}".tr(DEC, ENC)
  end

  def decode_token code
    code.tr(ENC, DEC).split(':')[1]
  end
end
