class VqController < ApplicationController
  include ApplicationHelper
  
  def index
    if params[:ref].present?
      ref = decode_token params[:ref]
      if ref.is_number?
        @ref = ref
        @level = ref.to_i
        @record = VRecord.find_by_level(@level)
        @position = find_position(@level)
        @groups = group_percentage
      end
    end 
  end

  def update
    @level = params[:id].to_i
    @record = VRecord.find_by_level(@level)
    @record.count += 1
    @record.save!
    @position = find_position(@level)
    @groups = group_percentage
  end

  def play
  end

  def stats
    @groups = group_percentage
    @position = [0, 9, 0]
  end

private

  def find_position level
    total = VRecord.pluck(:count).sum
    pos = VRecord.where('level > ?', level.to_i).pluck(:count).sum + 1
    percent = ((pos-1)/total.to_f)* 100
    group = case level.to_i
      when 0..9 then 1
      when 10..19 then 2
      when 20..29 then 3
      when 30..39 then 4
      when 40..49 then 5
      else 6
    end
    [pos,group,percent]
  end

  def group_percentage
    p = {}
    records = VRecord.all.group_by(&:group)
    records.each{|k,v| p[k] = [v.sum(&:count), v.max_by(&:updated_at).updated_at]}  
    max = p.max_by{|k,v| v[0]}[1][0]
    p.each{|k,v| p[k] = [v, v[0]/max.to_f * 90].flatten}.sort_by{|k,v| k}
  end

end
