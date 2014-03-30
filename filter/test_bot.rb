module Filter
  class ExampleBot
    # This is Example script
    def update(p)
      return nil # If you want to enable this script, remove this line.
      {
        username: 'ExampleBot',
        text: "Hello, #{p['user_name']}! your text is '#{p['text']}'"
      }
    end
  end
end
