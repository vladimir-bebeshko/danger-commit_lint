def extractSubject(message)
  return message[:subject].split('> ')[1] ||= message[:subject]
end

module Danger
  class DangerCommitLint < Plugin
    class SubjectPatternCheck < CommitCheck # :nodoc:
      MESSAGE = "Please follow the commit format `[MO-####] <TYPE> Subject`.".freeze

      def self.type
        :subject_cap
      end

      def initialize(message)
        @subject = message[:subject]
      end

      def fail?
        commit_types = [
          'BUILD', 'CI', 'DOCS', 'FEAT', 'FIX', 'PERF', 'REFACTOR', 'REVERT', 'STYLE', 'TEST',
          ]

        regex_string = "^\\[MO-\\d+\\] <(#{commit_types.join '|'})> [[:ascii:]]{10,}"
        (@subject =~ Regexp.new(regex_string)) == nil
      end
    end
  end
end