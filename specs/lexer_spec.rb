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
    expect(lexed("{{user}}")).
      to eq([:CURLY_TAG_BEGIN, :ACCESSOR, :CURLY_TAG_END, :EOS])
  end

  it "scans a curly identifier" do
    expect(lexed("foo {{user}} bar")).
      to eq([:OUT, :CURLY_TAG_BEGIN, :ACCESSOR, :CURLY_TAG_END, :OUT, :EOS])
  end

  it "scans a curly identifier with spaces" do
    expect(lexed("{{   user }}")).
      to eq([:CURLY_TAG_BEGIN, :ACCESSOR, :CURLY_TAG_END, :EOS])
  end

  it "scans comments" do
    expect(lexed("{{! comment }}")).
      to eq([:EOS])
  end

  it "scans comments without being too greedy" do
    expect(lexed("{{! comment }}{{foo}}")).
      to eq([:CURLY_TAG_BEGIN, :ACCESSOR, :CURLY_TAG_END, :EOS])
  end

  it "scans comments" do
    expect(lexed("{{!}}")).
      to eq([:EOS])
  end

  it "scans comments without being too greedy" do
    expect(lexed("{{{ user_name }}}")).
      to eq([:CURLY_RAW_TAG_BEGIN, :ACCESSOR, :CURLY_RAW_TAG_END, :EOS])
  end

  it "scans an if statement" do
    expect(lexed("{{#if condition }}foo{{/if}}")).
      to eq([:CURLY_TAG_BEGIN,
             :IF,
             :ACCESSOR,
             :CURLY_TAG_END,
             :OUT,
             :CURLY_TAG_BEGIN,
             :ENDIF,
             :CURLY_TAG_END,
             :EOS])
  end

  it "scans an accessor" do
    expect(lexed("{{bar.foo.baz}}")).
      to eq([:CURLY_TAG_BEGIN,
             :ACCESSOR,
             :CURLY_TAG_END,
             :EOS])
  end

  private

  def lexed(expression)
    CurlyBars::Lexer.lex(expression).map(&:type)
  end
end
