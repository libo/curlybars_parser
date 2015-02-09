require 'rltk/parser'

module CurlyBars
  class Parser < RLTK::Parser
    production(:template) do
      clause('items') { |items| items }
    end

    production(:items) do
      clause('items item') { |items, item| items << item }
      clause('item') { |item| item }
    end

    production(:item) do
      clause('OUT') { |input| input }
      clause('CURLY_TAG_BEGIN IF IDENT CURLY_TAG_END .template CURLY_TAG_BEGIN ENDIF CURLY_TAG_END') { |template| template }
    end

    finalize
  end
end
