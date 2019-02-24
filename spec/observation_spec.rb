describe "Observation" do
  describe "::during" do
    it "returns all oservations made during the time given" do
      ob1 = Weather911::Observation.new(DateTime.new(2019, 12, 31, 1))
      ob2 = Weather911::Observation.new(DateTime.new(2019, 12, 31, 2))
      ob3 = Weather911::Observation.new(DateTime.new(2019, 12, 30, 1))
      day = DateTime.new(2019, 12, 31)
      expect(Weather911::Observation.during(day)).to include(ob1)
    end
  end
end
