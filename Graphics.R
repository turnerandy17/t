
# Load Packages, Import Data ----
library(tidyverse)
library(coefplot)
library(corrplot)
library(readr)


spy <- read_csv("01. Raw Data/SPY.csv")
View(spy)


# Line Graph (for time series data) ----
line_graph <- ggplot(spy, mapping = aes(spy$Date, spy$`Adj Close`)) +
  geom_area(aes(y = spy$'Adj Close'), 
            alpha = 0.2, 
            color = "cadetblue4",
            fill = "cadetblue2") +
  labs(x = "Date",
       y = "Adj. Close Price",
       title = "SPDR S&P 500 ETF Trust (SPY)",
       subtitle = "Historical Data",
       caption = "Yahoo Finance") +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.background = element_blank(),
        axis.line = element_line(color = ),
        plot.title = element_text(hjust = 0.5, 
                                  size = 20, 
                                  face = "bold",
                                  color = "dodgerblue4"),
        plot.subtitle = element_text(hjust = 0.5, 
                                     size = 14, 
                                     color = "royalblue4"),
        plot.caption = element_text(color = "gray60"))

line_graph


# (Scatterplot w/line) ----
scatter_plot <- ggplot(spy, aes(spy$Date, spy$Volume)) +
  geom_point(aes(y = spy$Volume), 
             color = "cadetblue4") +
  geom_hline(yintercept = 0, 
             col = "slategrey", 
             linetype = "solid") +
  labs(x = "Date",
       y = "Volume",
       title = "SPDR S&P 500 ETF Weekly Volume",
       subtitle = "Historical Data",
       caption = "Yahoo Finance") +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.background = element_blank(),
        axis.line = element_line(color = ),
        plot.title = element_text(hjust = 0.5, 
                                  size = 20, 
                                  face = "bold",
                                  color = "dodgerblue4"),
        plot.subtitle = element_text(hjust = 0.5, 
                                     size = 10, 
                                     color = "slategrey"),
        plot.caption = element_text(color = "gray60"))

scatter_plot
