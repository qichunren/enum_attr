# encoding: utf-8 
require 'enum_attr_base'
require 'active_record'  

module EnumAttr
  module MixinForActiveRecord 
    extend EnumAttr::Mixin
    
    def enum_attr(attr, enums)
      super(attr, enums)
      enums.each do |enum|      
        scope "#{attr}_#{enum[2]}".to_sym, where("#{attr}=#{enum[1]}")
      end # end: enums.each
      
      self.class_eval(%Q{
validates_inclusion_of attr, :in => enums.map{|e| e[1].to_i}, :allow_nil => true
def attr
  read_attribute(attr.to_sym)
end

def attr=(value)
  write_attribute(attr.to_sym, value)
end
})

    end # end def
  end
end

::ActiveRecord::Base.send :extend, EnumAttr::MixinForActiveRecord