require_relative "boot"

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_mailbox/engine"
require "action_text/engine"
require "action_view/railtie"
require "action_cable/engine"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module SaturnApp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    config.time_zone = "America/Bogota"
    # config.eager_load_paths << Rails.root.join("extras")

    # Don't generate system test files.
    config.generators.system_tests = nil
  end

  module Constants
    MOODS = {
      aloof: 0,
      amused: 1,
      angry: 2,
      annoyed: 3,
      anxious: 4,
      apathetic: 5,
      apologetic: 6,
      awkward: 7,
      bitter: 8,
      calm: 9,
      carefree: 10,
      cautious: 11,
      challenged: 12,
      comfortable: 13,
      confident: 14,
      confused: 15,
      constructive: 16,
      content: 17,
      cowardly: 18,
      craving: 19,
      curious: 20,
      defeated: 21,
      defensive: 22,
      delusional: 23,
      desperate: 24,
      destructive: 25,
      disappointed: 26,
      disturbed: 27,
      doubtful: 28,
      eager: 29,
      energized: 30,
      envious: 31,
      excited: 32,
      fearful: 33,
      friendly: 34,
      frustrated: 35,
      furious: 36,
      gloomy: 37,
      goofy: 38,
      grateful: 39,
      guilty: 40,
      happy: 41,
      heartbroken: 42,
      hopeful: 43,
      hopeless: 44,
      horny: 45,
      humble: 46,
      hysterical: 47,
      insecure: 48,
      inspired: 49,
      irritated: 50,
      jealous: 51,
      joyful: 52,
      lonely: 53,
      lost: 54,
      loved: 55,
      miserable: 56,
      motivated: 57,
      needy: 58,
      nervous: 59,
      neutral: 60,
      nostalgic: 61,
      obsessed: 62,
      offended: 63,
      optimistic: 64,
      outraged: 65,
      overwhelmed: 66,
      paranoid: 67,
      patient: 68,
      pessimistic: 69,
      pleased: 70,
      proud: 71,
      relaxed: 72,
      relieved: 73,
      reluctant: 74,
      resentful: 75,
      romantic: 76,
      sad: 77,
      satisfied: 78,
      secure: 79,
      sensual: 80,
      sexy: 81,
      shocked: 82,
      sick: 83,
      skeptical: 84,
      sore: 85,
      stressed: 86,
      stupid: 87,
      surprised: 88,
      tense: 89,
      terrified: 90,
      thoughtful: 91,
      tired: 92,
      unapologetic: 93,
      uncomfortable: 94,
      understanding: 95,
      unfriendly: 96,
      unhappy: 97,
      unmotivated: 98,
      unpatient: 99,
      vengeful: 100,
      victorious: 101,
      vulnerable: 102,
      worried: 103,
      yearning: 104
    }.freeze
  end
end
