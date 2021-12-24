class HomeController < ApplicationController
  def index
    require 'net/http'
    require 'json'
    @url = 'https://www.airnowapi.org/aq/observation/zipCode/current/?format=application/json&zipCode=20165&distance=0&API_KEY=151BC48D-E3FB-42AF-B7DA-7A8FB819B626'
    @uri = URI(@url)
    @response = Net::HTTP.get(@uri)
    @output = JSON.parse(@response)

    # Check for empty results
    if @output.empty?
      @final_output = "Error"
    else
      @final_output = @output[0]['AQI']
    end

    if @final_output == "Error"
      @api_color = "gray"
    elsif @final_output <= 50
      @api_color = "green"
      @api_description = "Good"
    elsif @final_output >= 51 && @final_output <= 100
      @api_color = "yellow"
      @api_description = "Moderate"
    elsif @final_output >= 101 && @final_output <= 150
      @api_color = "orange"
      @api_description = "Unhealthy for Sensitive Groups (USG)"
    elsif @final_output >= 151 && @final_output <= 200
      @api_color = "red"
      @api_description = "Unhealthy"
    elsif @final_output >= 201 && @final_output <= 300
      @api_color = "purple"
      @api_description = "Very Unhealthy"
    elsif @final_output >= 301 && @final_output <= 500
      @api_color = "maroon"
      @api_description = "Hazardous"
    end
  end

  def zipcode
    @zip_query = params[:zipcode]

    if params[:zipcode] == ""
      @zip_query = "Hey you forgot to enter a zipcode!"
    elsif params[:zipcode]
      require 'net/http'
      require 'json'
      @url = 'https://www.airnowapi.org/aq/observation/zipCode/current/?format=application/json&zipCode=' + @zip_query + '&distance=0&API_KEY=151BC48D-E3FB-42AF-B7DA-7A8FB819B626'
      @uri = URI(@url)
      @response = Net::HTTP.get(@uri)
      @output = JSON.parse(@response)
  
      # Check for empty results
      if @output.empty?
        @final_output = "Error"
      else
        @final_output = @output[0]['AQI']
      end
  
      if @final_output == "Error"
        @api_color = "gray"
      elsif @final_output <= 50
        @api_color = "green"
        @api_description = "Good"
      elsif @final_output >= 51 && @final_output <= 100
        @api_color = "yellow"
        @api_description = "Moderate"
      elsif @final_output >= 101 && @final_output <= 150
        @api_color = "orange"
        @api_description = "Unhealthy for Sensitive Groups (USG)"
      elsif @final_output >= 151 && @final_output <= 200
        @api_color = "red"
        @api_description = "Unhealthy"
      elsif @final_output >= 201 && @final_output <= 300
        @api_color = "purple"
        @api_description = "Very Unhealthy"
      elsif @final_output >= 301 && @final_output <= 500
        @api_color = "maroon"
        @api_description = "Hazardous"
      end

    end
  end
end
