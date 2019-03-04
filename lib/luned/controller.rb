## Entry point for Luned command line interface.
#Initializes with the

class Luned::Controller

  attr_accessor :prompt, :view

  def initialize
    @prompt = Luned::Prompt.new
    @view = Luned::View.new
  end

  def start
    view.greeting
    control_prompt
    view.credits
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
      if !prompt.quit? && prompt.valid_args?
        prompt.submit_args
        view.display(breadcrumb)
        prompt.pop_hour
      end
    end
  end

end
