require './spiralify'

describe Spiralify, '#spiralize' do
  describe "spirals" do    
    shared_examples_for 'a square' do
      subject { Spiralify.new(n).spiralize }
      it "returns the correct result" do
        should eq(result)
      end
    
      it "includes 1" do
        subject.flatten.should include(1)
      end
    
      it "includes n" do
        subject.flatten.should include(n)
      end
    
      it "does not include 0" do
        subject.flatten.should_not include(0)
      end
    end
  
    describe "n=1" do
      let(:n) { 1 }
      let(:result) { [[1]] }

      it_behaves_like 'a square'
    end
    describe "n=4" do
      let(:n) { 4 }
      let(:result) { [[4, 3],
                      [1, 2]] }

      it_behaves_like 'a square'
    end
    describe "n=9" do
      let(:n) { 9 }
      let(:result) { [[5, 4, 3],
                      [6, 1, 2],
                      [7, 8, 9]] }

      it_behaves_like 'a square'
    end
    describe "n=16" do
      let(:n) { 16 }
      let(:result) { [[16, 15, 14, 13],
                      [ 5,  4,  3, 12],
                      [ 6,  1,  2, 11],
                      [ 7,  8,  9, 10]] }

      it_behaves_like 'a square'
    end
  end
  
  describe "field directions" do
    subject { Spiralify::Field }
    
    it "should go right to up" do
      subject.next_direction(:right).should eq(:up)
    end
    it "should go up to left" do
      subject.next_direction(:up).should eq(:left)
    end
    it "should go left to down" do
      subject.next_direction(:left).should eq(:down)
    end
    it "should go down to right" do
      subject.next_direction(:down).should eq(:right)
    end
  end
end