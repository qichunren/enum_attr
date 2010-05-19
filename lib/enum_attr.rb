module EnumAttr
  module Mixin
    # for model Contract:
    # enum_attr :contract_type, [['拍品合同', '0', "auction"], ['商品合同', '1', "goods"], ["台湾合同", '2', "taiwan"]]
    #
    def enum_attr(attr, enums)
      attr = attr.to_s
      enums.each do |enum|
        const_set("#{attr.upcase}_#{enum[2].upcase}", enum[1] )
      end
      self.class_eval(%Q{

ENUMS_#{attr.upcase} = enums.collect{|item| [item[0], item[1]]}
validates_inclusion_of attr, :in => enums.map{|e| e[1]}, :allow_nil => true
def #{attr}_name
  ENUMS_#{attr.upcase}.find{|option| option[1] == #{attr}}[0] unless #{attr}.nil?
end
        })
    end
  end
end
