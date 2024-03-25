# Outlier Detection operator for Tercen

##### Description

`Outlier Detection` operator performs outlier detection using the IQR method. 


##### Usage

- Outlier detection will be performed per cell of the Tercen cross-tab
- Outlier detection will not worl properly if the number of values per cell is too low 


Input projection|.
---|---
`y-axis` | values to perfrom outlier detection on
`x-axis` | optional x-axis to stratify outlier detection within a cell

Input parameters|.
---|---
`Threshold`   | numeric, threshold for outlier detection. Higher value means less sensitive for outliers (dft = 1.5)

Output relations|.
---|---
.|Table with input values and an associated outlier flag (0: FALSE,1: TRUE)

##### Details





 
 
