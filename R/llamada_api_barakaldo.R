#' @title llamada api
#'
#' @description llamada api
#'
#' @param url
#'
#' @return json
#'
#' @examples  llamada_api_url("https://www.barakaldo.eus/axis2/services/BarakaldoServices/actosFecha?response=application/json&fecha=2018-06-15&X-JWT-Assertion=")
#'
#' @import httr
#' jsonlite
#' rjson
#' RCurl
#' dplyr
#'
#' @export

llamada_api_url <- function(url){

  url <- as.character(url)
  # ==============================================================================
  # PETICIÓN TOKEN API Barakaldo
  # ==============================================================================

  url_peticion_token <- "https://www.barakaldo.eus/axis2/services/BarakaldoServices/login?response=application/json&userName=ws_muvi&password=nemivum_swCPRhX"
  peticion <- GET(url_peticion_token)
  resultado_peticion_token <- httr::content(peticion)
  resultado_peticion_token <- unname(unlist(resultado_peticion_token))

  jwt <- resultado_peticion_token

  # ==============================================================================
  # PETICIÓN actos fecha
  # ==============================================================================

  url_peticion <- paste(url,jwt,sep = "")
  peticion <- GET(url_peticion)
  resultado_peticion <- httr::content(peticion, "text")

  resultado_peticion <- toJSON(resultado_peticion)

  return(resultado_peticion)
}
