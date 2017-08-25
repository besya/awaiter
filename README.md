# Awaiter

Using ruby Threads as async/await

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'awaiter'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install awaiter

## Usage

```ruby
require 'awaiter'

class MyClass
  include Awaiter
  async :first, :second
  
  def first
    p 'First stared'
    sleep(1)
    p 'First finished'
    'first result'
  end
  
  def second
    p 'Second stared'
    sleep(1)
    first_result = await first
    p 'Second finished'
    'second result with ' + first_result
  end
end
  

my = MyClass.new

p await my.first
# "First stared"
# "First finished"
# "first result"

p await my.second
# "Second stared"
# "First stared"
# "First finished"
# "Second finished"
# "second result with first result"


```

```ruby
require 'awaiter'

class MyClass
  include Awaiter
  async :first
  
  def first
    p 'First stared'
    sleep(2)
    p 'First finished'
    'first result'
  end  
end
  

my = MyClass.new
t1 = my.first
sleep(1)
p 'Main thread'
r1 = await t1
p r1

# "First stared"
# "Main thread"
# "First finished"
# "first result"

```

```ruby
require 'awaiter'

class MyClass
  include Awaiter
  async :first, :second
  
  def first
    sleep(4)
    'first result'
  end  

  def second
    sleep(2)
    'second result'
  end  
end

my = MyClass.new

r1, r2 = wait(my.first, my.second)

p r1
p r2

# "first result"
# "second result"


```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/besya/awaiter. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Awaiter project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/besya/awaiter/blob/master/CODE_OF_CONDUCT.md).
