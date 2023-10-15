module ApplicationHelper
  def map_sort_moods
    Saturn::Constants::MOODS.sort.map { |mood| [mood[0].to_s.titleize, mood[0]] }
  end
end
