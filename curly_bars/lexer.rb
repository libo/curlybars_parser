require 'rltk/lexer'

module CurlyBars
  class Lexer < RLTK::Lexer
    match_first

    # Comment
    rule(/{{!/) { push_state :comment }
    rule(/[^}]+/, :comment)
    rule(/}}/, :comment) { pop_state }

    # Curly raw
    rule(/{{{/,) { push_state :curly; :RAW_BEGIN }
    rule(/}}}/, :curly) { pop_state; :RAW_END }

    rule(/{{/) { push_state :curly }
    rule(/}}/, :curly) { pop_state }

    rule(/\s/, :curly)

    rule(/#\s*if/, :curly) { :IF }
    rule(/\/\s*if/, :curly) { :ENDIF }

    rule(/[A-Za-z][\w\.]*\??/, :curly) { |name| [:ACCESSOR, name] }

    rule(/[^{]*/) { |out| [:OUT, out] }
  end
end
