def gene_search(genome, seq)
  state = 0

  # Create state machine
  # Hash { state: Proc to execute }
  state_machine = {}
  (0...seq.length).each do |i|

    state_machine[i] = Proc.new do |el|
      # If current el is next el, increment up state
      if el == seq[state]
        state + 1

      # Otherwise, check correct state to revert to
      else
        reset_state = 0
        curr_seq = seq[0...i] + el
        matched = false

        (0..state-1).each do |k|
          next if matched
          j = state - 1 - k

          curr_snippet = curr_seq[(curr_seq.length-j-1)..-1]
          seq_snippet = seq[0..j]

          if curr_snippet == seq_snippet
            reset_state = j + 1
            matched = true
          end
        end

        reset_state
      end
    end

  end

  # Walk through Genome update state appropriately
  genome.split("").each do |el|
    state = state_machine[state].call(el)

    puts "true" if state >= seq.length
    return true if state >= seq.length
  end

  puts "false"
  false
end

# TEST CASES
gene_search("ACCATGCA", "CAT") # => True
gene_search("ACCATGCA", "CAT") # => True
gene_search("CATTGA", "CAT") # => True
gene_search("GGCACACATG", "CACAT") # => True
gene_search("CAAAT", "CAT") # => False
