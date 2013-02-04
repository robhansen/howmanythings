class CalculatorController < ApplicationController
  def main
     
  end
end

class Thing
  attr_reader :singular, :amount, :plural, :singularArticle
 
  def initialize(singular, amount, plural = nil, article = nil)
    @singular = singular
    @amount = amount
    if plural!=nil
      @plural = plural
    else
      @plural = singular + "s"
    end
    if article!=nil
      @singularArticle = article
    else
      @singularArticle = "1"
    end
  end
end

class Dimension
  def self.getBestThing(mass)
    perfectScore = mass / 4.0
    arrayOfThings = self.things
    bestScore = 0.0
    for i in 0..(arrayOfThings.length-1)  
      score = arrayOfThings[i].amount/ perfectScore
      score = 1.0 / score if score > 1.0
      score = score / 8 if arrayOfThings[i].amount > mass #prefer not to have fractions
      if score < bestScore
        # since Things are ordered, i-1 is the best Thing
        return arrayOfThings[i-1]
      else
        bestScore = score
      end
    end
    return arrayOfThings[arrayOfThings.length-1]
  end

  def self.getThingString(mass)
    #Technically this should be in the view (or at least a helper)
    bestThing = self.getBestThing(mass)
    numberOfThings = mass/bestThing.amount
    numberOfThings2SF = sprintf("%.1e", (numberOfThings)).to_f
    if (numberOfThings2SF == 1)
      init = bestThing.singularArticle + " "
      if init==" "
        bestThing.singular
      else
        init + bestThing.singular
      end
    elsif (numberOfThings2SF == numberOfThings2SF.to_i)
      numberOfThings2SF.to_i.to_s  + " " + bestThing.plural
    else       
      numberOfThings2SF.to_s + " " + bestThing.plural
    end
  end

  def self.getStandardAmount(mass, unit)
    index = self.units.index(unit)
    if index != nil
      mass * unitFactors[index]
    else
      nil
    end
  end

  def self.getUnitsJavascriptArray
    rubyArray = self.units
    javascriptArray = "["
    for i in 0..(rubyArray.length-1)
      javascriptArray = javascriptArray + "," if i!=0
      javascriptArray = javascriptArray + "\"" + rubyArray[i]+"\""
    end
    javascriptArray+"]"
  end
end

class Length < Dimension

  THINGS = 
    [
    Thing.new("width of a proton", 0.000000000000001, "protons wide"),
    Thing.new("width of a hydrogen atom", 0.000000000106, "hydrogen atoms wide"),
    Thing.new("width of a water molecule", 0.0000000003, "water molecules wide"),
    Thing.new("bacterium", 0.000001, "bacteria"),
    Thing.new("width of a human hair", 0.000045, "human hairs width"),
    Thing.new("thickness of a bank note", 0.00011, "bank note thicknesses"),
    Thing.new("grain of rice", 0.0006, "grains of rice"),
    Thing.new("flea", 0.0026),
    Thing.new("blade of grass", 0.075, "blades of grass"),
    Thing.new("loaf of sliced bread", 0.305, "loaves of bread"),
    Thing.new("baseball bat", 1.067),
    Thing.new("horse", 2.45),
    Thing.new("African elephant", 6.75),
    Thing.new("18 wheeler", 22.9),
    Thing.new("blue whale", 31),
    Thing.new("olympic swimming pool", 50),
    Thing.new("Boeing 747", 70.6),
    Thing.new("Golden Gate Bridge", 2737),
    Thing.new("Silverstone racetrack", 5901),
    Thing.new("marathon race", 42195),
    Thing.new("Grand Canyon", 446000),
    Thing.new("Nile river", 6650000),
    Thing.new("Great Wall of China", 8850000, "Great Walls of China"),
    Thing.new("circumpherence of the Earth", 40000000, "circumpherences of the Earth"),
    Thing.new("distance from the Earth to the Moon", 375000000, "times the distance from the Earth to the Moon"),
    Thing.new("distance from the Earth to the Sun", 147000000000, "times the distance from the Earth to the Sun"),
    Thing.new("light year", 9460000000000000),
    Thing.new("distance to our nearest star", 39900000000000000, "times the distance to our nearest star")
    ]

  def self.units
    ["metres", "feet", "inches", "kilometres", "miles", "millimetres"]
  end

  def self.unitFactors
    [1, 0.3048, 0.0254, 1000, 1609, 0.001]
  end

  def self.things
    THINGS
  end

  def self.type
    "Length"
  end

  def self.typeString
    "is as long as"
  end
end

