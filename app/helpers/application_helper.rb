module ApplicationHelper
  def map_sort_moods
    SaturnApp::Constants::MOODS.sort.map { |mood| [mood[0].to_s.titleize, mood[0]] }
  end
end
