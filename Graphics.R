
# Helpful websites for ggplot graphing: ----
# http://r-statistics.co/Top50-Ggplot2-Visualizations-MasterList-R-Code.html
# http://sape.inf.usi.ch/quick-reference/ggplot2/colour
# https://www.r-bloggers.com/2018/06/customizing-time-and-date-scales-in-ggplot2/
# http://r-statistics.co/Top50-Ggplot2-Visualizations-MasterList-R-Code.html#Bubble%20Plot


# Load Packages ----
library(tidyverse)
library(coefplot)
library(corrplot)
library(readr)
library(cowplot)
library(viridis)
library(lubridate)
library(extrafont)
library(tidyquant)
library(scales)


# Import Data, tidy up ----
spy <- read_csv("01. Raw Data/SPY.csv")
spy = spy %>% 
  mutate(date = ymd(Date)) %>% 
  mutate_at(vars(Date), funs(year, month, day))
spy_returns <- spy %>%
  tq_transmute(select = 'Adj Close',  
               mutate_fun = periodReturn,
               period = "weekly",
               col_rename = "Returns")
spy_returns1 <- spy_returns %>%
  mutate(positive = ifelse(Returns >= 0, 2, 1))
spy_full <- left_join(spy, spy_returns1, by = "Date")
View(spy_full)


# Line Graph (for time series data) ----
line1 <- ggplot(spy_full, mapping = aes(Date, `Adj Close`)) +
  geom_area(aes(y = spy$'Adj Close'), 
            color = "springgreen4",
            fill = "palegreen1",
            alpha = 0.4) +
  scale_x_date(date_breaks = "5 year",
               date_label = "%Y") +
  scale_y_continuous(labels = dollar) +
  labs(x = "Date",
       y = "Adj. Close Price",
       title = "SPDR S&P 500 ETF Trust (SPY)",
       subtitle = "Adj. Close Price",
       caption = "Yahoo Finance") +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.background = element_blank(),
        axis.line = element_line(color = ),
        plot.title = element_text(hjust = 0.5, 
                                  size = 20, 
                                  face = "bold",
                                  color = "gray30"),
        plot.subtitle = element_text(hjust = 0.5, 
                                     size = 14, 
                                     color = "ivory4"),
        plot.caption = element_text(color = "gray60"))

line1


# (Scatterplot w/line) ----
scatter1 <- ggplot(spy_full, aes(Date, Volume)) +
  geom_point(aes(y = Volume), 
             color = "cadetblue4",
             size = 0.8) +
  geom_hline(yintercept = 0, 
             col = "slategrey", 
             linetype = "solid") +
  geom_smooth(method="loess", 
              color = "tomato3",
              alpha = 0.1,
              size = 0.7,
              linetype = "solid",
              se=F) +
  scale_x_date(date_breaks = "5 year",
               date_label = "%Y") +
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
                                  color = "gray30"),
        plot.subtitle = element_text(hjust = 0.5, 
                                     size = 10, 
                                     color = "slategrey"),
        plot.caption = element_text(color = "gray60"))

scatter1


# Lollipop Chart (includes smooth line) ----
lollipop1 <- ggplot(spy_full, aes(Date, Volume)) +
  geom_point(aes(y = Volume), 
             color = "cadetblue4",
             size = 1) +
  geom_segment(aes(x = Date, 
                   xend = Date, 
                   y = 0, 
                   yend = Volume),
               color = "skyblue",
               alpha = 0.3,
               size = 0.1) +
  geom_smooth(method="loess", 
              color = "tomato1",
              alpha = 0.1,
              size = 0.7,
              linetype = "solid",
              se=F) +
  scale_x_date(date_breaks = "2 year",
               date_label = "%Y") +
  scale_y_continuous(labels = c("0","1M","2M","3M")) +
  labs(x = "Year",
       y = "Volume",
       title = "SPDR S&P 500 ETF Weekly Volume",
       subtitle = "1993-2021",
       caption = "Yahoo Finance") +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.background = element_blank(),
        axis.line = element_line(color = ),
        plot.title = element_text(hjust = 0.5, 
                                  size = 20, 
                                  face = "bold",
                                  color = "gray30"),
        plot.subtitle = element_text(hjust = 0.5, 
                                     size = 10, 
                                     color = "slategrey"),
        plot.caption = element_text(color = "gray60"))

lollipop1


# Time Series Returns ----
returns_line <- ggplot(spy_full, aes(x = Date)) + 
  geom_line(aes(y = Returns),
            color = "steelblue") +
  geom_hline(yintercept = 0, 
             col = "tomato3", 
             linetype = "solid") +
  scale_x_date(date_breaks = "2 year",
             date_label = "%Y") +
  scale_y_continuous(breaks = c(-.2,-.15,-.1,-.05,0,.05,.1,.15),
                     labels = percent) +
  labs(x = "Date",
       y = "Return (%)",
       title = "SPDR S&P 500 ETF Weekly Returns",
       subtitle = "",
       caption = "Yahoo Finance") +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.background = element_blank(),
        axis.line = element_line(color = ),
        plot.title = element_text(hjust = 0.5, 
                                  size = 20, 
                                  face = "bold",
                                  color = "gray30"),
        plot.subtitle = element_text(hjust = 0.5, 
                                     size = 10, 
                                     color = "slategrey"),
        plot.caption = element_text(color = "gray60"))

returns_line
