# encoding: utf-8
module EnumAttr
  module Mixin

    def enum_attr(attr, enums)
      raise "The secone param must be a array!" unless enums.is_a? Array

      if self.superclass == Object
        attr_accessor attr.to_sym
      end

      attr = attr.to_s

      enums.each do |enum|
        const_set("#{attr.upcase}_#{enum[2].upcase}", enum[1] )

        class_eval(%Q{
          def #{attr}_#{enum[2]}?
            #{attr} == #{enum[1]}
          end
        })

      end # end: enums.each

      self.class_eval(%Q{

ENUMS_#{attr.upcase} = enums.collect{|item| [item[0], item[1]]}

def self.#{attr}_name_by(arg)
  ENUMS_#{attr.upcase}.find{|option| option[1] == arg }[0] rescue ""
end

def #{attr}_name
  ENUMS_#{attr.upcase}.find{|option| option[1] == #{attr}}[0] rescue "" unless #{attr}.nil?
end

})
    end


  end
end

Object.send :extend, EnumAttr::Mixin