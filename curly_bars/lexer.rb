require 'rltk/lexer'

module CurlyBars
  class Lexer < RLTK::Lexer
    match_first

    # Comment
    rule(/{{!/) { push_state :comment }
    rule(/[^}]+/, :comment)
    rule(/}}/, :comment) { pop_state }

    rule(/{{/) { push_state :curly; :CURLY_TAG_BEGIN }
    rule(/}}/, :curly) { pop_state; :CURLY_TAG_END }
    rule(/[^}]*/, :curly) { :IDENT }
    rule(/[^{]*/) { :OUT }
  end
end
