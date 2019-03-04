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

    print "\n\n==============  Luned  =============="
    print "\n\n     \u{1F311} \u{1F312} \u{1F313} \u{1F314} \u{1F315} \u{1F316} \u{1F317} \u{1F318} \u{1F311}"
    print "\n\n======  Seattle 911 + Weather  ======\n\n"
    print " - 01 July 2010 to Present\n"
    print " - <..> move up one layer\n"
    print " - <q> quit.\n"
    print " - Examples:\n   - 2010 7\n   - 2010 7 4\n\n"


    control_prompt
    print "\n======================================\n\n"
    print " - Powered by Dark Sky:\n    https://darksky.net/poweredby/\n\n"
    print " - Socrata & Seattle 911:\n    https://dev.socrata.com/foundry/data.seattle.gov/grwu-wqtk\n\n"
    print " - Justin Davis, 2019:\n    https://github.com/davisjustinw/luned\n\n"

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
