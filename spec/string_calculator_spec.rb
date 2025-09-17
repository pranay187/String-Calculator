require_relative "../lib/string_calculator"

RSpec.describe StringCalculator do
  let(:calc) { described_class.new }

  it "returns 0 for empty string" do
    expect(calc.add("")).to eq(0)
  end

  it "returns the number itself for single input" do
    expect(calc.add("1")).to eq(1)
  end

  it "sums two numbers" do
    expect(calc.add("1,5")).to eq(6)
  end

  it "handles multiple numbers" do
    expect(calc.add("1,2,3,4,5")).to eq(15)
  end

  it "handles newlines as delimiters" do
    expect(calc.add("1\n2,3")).to eq(6)
  end

  it "supports custom single-character delimiter" do
    expect(calc.add("//;\n1;2;3")).to eq(6)
  end

  it "raises error for single negative number" do
    expect { calc.add("-1,2") }
      .to raise_error(ArgumentError, /negative numbers not allowed -1/)
  end

  it "raises error for multiple negatives and lists them" do
    expect { calc.add("1,-2,3,-4") }
      .to raise_error(ArgumentError, /negative numbers not allowed -2 -4/)
  end

  it "ignores empty tokens" do
    expect(calc.add("1,,2")).to eq(3)
  end
end
