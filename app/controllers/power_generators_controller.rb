class PowerGeneratorsController < ApplicationController
  def index
    @power_generators = PowerGenerator.all
  end
end
