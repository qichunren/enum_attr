module EnumAttr
  module Mixin
    # for model Contract:
    # enum_attr :status, [['新建', 0, "origin"], ['整理中', 1, "collecting"], ["已上传", 2, "uploaded"]]
    # It generates these code for you:
    # # status const                                     
    # STATUS_ORIGIN = 0; STATUS_COLLECTING = 2; STATUS_UPLOADED = 3       
    #
    # # scopes for column status
    # scope :status_origin, where("status=0")
    # scope :status_collection, where("status=1")
    # scope :status_uploaded, where("status=2")    
    #
    # # for view select
    # ENUMS_STATUS = [["新建", 0], ["整理中", 1], ["已上传", 2]]                    
    
    # # validates
    # validates_inclusion_of "status", :in => [1, 2, 3], :allow_nil => true
    #   
    # # column_name instant method
    # def status_origin
    #   # return status name by it's status value
    # end
    #
    def enum_attr(attr, enums)
      raise "The secone param must be a array!" unless enums.is_a? Array
      
      attr = attr.to_s
      
      enums.each do |enum|
        const_set("#{attr.upcase}_#{enum[2].upcase}", enum[1] )
        
        # TODO: how to judge if there is active_record 3 gem here?
        scope "#{attr}_#{enum[2]}".to_sym, where("#{attr}=#{enum[1]}") 
        
        # TODO define_method such as "stauts_origin?"
        define_method "#{attr}_#{enum}?" do
          attr == enum[1] 
        end 
        
      end # end: enums.each
      
      self.class_eval(%Q{

ENUMS_#{attr.upcase} = enums.collect{|item| [item[0], item[1]]}

validates_inclusion_of attr, :in => enums.map{|e| e[1].to_i}, :allow_nil => true

def #{attr}_name
  ENUMS_#{attr.upcase}.find{|option| option[1] == #{attr}}[0] unless #{attr}.nil?
end
        })
    end
  end
end

Object.send :include, EnumAttr::Mixin