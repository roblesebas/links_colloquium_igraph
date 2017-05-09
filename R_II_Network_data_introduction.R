# Descriptive Analysis

# Getting data ####

# Importing edge list in a csv format, later we need to 
# convert it in a graph object

edge.list <- read.csv("SNOrganization_papers_edges.csv", stringsAsFactors = FALSE)
View(edge.list)

vertices.attributes <- read.csv("SNOrganization_papers_vertices.csv", stringsAsFactors = FALSE)
View(vertices.attributes)

net <- graph.data.frame(edge.list, directed = TRUE, vertices.attributes)

summary(net)

# Exploratory Analysis ####

network.metrics <- data.frame(
        id = V(net)$name,
        label = V(net)$label,
        indegree = degree(net, mode = "in"),
        outdegree = degree(net, mode = "out"),
        bet = betweenness(net)
)

View(network.metrics)


# Finding the most relevant papers in our graph  ####

# Seminals 

seminals <- network.metrics[network.metrics$outdegree == 0,
                           c("id","label","indegree")]

seminals <- head(seminals[with(seminals, order(-indegree)),], 10)

View(seminals)

# Structurals

structurals <- network.metrics[network.metrics$bet > 0,
                           c("id","label","bet")]

structurals <- head(structurals[with(structurals, order(-bet)),], 10)

View(structurals)

# Current

current <- network.metrics[network.metrics$indegree == 0,
                           c("id","label","outdegree")]

current <- head(current[with(current, order(-outdegree)),], 10)

View(current)