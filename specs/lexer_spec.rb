require './curly_bars/lexer'

describe CurlyBars::Lexer do
  it "generates EOS token for an empty string" do
    lexed = CurlyBars::Lexer.lex("").map(&:type)
    expect(lexed).to eq([:EOS])
  end

  it "generates OUT token" do
    lexed = CurlyBars::Lexer.lex("foo").map(&:type)
    expect(lexed).to eq([:OUT, :EOS])
  end

  it "opens a curly_bars mustaches {{" do
    lexed = CurlyBars::Lexer.lex("{{").map(&:type)
    expect(lexed).to eq([:CURLY_TAG_BEGIN, :EOS])
  end

  it "closes a curly_bars mustaches }}" do
    lexed = CurlyBars::Lexer.lex("}}").map(&:type)
    expect(lexed).to eq([:CURLY_TAG_END, :EOS])
  end
end
