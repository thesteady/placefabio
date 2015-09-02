module LoremHelpers
  def pull_romance_text(directory, filename='excerpts.md')
    IO.read(Rails.root.join("spec", "fixtures", "romance_excerpts", directory, filename))
  end
end

RSpec.configure do |c|
  c.include LoremHelpers
end
