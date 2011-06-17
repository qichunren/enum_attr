# encoding: utf-8  
require File.dirname(__FILE__) + "/spec_helper"

class Person
  enum_attr :emotion, [['正常', 0, "normal"], ['开心', 1, "happy"], ["悲伤", 2, "sad"]]
  
  def set_emotion(emotion)
    @emotion = emotion
  end
  
end

describe "Person emotion_#value? method" do
  it "should return true or fals with emotion_#value? method" do
    person = Person.new
    person.set_emotion(0)
    person.emotion_normal?.should == true
    person.emotion_happy?.should == false
  end
end

describe "Person const" do
  it "should have three consts" do
    Person::EMOTION_NORMAL.should == 0
    Person::EMOTION_HAPPY.should == 1
    Person::EMOTION_SAD.should == 2
  end
end