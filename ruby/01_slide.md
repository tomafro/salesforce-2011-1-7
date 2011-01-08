!SLIDE
# So let's look at ruby... #

!SLIDE bullets incremental
# Ruby is Interpreted #

* There is no compilation between writing and running code.

* I can enter ruby and run it immediately

!SLIDE bullets incremental
# Ruby is Object Oriented #

* Everything in ruby is an object.

!SLIDE

## Some example objects ##

    @@@ ruby
    1
    1.0
    "1"
    []
    {}
    true
    nil
    String

!SLIDE

## ...with their classes ##

    @@@ ruby
    1.class      # => FixNum
    1.0.class    # => Float
    "1".class    # => String
    [].class     # => Array
    {}.class     # => Hash
    true.class   # => TrueClass
    nil.class    # => NilClass
    String.class # => Class

!SLIDE bullets incremental

# Functional #

* Every statement returns a value

* though that value may be nil


!SLIDE

    @@@ ruby
    1
    # => 1

!SLIDE

    @@@ ruby
    puts "Tom"
    # => nil

!SLIDE

    @@@ ruby
    def double(x)
      x * 2
    end
    # => nil

!SLIDE
    @@@ ruby
    def double(x)
      x * 2
    end
    # => nil

    double(4)
    # => 8

!SLIDE

# Dynamically Typed #

## Values have types, but variables don't ##

!SLIDE 

    @@@ ruby
    a = "Tom"
    a.class # => String
    a = [1, 2, 3, 4]
    a.class # => Array

!SLIDE

# Duck typing #

## The semantics of an object are defined by the methods it responds to, NOT its type or class ##

!SLIDE

# Duck typing #

## If it walks like a duck and quacks like a duck, it's a duck! ##

!SLIDE

## Contrived example ##

    @@@ ruby
    class Camera
      def shoot
        puts "Flash!"
      end
    end

    class Gun
      def shoot
        puts "Bang!"
      end
    end
    
    def aim(object)
      object.shoot
    end

!SLIDE

# Blocks/Closures #

## Similar to anonymous functions ##

!SLIDE
  
## Count up to 5 ##

    @@@ ruby
    [1, 2, 3, 4, 5].each do |n|
      puts n
    end
    
    1
    2
    3
    4
    5

!SLIDE

## Calculate the first 10 squares ##

    @@@ ruby
    1.upto(10).map do |n|
      n * n
    end

    # => [1, 4, 9, 16, 25, 36, 49, 64, 81, 100]

!SLIDE

## Sum the first 100 integers ##

    @@@ ruby
    1.upto(100).inject do |x, n|
      x + n
    end

    # => 5050

!SLIDE

## In ruby, for loops are hardly ever used

!SLIDE

# Dynamic #

## Code can modify itself on the fly ##

!SLIDE

    @@@ ruby

    "string".quack
    # => NoMethodError: undefined method `quack' for "string":String

!SLIDE

    @@@ ruby

    String.module_eval do
      def quack
        puts "Quack Quack Quack!"
      end
    end
  
    "string".quack
    
    # => "Quack Quack Quack!"
    
!SLIDE bullets incremental

# All of this leads to a language that is.. #
    
* Expressive

* Concise

* Flexible

* Slow

* Dangerous?

!SLIDE bullets incremental

# Is ruby really slow? #

* Yes, but it often doesn't matter.

* Most apps are slow because they are badly designed, not because of the language they run on.

!SLIDE bullets incremental

# Is ruby really dangerous? #

* Yes, but not if we write tests.

* The ruby community is very big on automated unit, functional and integration testing.