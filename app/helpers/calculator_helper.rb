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

# would prefer these units to be in controller, but can't figure out how to access controller class methods when precompiling assets
LengthUnits = ["metres", "feet", "inches", "kilometres", "miles", "millimetres"]
VolumeUnits = ["litres", "cubic centimetres", "cubic metres", "millilitres", "cubic inches", "gallon (Imperial)", "gallon (US, liquid)", "pint (Imperial)", "pint (US, liquid)"]
MassUnits = ["kilograms", "grams", "tonnes (metric)", "ounces", "pounds", "tons (US)"]

def toJavascriptArray(arr)
    javascriptArray = "["
    for i in 0..(arr.length-1)
      javascriptArray = javascriptArray + "," if i!=0
      javascriptArray = javascriptArray + "\"" + arr[i]+"\""
    end
    javascriptArray+"]"
end

end
