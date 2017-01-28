# 
# R Script to make using it slightly less painful
# 
# By Graham Stark (graham.stark@virtual-worlds-research.com)
# (c) 2016 Virtual Worlds Research Ltd.
#
# This software is distributed under the terms of the GNU General
# Public License, either Version 2, June 1991 or Version 3, June 2007.
# Copies of both versions 2 and 3 of the license can be found
# at https://www.R-project.org/Licenses/.
# shared functions

require( stargazer )

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


make_vector <- function( length, val ){
        x = vector( "numeric", length );
        x = replace( x, x == 0, val );
        return( x );
}

unit_vector <- function( length ){
        return( make_vector( length, 1 ));
}

#
# fixme: how to I get the labels alongside the counts?
#
dump_as_factor_table <- function( some_var ){
        f1 = factor( some_var, exclude=NULL )
        rlabels <- attr( some_var, "value.labels" ); 
        f2 = unit_vector( length( some_var ))
        tab = ftable( f1, f2 )
        stargazer( tab, type="text" )
        print( rlabels )
}