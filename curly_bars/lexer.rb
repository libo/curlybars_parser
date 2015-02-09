require 'rltk/lexer'

module CurlyBars
  class Lexer < RLTK::Lexer
    rule(/{{/) { :CURLY_TAG_BEGIN }
    rule(/}}/) { :CURLY_TAG_END }
    rule(/.*/) { :OUT }
  end
end