class Height < Length
  # this shares all the same units, just override .things

  THINGS = 
    [
    Thing.new("width of a proton", 0.000000000000001, "protons wide", "the"),
    Thing.new("width of a hydrogen atom", 0.000000000106, "hydrogen atoms wide", "the"),
    Thing.new("width of a water molecule", 0.0000000003, "water molecules wide", "the"),
    Thing.new("bacterium", 0.000001, "bacteria"),
    Thing.new("width of a human hair", 0.000045, "human hairs width", "the"),
    Thing.new("thickness of a bank note", 0.00011, "bank note thicknesses", "the"),
    Thing.new("grain of rice", 0.0006, "grains of rice"),
    Thing.new("head of a pin", 0.001, "times the head of a pin", "the"),
    Thing.new("blade of grass", 0.075, "blades of grass"),
    Thing.new("soda can", 0.121),    
    Thing.new("mole hill", 0.3),
    Thing.new("traffic cone", 0.711),
    Thing.new("human being", 1.66),
    Thing.new("height of a basketball hoop", 3.048, "basketball hoops high", "the"),
    Thing.new("giraffe", 4.9),
    Thing.new("Statue of Liberty", 93, "Statues of Liberty", "the"),
    Thing.new("Great Pyramid of Giza", 139, "Great Pyramids of Giza", "the"),
    Thing.new("Eiffel Tower", 324, nil, "the"),
    Thing.new("Empire State Building", 381, nil, "the"),
    Thing.new("Burj Khalifa hotel", 830),
    Thing.new("Mount Vesuvius", 1281, "Mount Vesuvius"),
    Thing.new("Mount Everest", 8850, nil, ""),
    Thing.new("distance to the edge of space", 100000, "times the distance to the edge of space", "the"),
    Thing.new("geostationary orbit", 35786000, "times the height of geostationary orbit", ""),
    Thing.new("distance from the Earth to the Moon", 375000000, "times the distance from the Earth to the Moon", "the"),
    Thing.new("distance from the Earth to the Sun", 147000000000, "times the distance from the Earth to the Sun", "the"),
    Thing.new("light year", 9460000000000000),
    Thing.new("distance to our nearest star", 39900000000000000, "times the distance to our nearest star", "the")
    ]

  def self.things
    THINGS
  end

  def self.type
    "Height"
  end

  def self.typeString
    "is as high as"
  end
end

class Area < Dimension
  THINGS = 
    [
    Thing.new("basketball hoop", 0.664)
    ]

  def self.type
    "Area"
  end

  def self.typeString
    "has the area of"
  end
end

# do speed?

#sewing needle

class Volume < Dimension
  THINGS = 
    [
    Thing.new("hydrogen atom", 0.0000000000000000000000000000654),
    Thing.new("red blood cell", 0.00000000000009),
    Thing.new("grain of sand", 0.000000001, "grains of sand"),
    Thing.new("drop of water", 0.00005, "drops of water"),
    Thing.new("grain of rice", 0.000075, "grains of rice"),
    Thing.new("teaspoon", 0.00493),
    Thing.new("golf ball", 0.04068),
    Thing.new("chicken egg", 0.05095),
    Thing.new("baseball", 0.202),
    Thing.new("mug", 0.24),
    Thing.new("can of soda", 0.33, "cans of soda"),
    Thing.new("soccer ball", 1.77),
    Thing.new("basketball", 7.47),
    Thing.new("bath", 180),
    Thing.new("paddling pool", 3200),
    Thing.new("Olympic swimming pool", 2500000),
    Thing.new("Goodyear blimp", 25000000),
    Thing.new("Hindenburg airship", 200000000),
    Thing.new("Great Pyramid of Giza", 2500000000, "Great Pyramids of Giza"),
    Thing.new("Dead Sea", 147000000000000),
    Thing.new("Grand Canyon", 4170000000000000),
    Thing.new("Mediterranean Sea", 3750000000000000000),
    Thing.new("Atlantic Ocean", 323600000000000000000),
    Thing.new("Moon", 21960000000000000000000),
    Thing.new("Earth", 1080000000000000000000000),
    Thing.new("Jupiter", 1431000000000000000000000000),
    Thing.new("Sun", 1409000000000000000000000000000),
    ]
  
  def self.units
    ["litres", "cubic centimetres", "cubic metres", "millilitres", "cubic inches", "gallon (Imperial)", "gallon (US, liquid)", "pint (Imperial)", "pint (US, liquid)"]
  end

  def self.unitFactors
    [1, 0.001, 1000, 0.001, 0.01639, 4.546, 3.785, 0.568, 0.473]
  end

  def self.things
    THINGS
  end

  def self.type
    "Volume"
  end

  def self.typeString
    "has the volume of"
  end
end

class Mass < Dimension

  THINGS = 
    [
    Thing.new("atom of hydrogen", 0.000000000000000000000000001661, "atoms of hydrogen"),
    Thing.new("atom of gold", 0.0000000000000000000000003272, "atoms of gold"),
    Thing.new("human sperm cell", 0.000000000000022),
    Thing.new("grain of pollen", 0.00000000001, "grains of pollen"),
    Thing.new("eyebrow hair", 0.00000007),
    Thing.new("grain of sand", 0.0000074, "grains of sand"),
    Thing.new("grain of rice", 0.000025, "grains of rice"),
    Thing.new("stamp", 0.00005),
    Thing.new("flea", 0.000095),
    Thing.new("paperclip", 0.0009),
    Thing.new("DVD", 0.016),
    Thing.new("potato", 0.2, "potatoes"),
    Thing.new("loaf of bread", 0.8, "loaves of bread"),
    Thing.new("cat", 4.5),
    Thing.new("human being", 70),
    Thing.new("Mini Cooper Classic", 690),
    Thing.new("African elephant", 8500),
    Thing.new("blue whale", 180000),
    Thing.new("Washington Monument", 82422000),
    Thing.new("Great Pyramid of Giza", 5900000000),
    Thing.new("Mount Everest", 6399000000000),
    Thing.new("Mediterranean Sea", 3750000000000000000),
    Thing.new("Atlantic Ocean", 323600000000000000000),
    Thing.new("Moon", 73480000000000000000000),
    Thing.new("Earth", 5972000000000000000000000),
    Thing.new("Sun", 1989000000000000000000000000000),
    ]
    

  def self.units
    ["kilograms", "grams", "tonnes (metric)", "ounces", "pounds", "tons (US)"]
  end

  def self.unitFactors
    [1, 0.001, 1000, 0.0283495, 0.453592, 907.1847]
  end

  def self.things
    THINGS
  end

  def self.type
    "Mass"
  end

  def self.typeString
    "is as heavy as"
  end
end
