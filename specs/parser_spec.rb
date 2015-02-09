require './curly_bars/lexer'
require './curly_bars/parser'

describe CurlyBars::Parser do
  it "does something" do
    doc = "{{#if valid? }}foo{{/if}}"
    lex = CurlyBars::Lexer.lex(doc)
    CurlyBars::Parser.parse(lex, parse_tree: 'test1.dot')
    puts `dot -Tpng test1.dot > test1.png; open test1.png`
  end
end
