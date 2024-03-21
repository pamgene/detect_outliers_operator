library(tercen)
library(MASS)
library(dplyr)
ctx <- tercenCtx()

rlm.residuals = function(df){
  fit =  df %>% 
    rlm(y ~x, data = .)
  
  df %>% 
    mutate(residual = residuals(fit)) %>% 
    dplyr::select(residual)
}

if(ctx$hasXAxis){
  # use rlm regression
  resdf = ctx  %>% 
    dplyr::select(.ci, .ri, .y) %>% 
    bind_cols(ctx$select(ctx$xAxis)) %>% 
    setNames(c(".ci", ".ri", "y", "x")) %>% 
    group_by(.ci, .ri) %>% 
    do(rlm.residuals(.))
    
}



