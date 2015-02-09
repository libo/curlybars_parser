require './curly_bars/lexer'

describe CurlyBars::Lexer do
  it "generates EOS token for an empty string" do
    expect(lexed("")).to eq([:EOS])
  end

  it "generates OUT token" do
    expect(lexed("foo")).to eq([:OUT, :EOS])
  end

  it "opens a curly_bars mustaches {{" do
    expect(lexed("{{")).to eq([:CURLY_TAG_BEGIN, :EOS])
  end

  it "scans open and close curly" do
   expect(lexed("{{}}")).to eq([:CURLY_TAG_BEGIN, :CURLY_TAG_END, :EOS])
  end

  it "scans a curly identifier" do
    expect(lexed("{{libo}}")).
      to eq([:CURLY_TAG_BEGIN, :IDENT, :CURLY_TAG_END, :EOS])
  end

  private

  def lexed(expression)
    CurlyBars::Lexer.lex(expression).map(&:type)
  end
end
