module CalculatorHelper

#takes an array, and returns an array of 2-option arrays with the index as the second element
def formatForOptionsTag(arr)
  optionArray = []
  for i in 0..(arr.length-1)
    optionArray << [arr[i],i]
  end
  optionArray
end

def arrayOfDimensions
  ["Length", "Height", "Mass", "Volume"]
end

def arrayOfDimensionClasses
  [Length, Height, Mass, Volume]
end

end
