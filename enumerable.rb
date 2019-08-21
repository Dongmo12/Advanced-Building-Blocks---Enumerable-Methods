 

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
        initial = false
        self.my_each {|elem| yield(elem) ? initial = true : initial = false }
        initial
    end
    
    def my_any?
        self.my_each do |e|
          return true if yield(e)
        end
        true
    end
    

    def my_none?
        num = true
        self.my_each{ |x| num = false if yield(x) }
        num
    end

    def my_count(obj = nil)
        count = 0
        my_each do |e|
          count += 1
          return count if obj && count == obj
          return count if block_given? && yield(e)
        end
        return count unless block_given?
    end

    def my_map
        array = []
        self.my_each do |x|
            yield(x) ? (array << true) : (array << false)
        end
        array
    end

    def my_inject 
        start = nil
        start == nil ? result = self[0] : result = start
    
        for i in 1..self.length - 1 
          result = yield(result,self[i])
        end 
        result
    end
    

        
    def multiply_els(arr)

        arr.my_inject { |memo, e| memo * e }
  
    end

end
=begin
arr = [5,12,9,2,3,60,76,100]    
val = Proc.new {|x| x%2 == 0}

p arr.my_any?(&val)

p arr.any?(&val)

puts "my_count no argument: " + arr.my_count.to_s

puts "my_count with block: " + arr.my_count{val }.to_s

puts "No argument: " + arr.my_inject{|x,y| x + y}.to_s 
=end

