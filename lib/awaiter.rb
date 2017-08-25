require 'awaiter/version'

module Awaiter
  class ::Object
    def await(task)
      task.join.value
    end

    def wait(*tasks)
      tasks.map(&:join).map(&:value)
    end
  end

  def self.included(klass)
    klass.extend(ClassMethods)
  end

  module ClassMethods
    def async(*method_names)
      method_names.each do |m|
        proxy = Module.new do
          define_method(m) do |*args|
            Thread.new { super *args }
          end
        end
        self.prepend proxy
      end
    end
  end
end
