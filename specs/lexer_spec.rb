require './curly_bars/lexer'

describe CurlyBars::Lexer do
  it "generates EOS token for an empty string" do
    expect(lexed("")).to eq([:EOS])
  end

  it "generates OUT token" do
    expect(lexed("foo")).to eq([:OUT, :EOS])
  end

  it "opens a curly_bars mustaches {{" do
    expect(lexed("{{")).to eq([:EOS])
  end

  it "scans open and close curly" do
   expect(lexed("{{}}")).to eq([:EOS])
  end

  it "scans a curly acessor" do
    expect(lexed("{{user}}")).
      to eq([:ACCESSOR, :EOS])
  end

  it "scans a curly identifier" do
    expect(lexed("foo {{user}} bar")).
      to eq([:OUT, :ACCESSOR, :OUT, :EOS])
  end

  it "scans a curly identifier with spaces" do
    expect(lexed("{{   user }}")).
      to eq([:ACCESSOR, :EOS])
  end

  it "scans comments" do
    expect(lexed("{{! comment }}")).
      to eq([:EOS])
  end

  it "scans comments without being too greedy" do
    expect(lexed("{{! comment }}{{foo}}")).
      to eq([:ACCESSOR, :EOS])
  end

  it "scans comments" do
    expect(lexed("{{!}}")).
      to eq([:EOS])
  end

  it "scans an if statement" do
    expect(lexed("{{#if condition }}foo{{/if}}")).
      to eq([:IF, :ACCESSOR, :OUT, :ENDIF, :EOS])
  end

  it "scans an accessor" do
    expect(lexed("{{bar.foo.baz}}")).
      to eq([:ACCESSOR, :EOS])
  end

  private

  def lexed(expression)
    CurlyBars::Lexer.lex(expression).map(&:type)
  end
end
