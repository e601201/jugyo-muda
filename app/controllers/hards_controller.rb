class HardsController < ApplicationController

  def show;end

  def create
    @mon_work_sum = work_sum(params[:a_mon]) + work_sum(params[:b_mon]) + work_sum(params[:c_mon])
    @tue_work_sum = work_sum(params[:a_tue]) + work_sum(params[:b_tue]) + work_sum(params[:c_tue])
    @wed_work_sum = work_sum(params[:a_wed]) + work_sum(params[:b_wed]) + work_sum(params[:c_wed])
    @thu_work_sum = work_sum(params[:a_thu]) + work_sum(params[:b_thu]) + work_sum(params[:c_thu])
    @fri_work_sum = work_sum(params[:a_fri]) + work_sum(params[:b_fri]) + work_sum(params[:c_fri])
    @stu_work_sum = work_sum(params[:a_sat]) + work_sum(params[:b_sat]) + work_sum(params[:c_sat])
    @sun_work_sum = work_sum(params[:a_sun]) + work_sum(params[:b_sun]) + work_sum(params[:c_sun])
    @a_work_weeks = [ work_sum(params[:a_mon]),
                      work_sum(params[:a_tue]),
                      work_sum(params[:a_wed]),
                      work_sum(params[:a_thu]),
                      work_sum(params[:a_fri]),
                      work_sum(params[:a_sat]),
                      work_sum(params[:a_sun]),]
    @a_works_total =  work_sum(params[:a_mon])+
                      work_sum(params[:a_tue])+
                      work_sum(params[:a_wed])+
                      work_sum(params[:a_thu])+
                      work_sum(params[:a_fri])+
                      work_sum(params[:a_sat])+
                      work_sum(params[:a_sun])

    @b_work_weeks = [ work_sum(params[:b_mon]),
                      work_sum(params[:b_tue]),
                      work_sum(params[:b_wed]),
                      work_sum(params[:b_thu]),
                      work_sum(params[:b_fri]),
                      work_sum(params[:b_sat]),
                      work_sum(params[:b_sun]),]
    @b_works_total =  work_sum(params[:b_mon])+
                      work_sum(params[:b_tue])+
                      work_sum(params[:b_wed])+
                      work_sum(params[:b_thu])+
                      work_sum(params[:b_fri])+
                      work_sum(params[:b_sat])+
                      work_sum(params[:b_sun])

    @c_work_weeks = [ work_sum(params[:c_mon]),
                      work_sum(params[:c_tue]),
                      work_sum(params[:c_wed]),
                      work_sum(params[:c_thu]),
                      work_sum(params[:c_fri]),
                      work_sum(params[:c_sat]),
                      work_sum(params[:c_sun]),]
    @c_works_total =  work_sum(params[:c_mon])+
                      work_sum(params[:c_tue])+
                      work_sum(params[:c_wed])+
                      work_sum(params[:c_thu])+
                      work_sum(params[:c_fri])+
                      work_sum(params[:c_sat])+
                      work_sum(params[:c_sun])

    @sat_a = check_a_satisfaction
    @sat_b = check_b_satisfaction
    @sat_c = check_c_satisfaction
    @a_comments=["シフトの要望が通って嬉しい！今度の店長は結構まともね",
                 "まあ、こんなところね。",
                 "ちょっとふざけてるのかしら。。。",
                 "はぁ。。今度の店長は期待薄ね"]
    @b_comments=["話のわかる店長だわー",
                  "はあ。。。まあ今回は我慢するか。。。",
                  "なにこれ、印刷ミスか何か？",
                  "何だこれ！！仕事辞めよ！！"]
    @c_comments=["日曜が楽しみー!!テンアゲ↑↑",
                 "まあ、アリ寄りのナシ。。。",
                 "結構要望無視されてるんですけど。。。",
                 "なにこれ！！マジだるいんですけど！！"]
    @persons = [
      ["a",@a_works_total,7-@a_work_weeks.count(0),@sat_a,@a_comments],
      ["b",@b_works_total,7-@b_work_weeks.count(0),@sat_b,@b_comments],
      ["c",@c_works_total,7-@c_work_weeks.count(0),@sat_c,@c_comments]]
    @orner_work_time =orner_work_sum(@a_works_total,@b_works_total,@c_works_total)
    @persons_total_work_time = @a_works_total + @b_works_total + @c_works_total + @orner_work_time
    
    render :result
  end

  def result;end

  private

  def work_sum(object=nil)
    unless object.nil?
      sum = object[:end].to_i-object[:begin].to_i
      sum > 0 ? sum : 0 
    else
      return 0
    end
  end

  def orner_work_sum(a_sum,b_sum,c_sum)
    sum = 63 - (a_sum+b_sum+c_sum)
    sum > 0 ? sum : 0 
  end

  def check_a_satisfaction
    a_sat = 100
    a_sat -= 30 if @a_works_total < 29
    a_sat -= 20 if @a_works_total > 40
    a_sat -= 10 if @a_work_weeks[0] == 0
    a_sat -= 10 if @a_work_weeks[1] != 0
    a_sat -= 10 if @a_work_weeks[2] == 0
    a_sat -= 10 if @a_work_weeks[3] == 0
    a_sat -= 10 if @a_work_weeks[4] != 0
    a_sat -= 10 if @a_work_weeks[5] == 0
    a_sat -= 50 if @a_work_weeks[6] != 0
    a_sat -= 50 if params[:a_sat] != nil && params[:a_sat][:end].to_i > 14
    return a_sat
  end
  def check_b_satisfaction
    b_sat = 100
    b_sat -= 30 if @b_works_total > 40
    b_sat -= 20 if @b_works_total > 30
    b_sat -= 20 if @b_works_total < 15
    b_sat -= 60 if @b_works_total < 5
    b_sat -= 40 if 7-@b_work_weeks.count(0) > 3
    b_sat -= 30 if params[:b_tue] != nil && params[:b_tue][:begin].to_i < 15
    b_sat -= 30 if params[:b_fri] != nil && params[:b_fri][:begin].to_i < 15
    b_sat -= 30 if params[:b_sun] != nil && params[:b_sun][:begin].to_i < 15
    b_sat -= 30 if work_sum(params[:b_sat])>0 && work_sum(params[:b_sat])>0
    return b_sat
  end
  def check_c_satisfaction
    c_sat = 100
    c_sat -= 50 if @c_works_total > 30
    c_sat -= 20 if @c_works_total > 20
    c_sat -= 5 if @c_works_total > 15
    c_sat -= 5 if @c_works_total < 5
    c_sat -= 50 if @c_works_total == 0
    c_sat -= 30 if @c_works_total == 1
    c_sat -= 20 if @c_works_total == 2
    c_sat -= 5*@c_work_weeks.count(5)
    c_sat -= 15*@c_work_weeks.count(6)
    c_sat -= 20*@c_work_weeks.count(7)
    c_sat -= 25*@c_work_weeks.count(8)
    c_sat -= 30*@c_work_weeks.count(9)
    c_sat -= 30 if work_sum(params[:c_sat]) < 4
    c_sat -= 60 if work_sum(params[:c_sun]) > 0
    return c_sat
  end
end

