# Helpful websites for ggplot graphing: ----
# http://r-statistics.co/Top50-Ggplot2-Visualizations-MasterList-R-Code.html
# http://sape.inf.usi.ch/quick-reference/ggplot2/colour


# Load Packages, Import Data ----
library(tidyverse)
library(coefplot)
library(corrplot)
library(readr)
library(cowplot)


spy <- read_csv("01. Raw Data/SPY.csv")
View(spy)


# Line Graph (for time series data) ----
line1 <- ggplot(spy, mapping = aes(Date, `Adj Close`)) +
  geom_area(aes(y = spy$'Adj Close'), 
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

line1


# (Scatterplot w/line) ----
scatter1 <- ggplot(spy, aes(Date, Volume)) +
  geom_point(aes(y = Volume), 
             color = "cadetblue4",
             size = 0.8) +
  geom_hline(yintercept = 0, 
             col = "slategrey", 
             linetype = "solid") +
  geom_smooth(method="loess", 
              color = "red",
              linetype = "solid",
              se=F) +
  labs(x = "Date",
       y = "Volume",
       title = "SPDR S&P 500 ETF Weekly Volume",
       subtitle = "Historical Data Scatter w/Fitted Line",
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

scatter1


# Lollipop Chart ----
lollipop1 <- ggplot(spy, aes(Date, Volume)) +
  geom_point(aes(y = Volume), 
             color = "cadetblue4",
             size = 1) +
  geom_segment(aes(x = Date, 
                   xend = Date, 
                   y = 0, 
                   yend = Volume),
               color = "cadetblue4",
               alpha = 0.3,
               size = 0.1) +
  labs(x = "Date",
       y = "Volume",
       title = "SPDR S&P 500 ETF Weekly Volume",
       subtitle = "Historical Lollipop Chart",
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

lollipop1
