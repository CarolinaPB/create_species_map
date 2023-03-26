library(data.table)
library(OpenStreetMap)
library(ggplot2)

# Create fake dataset
species = c("species1", "species2", "species3")
nspecies = 10

dataset <- data.table(species = sample(species, nspecies, replace=T),
           lon = runif(nspecies,5.54,5.68), lat = runif(nspecies,51.66,51.77)  )


# Map coordinates - WGS84
upper_left_lat <- 51.772259
bottom_right_lat <- 51.65
upper_left_lon <- 5.539234
bottom_right_lon <-5.687646


sa_map <- openmap(c(upper_left_lat, upper_left_lon), c(bottom_right_lat, bottom_right_lon),
                  type = 'osm', mergeTiles = TRUE)

sa_map2 <- openproj(sa_map)


pdf("Location_map_species.pdf")
for (i in unique(dataset$species)){
  print(i)
  sa_map2_plt <- OpenStreetMap::autoplot.OpenStreetMap(sa_map2) +
    geom_point(data = dataset[species == i],
               aes(x = lon +0.002 , y = lat-0.007), # slightly shift the points
               color = "red", size =  1) +
  xlab("") + ylab("") +
  theme(axis.text.x=element_blank(), #remove x axis labels
        axis.ticks.x=element_blank(), #remove x axis ticks
        axis.text.y=element_blank(),  #remove y axis labels
        axis.ticks.y=element_blank()  #remove y axis ticks
  ) +
    labs(caption = "Map created by CarolinaPB - https://github.com/CarolinaPB") +
    ggtitle(paste("Location -",i ))
  plot(sa_map2_plt)
}
dev.off()









  # sa_map3_plt <- sa_map2_plt +
  #   geom_text(data = conv[categorie == i], # Choose dataframe
  #             aes(result_lng+0.002, result_lat-0.007, label = soort_id), # Set aesthetics
  #             hjust = 1.15, vjust = 1, # Adjust vertical and horizontal
  #             size = 3, colour = "salmon") + # Adjust appearance
  #   # labs(caption = "Map created by Carolina Pita Barros - https://github.com/CarolinaPB") +
  #   # ggtitle(paste("Maashorst -",i ))
  # plot(sa_map3_plt)
