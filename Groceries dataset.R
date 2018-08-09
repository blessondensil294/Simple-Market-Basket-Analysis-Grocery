install.packages("caTools")
install.packages("TSP")

library(arules)
library(TSP)
library(grid)
library(arulesViz)
library(caTools)
library(datasets)

data("Groceries")

#plot the item frequency in a histogram
itemFrequencyPlot(Groceries, topN=30, type="absolute")

#create a apriori rule with Support .001 and confidence .8
rules <- apriori(Groceries, parameter = list(supp = 0.001, conf = 0.8))
#summary of the number of rules created
summary(rules)

options(digits = 2)
#display the rules
inspect(rules[1:10])

inspect(rules[2:7])

summary(rules)

#sort the rules by confidence
rules <- sort(rules, by="confidence", decreasing = TRUE)
inspect(rules[1:5])

#sort the rules by lift
rules <- sort(rules, by="lift", decreasing = TRUE)
inspect(rules[1:5])

#to find the customer who buys the product before buying item on rhs
rules <- apriori(Groceries, parameter = list(supp = 0.001, conf = 0.35), appearance = list(default="lhs", rhs="pastry"), control = list(verbose=F))
summary(rules)
rules <- sort(rules, by="confidence", decreasing = TRUE)
inspect(rules[1:5])

#Plot the rules graph
plot(rules, method = "graph", interactive = FALSE, shading = NA)

#to find the customer who buys the product after buying item on lhs
rules <- apriori(Groceries, parameter = list(supp = 0.001, conf = 0.1), appearance = list(default="rhs", lhs="pastry"), control = list(verbose=F))
summary(rules)
rules <- sort(rules, by="confidence", decreasing = TRUE)
inspect(rules[1:5])

#Plot the rules graph
plot(rules, method = "graph", interactive = FALSE, shading = NA)
