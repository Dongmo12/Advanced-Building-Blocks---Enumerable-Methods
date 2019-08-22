 

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
        self.my_each do |x|
          return true if yield(x)
        end
        false
    end
    

    def my_none?
        num = true
        self.my_each{ |x| num = false if yield(x) }
        num
    end

    def my_count num = nil
        count = 0
          if num 
            self.my_each {|elem| count += 1 if elem == num}
          elsif block_given?
            self.my_each {|elem| count += 1 if yield(elem)}
          else
            count = self.length
          end 
        count
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


arr = [5,12,9,2,3,60,76,100] 

p "Test 1==> #{arr.my_count} "
p "Test 2==> #{ arr.my_count(2)} "
p "Test 3==> #{arr.my_count {|num| num < 5}}"

  p arr.any? {|num| num.is_a? Integer}
  p arr.any? {|num| num.is_a? String}
  p arr.my_any? {|num| num.is_a? Integer}
  p arr.my_any? {|num| num.is_a? String}