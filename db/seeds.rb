# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

def group(level)
  case level
    when 0..9 then [1,2] 
    when 10..19 then [2, 3] 
    when 20..29 then [3, 25]
    when 30..39 then [4, 30] 
    when 40..49 then [5, 1] 
    else [6, 1]
  end
end

(0..50).each do |l|
  VRecord.create(level: l, count: group(l)[1], group: group(l)[0])
end
