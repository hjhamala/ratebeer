# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
b1 = Brewery.create name:"Koff", year:1897
b2 = Brewery.create name:"Malmgard", year:2001


s1 = Style.create name:"Euro Pale Lager", description:"Similar to the Munich Helles story, many European countries reacted to the popularity of early pale lagers by brewing their own. Hop flavor is significant and of noble varieties, bitterness is moderate, and both are backed by a solid malt body and sweetish notes from an all-malt base."
s2 = Style.create name:"English Pale Ale", description:"The English Pale Ale can be traced back to the city of Burton-upon-Trent, a city with an abundance of rich hard water. This hard water helps with the clarity as well as enhancing the hop bitterness. This ale can be from golden to reddish amber in color with generally a good head retention. A mix of fruity, hoppy, earthy, buttery and malty aromas and flavors can be found. Typically all ingredients are English."
s3 =  Style.create name:"English Porter", description:"Porter is said to have been popular with transportation workers of Central London, hence the name. Most traditional British brewing documentation from the 1700s state that Porter was a blend of three different styles: an old ale (stale or soured), a new ale (brown or pale ale) and a weak one (mild ale), with various combinations of blending and staleness. The end result was also commonly known as \"Entire Butt\" or \"Three Threads\" and had a pleasing taste of neither new nor old. It was the first truly engineered beer, catering to the public's taste, playing a critical role in quenching the thirst of the UKs Industrial Revolution and lending an arm in building the mega-breweries of today. Porter saw a comeback during the homebrewing and micro-brewery revolution of the late 1970s and early 80s, in the US. Modern-day Porters are typically brewed using a pale malt base with the addition of black malt, crystal, chocolate or smoked brown malt. The addition of roasted malt is uncommon, but used occasionally. Some brewers will also age their beers after inoculation with live bacteria to create an authentic taste. Hop bitterness is moderate on the whole and color ranges from brown to black. Overall they remain very complex and interesting beers."

b1.beers.create name:"Iso 3", style:s1
b1.beers.create name:"Karhu", style:s1
b1.beers.create name:"Tuplahumala", style:s1
b2.beers.create name:"Huvila Pale Ale", style:s2
b2.beers.create name:"X Porter", style:s3



users = 100           # jos koneesi on hidas, riittää esim 100
breweries = 50       # jos koneesi on hidas, riittää esim 50
beers_in_brewery = 40
ratings_per_user = 30

(1..users).each do |i|
  User.create! username:"user_#{i}", password:"Passwd1", password_confirmation:"Passwd1"
end

(1..breweries).each do |i|
  Brewery.create! name:"brewery_#{i}", year:1900, active:true
end

bulk = Style.create! name:"bulk", description:"cheap, not much taste"

Brewery.all.each do |b|
  n = rand(beers_in_brewery)
  (1..n).each do |i|
    beer = Beer.create! name:"beer #{b.id} -- #{i}", style:bulk
    b.beers << beer
  end
end

User.all.each do |u|
  n = rand(ratings_per_user)
  beers = Beer.all.shuffle
  (1..n).each do |i|
    r = Rating.new score:(1+rand(50))
    beers[i].ratings << r
    u.ratings << r
  end
end