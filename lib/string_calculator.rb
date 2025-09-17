# frozen_string_literal: true

class StringCalculator
  DEFAULT_DELIMITERS = [",", "\n"]

  def add(numbers)
    return 0 if numbers.nil? || numbers.empty?

    delimiters, numbers = extract_delimiters(numbers)
    tokens = split_numbers(numbers, delimiters)
    nums = convert_to_integers(tokens)
    check_negatives(nums)

    nums.sum
  end

  private

  def extract_delimiters(numbers)
    delimiters = DEFAULT_DELIMITERS.dup

    if numbers.start_with?("//")
      parts = numbers.split("\n", 2)
      delimiters = [Regexp.escape(parts[0][2..])]
      numbers = parts[1]
    end

    [delimiters, numbers]
  end

  def split_numbers(numbers, delimiters)
    pattern = Regexp.union(delimiters)
    numbers.split(pattern)
  end

  def convert_to_integers(tokens)
    tokens.reject(&:empty?).map(&:to_i)
  end

  def check_negatives(nums)
    negatives = nums.select { |n| n < 0 }
    unless negatives.empty?
      raise ArgumentError, "negative numbers not allowed #{negatives.join(' ')}"
    end
  end
end
