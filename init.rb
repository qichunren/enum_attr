Bundler.require(:default)

require File.join(File.dirname(__FILE__), "lib", "enum_attr") 

Object.send :include, EnumAttr::Mixin
