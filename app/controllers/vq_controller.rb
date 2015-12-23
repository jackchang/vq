class VqController < ApplicationController
  def index
    if params[:ref].present?
      ref = params[:ref].tr(VRecord::ENC, VRecord::DEC).split(':')[1]
      if ref.is_number?
        @level = ref.to_i 
        @record = VRecord.find_by_level(@level)
        @position = find_position(@level)
        @groups = group_percentage
      end
    end 
  end

  def update
    @level = params[:id]
    @record = VRecord.find_by_level(@level)
    @record.count += 1
    @record.save!
    @position = find_position(params[:id])
    @groups = group_percentage
  end


private
  def record_params
    params.require(:v_record).permit(:count)
  end

  def find_position level
    total = VRecord.pluck(:count).sum
    pos = VRecord.where('level > ?', level.to_i).pluck(:count).sum
    percent = (pos/total.to_f)* 100
    pos = pos==0 ? 1 : pos
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
    VRecord.all.group_by(&:group).collect{|k,v| p[k] = v.sum(&:count)}  
    max = p.max_by{|k,v| v}[1]
    p.each{|k,v| p[k] = [v, v/max.to_f * 90]}.sort_by{|k,v| k}
  end

end
