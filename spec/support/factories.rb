FactoryGirl.define do
  factory :commit do
    sha     "2854c5c3fb65b709fbf32d05faccf7a294626cca"
    message <<-"EOS".strip_heredoc
      Fixes #11952: Refactor blockquote styles

      * Deprecate .pull-right class for .blockquote-reverse
      * Move font-size change to the parent, blockquote, instead of setting on the p element to allow more flexible content
    EOS
  end
end
