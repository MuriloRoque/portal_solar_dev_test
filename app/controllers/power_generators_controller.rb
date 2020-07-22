class PowerGeneratorsController < ApplicationController
  def index
    @power_generators = PowerGenerator.all
    @structure_types = PowerGenerator.structure_types.keys
  end
end
