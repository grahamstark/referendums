# 
# R Script to create some variables for the British Electoral Survey (BES)
# dataset  
# 
# By Graham Stark (graham.stark@virtual-worlds-research.com)
# (c) 2016 Virtual Worlds Research Ltd.
#
# This software is distributed under the terms of the GNU General
# Public License, either Version 2, June 1991 or Version 3, June 2007.
# Copies of both versions 2 and 3 of the license can be found
# at https://www.R-project.org/Licenses/.
# shared functions

set_miss <- function ( v ){
    if( is.factor( v )){
        v[ ( as.numeric( v ) == 9999 ) ] <- NA
        v[ ( as.numeric( v ) == 9998 ) ] <- NA
        v[ ( as.numeric( v ) < 0 ) ] <- NA
    } else {
        v[ ( v == 9999 ) ] <- NA
    }
    return( v )
}


