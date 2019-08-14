 

module Enumerable

    def my_each
        for x in 0...self.length
            yield(self[x])
            x += 1
        end
    end

    def my_each_indexs
        for x in 0...self.length
            yield(self[x],x)
            x += 1
        end
    end

    def my_select
        select_arr = []
        self.my_each{|x| select_arr << x if yield(x)}
        select_arr
    end

    def my_all?
        self.my_each do |x|
        return true unless block_given?
        return false unless yield(x)
        end
    end
    
    def my_any?
        m = false
        self.my_each do |x|
            (m = true) if yield(x)
        end
        m
    end

    def my_none?
        num = true
        self.my_each{ |x| num = false if yield(x) }
        num
    end

    def my_count
        c = 0
        self.my_each do |x|
            block_given? ? (c += 1 if yield(x)) : c += 1
        end
        c
    end

    def my_map
        array = []
        self.my_each do |x|
            yield(x) ? (array << true) : (array << false)
        end
        array
    end
        
    def my_inject (val = self[0]) 
        object = val
        self.my_each do |x|
            object = yield(val,x)
            val = object 
        end
        object
    end

end

arr = [5,12,9,2,3,60,76,100]    
val = Proc.new {|x| x%2 == 0}

p arr.my_any?(&val)

p arr.any?(&val)

puts "my_count no argument: " + arr.my_count.to_s

puts "my_count with block: " + arr.my_count{val }.to_s

puts "No argument: " + arr.my_inject{|x,y| x + y}.to_s 