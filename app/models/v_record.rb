class VRecord < ActiveRecord::Base
  DEC = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789:-"
  ENC = "5KuoPRAJwypHnfQvb1C4dI:he0BFG3SlVLZXzxa8Ec-isDk7M9rtgU2TNOYj6Wqm"
  GROUP = {1 => "Buzzed?", 2 => "Need help", 3 => "Try harder", 4 => "Above average", 5 => "Almost there", 6 => "Master"}
end
