require './curly_bars/lexer'
require './curly_bars/parser'

describe "integration" do
  it "runs if statement" do
    doc = "step1{{#if valid }}{{#if visible }} out{{/if}}stepX{{/if}}step2"
    lex = CurlyBars::Lexer.lex(doc)
    ruby_code = CurlyBars::Parser.parse(lex)

    valid = true;
    visible = true;
    buf = "";
    rendered = eval(ruby_code)

    expect(buf).to eq("step1 outstepXstep2")
  end

  it "resolves presenter" do
    class AvatarPresenter
      def initilize(avatar)
        @avatar = avatar
      end

      def url
        @avatar[:url]
      end
    end

    class UserPresenter
      def initialize(user)
        @user = user
      end

      def avatar
        avatar = @user[:avatar]
        AvatarPresenter.new(avatar)
      end
    end

    class PostShowPresenter
      def initialize
        @current_user = { avatar: { url: "http://foobar" } }
      end

      def test(str)
        eval(str)
      end

      def user
        UserPresenter.new(@current_user)
      end
    end


    doc = "{{user.avatar.url}}"
    lex = CurlyBars::Lexer.lex(doc)
    ruby_code = CurlyBars::Parser.parse(lex)

    context = PostShowPresenter.new.test(ruby_code)

    # puts ruby_code

    # rendered = context.instance_eval(ruby_code)


    # # rendered = PostShowPresenter.new.instance_evalruby_code)

    # expect(rendered).to eq("http://foobar")
  end
end
