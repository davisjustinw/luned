## Entry point for Luned command line interface.
# Prompt controls input and breadcrumb.
# View displays data and triggers object creation with API calls when needed.

class Luned::Controller

  attr_reader :prompt, :view

  def initialize
    @prompt = Luned::Prompt.new
    @view = Luned::View.new
  end

  def start
    ## Entry point
    view.greeting
    control_prompt
    view.credits
  end

  def control_prompt
    ## Central business logic.
    # pop_hour allows calling repeated hours without ..
    while !prompt.quit? do
      prompt.display_breadcrumb
      prompt.get_args
      if !prompt.quit? && prompt.valid_args?
        prompt.submit_args
        view.display(prompt.breadcrumb)
        prompt.pop_hour
      end
    end
  end

end
