require 'rltk/parser'

module CurlyBars
  class Parser < RLTK::Parser
    start :template

    production(:template) do
      clause('items') { |items| items }
    end

    production(:items) do
      clause('items item') { |items, item| items << item }
      clause('item') { |item| item }
    end

    production(:item) do
      clause('OUT') { |out| "buf << \"#{out}\";" }
      clause('IF .expression .template ENDIF') do |expression, template|
        "if #{expression}\n #{template} \nend\n"
      end
      clause('.ACCESSOR') do |accessor|
        "#{accessor}"
      end
    end

    production(:expression) do
      clause('ACCESSOR') { |accessor| accessor }
      clause('NUMBER') { |number| number }
      clause('STRING') { |string| string }
    end

    finalize
  end
end
