module Playbook
  class Configuration

    attr_reader :versions
    attr_accessor :rescue_errors
    attr_accessor :require_documentation
    attr_accessor :throttle_header

    def initialize
      @versions = []
      self.rescue_errors = true
    end

    def register_version(*vers)
      @versions |= vers.map{|v| ::Playbook::Version.for(v) }
      @versions.sort!
    end
    alias_method :register_versions, :register_version

    def major_versions
      @versions.select(&:major?)
    end

    def beta_versions
      @versions.select(&:beta?)
    end

    def descending_versions(passed = nil, ignore_beta = false)
      passed ||= latest_version
      passed = ::Playbook::Version.for(passed)
      results = @versions.select{|v| v <= passed }.sort.reverse
      results = results.reject(&:beta?) if ignore_beta
      results
    end

    def most_recent_version(passed = nil)
      descending_versions(passed).first
    end
  
    def latest_version
      @versions.reject(&:beta?).last
    end
  
    def has_version?(v)
      v = ::Playbook::Version.for(v)
      @versions.include?(v)
    end
  
  end
end