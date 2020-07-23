require 'open-uri'

class PowerGeneratorsController < ApplicationController
  def index
    @power_generators = PowerGenerator.all
    @simple = params['simple_search']
    @advanced = params['advanced_search']
    @structure_types = PowerGenerator.structure_types.keys

    if @simple
      simple_search
    elsif @advanced
      advanced_search
    end
  end

  def show
    @power_generator = PowerGenerator.find(params[:id])
    @zip = params[:zip_code]
    if @zip
      @zip_value = @zip[:code]
      url = "http://apps.widenet.com.br/busca-cep/api/cep/#{@zip_value.first(5)}-#{@zip_value.last(3)}.json"
      address = open(url).read
      @address = JSON.parse(address)

      @freights = Freight.address_state(@address)
    else
      @freights = []
    end
  end

  private

  def simple_search
    @query = @simple[:query].split(' ')
    score_hash = {}
    @power_generators.each { |pgen| score_hash[pgen.id] = 0 }

    @query.each do |word|
      @power_generators.each do |pgen|
        score_hash[pgen.id] += 3 if pgen.name.downcase.include?(word.downcase)
        score_hash[pgen.id] += 1 if pgen.description.downcase.include?(word.downcase)
      end
    end

    score_ary = score_hash.sort_by { |_k, v| v }.reverse
    filtered_score = score_ary.reject { |_k, v| v.zero? }

    @power_generators = []

    filtered_score.each do |score|
      pgen = PowerGenerator.find(score[0])
      @power_generators.push(pgen)
    end
  end

  def advanced_search
    unless @advanced[:structure] == ''
      @power_generators = @power_generators.select { |pgen| pgen.structure_type == @advanced[:structure] }
    end

    unless @advanced[:max_lenght] == ''
      @power_generators = @power_generators.select { |pgen| pgen.lenght <= @advanced[:max_lenght].to_i }
    end

    unless @advanced[:max_width] == ''
      @power_generators = @power_generators.select { |pgen| pgen.width <= @advanced[:max_width].to_i }
    end

    unless @advanced[:max_height] == ''
      @power_generators = @power_generators.select { |pgen| pgen.height <= @advanced[:max_height].to_i }
    end

    unless @advanced[:max_weight] == ''
      @power_generators = @power_generators.select { |pgen| pgen.weight <= @advanced[:max_weight].to_i }
    end

    unless @advanced[:min_kwp] == ''
      @power_generators = @power_generators.select { |pgen| pgen.kwp >= @advanced[:min_kwp].to_i }
    end

    simple_search unless @advanced[:query] == ''
  end
end
