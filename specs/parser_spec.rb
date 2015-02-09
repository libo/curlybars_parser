require './curly_bars/lexer'
require './curly_bars/parser'

describe CurlyBars::Parser do
  it "does something" do
    #doc = "step1{{#if valid }}out{{/if}}step2"
    doc = "step1{{#if valid }}{{#if visible }} out{{/if}}stepX{{/if}}step2"
    lex = CurlyBars::Lexer.lex(doc)
    puts CurlyBars::Parser.parse(lex, parse_tree: 'test1.dot')
  end
end
