require 'commit_lint/subject_pattern_check'

module Danger
  class DangerCommitLint < Plugin
    class SubjectPeriodCheck < CommitCheck # :nodoc:
      MESSAGE = 'Please remove period from end of commit message subject line.'.freeze

      def self.type
        :subject_period
      end

      def initialize(message)
        @subject = extractSubject(message)
      end

      def fail?
        @subject.split('').last == '.'
      end
    end
  end
end
