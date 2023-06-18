module Awards
  def calculate_tier(days)
    case days
    when (1..3)
      1
    when (4..7)
      2
    when (8..15)
      3
    when (16..30)
      4
    else
      5
    end
  end
end
