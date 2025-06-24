#!/usr/bin/env Rscript

# Forcer le chargement du package 'utils' pour accès à install.packages
if (!"utils" %in% .packages()) {
  suppressMessages(library(utils))
}

# Définir le miroir CRAN par défaut
set_repos <- function(CRAN = "https://cran.rstudio.com/", ...) {
  repos <- c(CRAN = CRAN, unlist(list(...)))
  r <- getOption("repos")
  for (n in names(repos)) r[n] <- repos[n]
  options(repos = r)
}

# Options de démarrage avancées
set_startup_options <- function(...) {
  width <- tryCatch(cli::console_width(), error = function(e) 80L)
  cores <- max(1L, parallel::detectCores() - 1L)

  options(
    digits = 4L,
    show.signif.stars = FALSE,
    useFancyQuotes = FALSE,
    width = width,
    Ncpus = cores,
    continue = " ",
    max.print = 100L,
    servr.daemon = TRUE,
    max = 10L,
    mc.cores = cores,
    warnPartialMatchArgs = TRUE,
    warnPartialMatchDollar = TRUE,
    warnPartialMatchAttr = TRUE,
    scipen = 999L,
    HTTPUserAgent = sprintf("R/%s R (%s)", getRversion(), paste(getRversion(), R.version$platform, R.version$arch, R.version$os)),
    download.file.extra = sprintf("--header \"User-Agent: R (%s)\"", paste(getRversion(), R.version$platform, R.version$arch, R.version$os)),
    setWidthOnResize = TRUE,
    show.error.locations = TRUE,
    check.bounds = FALSE,
    menu.graphics = FALSE,
    ...
  )

  # Utiliser rlang::entrace pour le traçage des erreurs si disponible
  if (requireNamespace("rlang", quietly = TRUE)) {
    options(error = rlang::entrace)
  }

  utils::rc.settings(ipck = TRUE)
}

# Application automatique au démarrage
set_repos()
set_startup_options()

# Chargement de packages utiles si en session interactive
if (interactive()) {
  message("Bienvenue dans R ", getRversion(), " (", R.version$platform, ")")

  safe_load_package <- function(pkg) {
    if (!requireNamespace(pkg, quietly = TRUE)) {
      if (exists("install.packages", mode = "function")) {
        install.packages(pkg)
      } else {
        message(sprintf("⚠️  install.packages non disponible pour installer '%s'", pkg))
      }
    }
    suppressMessages(library(pkg, character.only = TRUE))
  }

  invisible(lapply(c("data.table", "ggplot2", "dplyr", "bench"), safe_load_package))
}

# Activer renv si présent
if (file.exists("renv/activate.R")) {
  source("renv/activate.R")
}
