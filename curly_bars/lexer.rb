require 'rltk/lexer'

module CurlyBars
  class Lexer < RLTK::Lexer
    match_first

    rule(/{{/) do
      push_state :curly
      :CURLY_TAG_BEGIN
    end

    rule(/}}/, :curly) do
      pop_state
      :CURLY_TAG_END
    end

    rule(/[^}]*/, :curly) { :IDENT }

    rule(/.*/) { :OUT }
  end
end
