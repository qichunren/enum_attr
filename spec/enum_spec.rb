# encoding: utf-8
require File.dirname(__FILE__) + "/spec_helper"

class Contract < ActiveRecord::Base
  enum_attr :status, [['新建', 0, "origin"], ['整理中', 1, "collecting"], ["已上传", 2, "uploaded"]]
end

describe "EnumAttr" do
  after(:each) do
    Contract.delete_all
  end

  it "should get superclass" do
    Contract.superclass.should == ActiveRecord::Base
  end

  it "should get const" do
    Contract::STATUS_ORIGIN.should == 0
    Contract::STATUS_COLLECTING.should == 1
    Contract::STATUS_UPLOADED.should == 2
  end

  it "should get scope" do
    Contract.should respond_to(:status_origin)
    Contract.should respond_to(:status_collecting)
    Contract.should respond_to(:status_uploaded)
    Contract.create!(:name => "contract 1", :status => 0)
    Contract.create!(:name => "contract 2", :status => 1)
    Contract.create!(:name => "contract 3", :status => 2)
    Contract.create!(:name => "contract 4", :status => 1)
    Contract.status_origin.first.name.should == "contract 1"
    Contract.status_collecting.count.should == 2
  end

  it "should return origanl value if not matched" do
        contract_with_error_status = Contract.new(:name => "contract with no correct status value", :status => 100000)
        contract_with_error_status.save(:validate => false)
        Contract.first.status_name.should == ""
  end

  it "should get status_#name#?" do
    contract = Contract.create(:name => "测试合同", :status => 0)
    contract.should respond_to(:status_origin?)
    contract.should respond_to(:status_collecting?)
    contract.should respond_to(:status_uploaded?)
    contract.status_origin?.should == true
    contract.status_uploaded?.should == false
  end

  it "should get const array" do
    Contract::ENUMS_STATUS.should == [['新建', 0], ['整理中', 1], ["已上传", 2]]
  end

  it "should get status_name" do
    contract = Contract.create(:name => "测试合同", :status => 0)
    contract.status_name.should == "新建"
  end

  it "should get status_name_by" do
    Contract.status_name_by(0).should == "新建"
    Contract.status_name_by(1).should == "整理中"
    Contract.status_name_by(2).should == "已上传"
    Contract.status_name_by(3).should == ""
  end

end