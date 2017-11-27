---
title: "README.md"
author: "Daniel Kang"
date: "11/26/2017"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

```{r}
library(shiny)

runGithub("stat133-hws-fall17", "daniel1001a", subdir = "hw04/app")
```