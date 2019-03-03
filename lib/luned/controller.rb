#controller

class Luned::Controller
  #@@PROMPTS = ["<yyyy>", "<mm>", "<dd>", "<hr24>"]
  attr_accessor :prompt, :view, :api

  def initialize
    @prompt = Luned::Prompt.new
    @view = Luned::View.new
    @api = Luned::API.new
  end

  def start
    puts ''
    puts "    Follow, me...\u{1f407}"
    puts "\u{1F311} \u{1F312} \u{1F313} \u{1F314} \u{1F315} \u{1F316} \u{1F317} \u{1F318} \u{1F311}"
    puts ''
    control_prompt

  end

  def prompt
    @prompt
  end

  def breadcrumb
    prompt.breadcrumb
  end

  def view
    @view
  end



  def control_prompt
    while !prompt.quit? do
      prompt.display_breadcrumb
      prompt.get_args
      if !prompt.quit?
        prompt.submit_args
        view.display(breadcrumb)
        #api.get(breadcrumb)
        #view.display(breadcrumb)
      end
    end
  end

end
