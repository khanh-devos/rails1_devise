module HomeHelper

    def getsubs
      return @subs =  User.all.to_a.sort_by{|e| e.id}.map {|u| myEncode(u.id) }
    end


    

    def myEncode(num)
      srand 101
      return "#{rand(100).to_s}ds35a#{rand(100).to_s}v93r4g6jk#{rand(100).to_s}k"+num.to_s+"wrdi98dtkh4"+rand(1000).to_s
    end
end
