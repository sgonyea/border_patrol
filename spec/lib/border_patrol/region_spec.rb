require 'spec_helper'

describe BorderPatrol::Region do
  it "is a Set" do
    BorderPatrol::Region.new.should be_a Set
  end

  describe "#contains_point?" do
    def point
      
    end
    def polygon(start=0)
      BorderPatrol::Polygon.new(
        BorderPatrol::Point.new(start,start), 
        BorderPatrol::Point.new(start + 10, start), 
        BorderPatrol::Point.new(start + 10, start + 10), 
        BorderPatrol::Point.new(start, start + 10))
    end
    subject { BorderPatrol::Region.new(@polygons) }

    it "raises an argument error if contains_point? takes more than 3 arguments" do
      expect { subject.contains_point? }.to raise_exception ArgumentError
      expect { subject.contains_point?(1,2,3) }.to raise_exception ArgumentError
    end
    
    it "returns true if any polygon contains the point" do
      point = BorderPatrol::Point.new(1,2)
      @polygons = [polygon, polygon(30)]

      subject.contains_point?(point).should be_true
    end

    it "returns false if no polygons contain the point" do
      point = BorderPatrol::Point.new(-1,-2)
      @polygons = [polygon, polygon(30)]

      subject.contains_point?(point).should be_false
    end

    it "transforms (x,y) coordinates passed in into a point" do
      @polygons = [polygon, polygon(30)]

      subject.contains_point?(1,2).should be_true
    end
  end
end