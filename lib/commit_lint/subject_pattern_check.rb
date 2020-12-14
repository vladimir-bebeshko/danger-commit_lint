def extractSubject(message)
  return message[:subject].split('> ')[1] ||= message[:subject]
end

module Danger
  class DangerCommitLint < Plugin
    class SubjectPatternCheck < CommitCheck # :nodoc:
      COMMIT_TYPES = [ 'Build', 'CI', 'Docs', 'Feat', 'Fix', 'Perf', 'Refactor', 'Revert', 'Style', 'Test', ].freeze

      MESSAGE = <<~DESCRIPTION.freeze
        Please follow the commit format `[MO-####] <TYPE> Subject`

        where `TYPE` is one of the following:
        ```
        #{SubjectPatternCheck::COMMIT_TYPES.join "\n"}
        ```
        and `Subject` is your commit message.

        Minimum `Subject` length is **10** characters. Only **ASCII** symbols allowed.

        More about how to write good commit messages (and why it's matter) below:
          1. [How to Write a Git Commit Message](https://chris.beams.io/posts/git-commit) *by [Chris Beams](https://chris.beams.io)*
          2. [Contributing to a Project](https://git-scm.com/book/en/v2/Distributed-Git-Contributing-to-a-Project) *from the [Pro Git book](https://git-scm.com/book/en/v2)*
      DESCRIPTION

      def self.type
        :subject_cap
      end

      def initialize(message)
        @subject = message[:subject]
      end

      def fail?
        regex_string = "^\\[MO-\\d+\\] <(#{SubjectPatternCheck::COMMIT_TYPES.join '|'})> [[:ascii:]]{10,}"
        (@subject =~ Regexp.new(regex_string)) == nil
      end
    end
  end
end