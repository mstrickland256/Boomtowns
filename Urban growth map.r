# LIBRARIES
library(leaflet)
library(viridis)

# ACCESSING DATA
cities <- read.csv("urban growth.csv", encoding = "UTF-8", stringsAsFactors = FALSE)

# DRAWING BASIC MAP
mappy <- leaflet() %>% addTiles() %>% addProviderTiles(providers$CartoDB.Positron)

(dom <- range(cities$GrowthRate))

spectrum <- colorNumeric(palette = viridis(100), domain = dom)

# PLOTTING POINTS ON MAP
leaflet(cities) %>% addTiles() %>% addCircleMarkers(radius = ~sqrt(cities$SizeIn2030 / 100),
color = ~spectrum(GrowthRate),
stroke = FALSE,
fillOpacity = 0.5,
label = sprintf("%s <br/> %g", cities$City, cities$SizeIn2030) %>% lapply(htmltools::HTML)) %>% addLegend(pal = spectrum, values = ~GrowthRate, opacity = 0.9, title = "Global Urban Growth", position = "bottomleft")
