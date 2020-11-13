# R_scripts
Some scripts for XRPD data processing

## Whad do we do
__Data conversion and scaling__ takes single diffraction pattern in input and after a SG filtering (m = 0, p = 2, w = 5) produces four data matrices:
 * Raw smoothed data
 * Derived smoothed data with SG filtering (m = 1, p = 2, w = 5)
 * Autoscaled / Standardized raw smoothed data
 * Derived and autoscaled smoothed data
 Data matrices are then exported in .xlsx files with headers.
 
 __Data conversion and scaling 2__ takes an .xlsx data matrix and converts it recursively to single .txt files
 
 
