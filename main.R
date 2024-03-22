library(tercen)
library(dplyr)
ctx <- tercenCtx()

rlm.residuals = function(df){
  fit =  df %>% 
    MASS::rlm(.y ~.x, data = .)
  
  df %>% 
    mutate(residual = residuals(fit)) %>% 
    dplyr::select(.sids, residual)
}

iqrDetect = function(x, thr = 1.5){
  q = quantile(x, c(.25, .75))
  iqr = q[2]- q[1]
  ulim = q[2] + thr*iqr
  llim = q[1] - thr*iqr
  (x<llim) | (x>ulim)
}

threshold <- ctx$op.value('Threshold', as.numeric, 1.5)

if(ctx$hasXAxis){
  # use rlm regression
  result = ctx  %>% 
    select(.ci, .ri, .sids, .y, .x) %>% 
    group_by(.ci, .ri) %>% 
    do(rlm.residuals(.)) %>% 
    mutate(outlier = iqrDetect(residual, threshold) %>%  as.numeric) %>% 
    ungroup()

}else{
  result = ctx %>% 
    select(.ci, .ri, .y) %>% 
    group_by(.ci, .ri) %>% 
    mutate(outlier = iqrDetect(.y, threshold) %>%  as.numeric) %>% 
    select(.ci, .ri,.sids,  outlier) %>% 
    ungroup()
}

result %>% 
  ctx$addNamespace() %>% 
  ctx$save()




