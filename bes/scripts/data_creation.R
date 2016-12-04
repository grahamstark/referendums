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
# 
# This imports the SPSS version of the BES wave 9 data from here:
# http://www.britishelectionstudy.com/data-object/british-election-study-combined-wave-1-9-internet-panel/
# you need SPSS .sav file, and the questionnaire
# see: http://www.britishelectionstudy.com/bes-resources/bes-internet-panel-post-eu-referendum-survey-released-wave-9/
# 


# import from stata, SPSS
require( foreign )
require( Hmisc ) 
requirehttp://www.britishelectionstudy.com/data-object/british-election-study-combined-wave-1-9-internet-panel/( plyr ) # rename
# not used yet require( survey )

# TODO use optparse or something so we can pass file locations in 

# clear the workspace
rm(list = ls(all = TRUE));

#
#  identify 9999, 9998 everywhere as a missing value value
#
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

#
# start an output file
#
sink( "outputs/data_creation.R.log" );
#
#
# note my R won't read the stata version

is_local = FALSE

if( is_local ){
  filename = "data/BES2015_W9_Panel_v1.0.sav"
} else {
  filename = "/mnt/data/bes/BES2015_W9_Panel_v1.0.sav"
}
bes_raw <- read.spss( 
         file <- filename,
         convert.dates <- TRUE,
         convert.factors <- TRUE,
         use.missings <- TRUE,
         warn.missing.labels <- TRUE );

#
# nuke all missing/dk values
#
bes = data.frame( lapply( bes_raw, set_miss ))         
         
print( "SPSS Loaded" )         
#
# region dummies
#
# n.b label function from  Hmisc commented out everywhere since not really useable - 
# kept for documentation


bes$north_east <- bes$gor== 1 ## and humber gor == 3 ??;
label( bes$north_east) <- "North East (excl. Humberside)"

bes$north_west <- bes$gor== 2;
label( bes$north_west) <- "North West"

bes$yorkshire <- bes$gor== 3;
label( bes$yorkshire ) <- "Yorkshire"

bes$midlands <- bes$gor== 5 | bes$gor == 6;
label( bes$midlands ) <- "E&W Midlands"

bes$london     <- bes$gor== 7;
label( bes$london) <- "London"

bes$south      <- bes$gor== 8 | bes$gor == 9;
label( bes$south) <- "South of England"

bes$wales      <- bes$gor== 10;
label( bes$wales) <- "Wales"

bes$scotland <- bes$gor == 11;
label( bes$scotland) <- "Scotland" 

bes$n_ireland <- bes$gor == 12;
# not actually in the data
label( bes$n_ireland) <- "Northern Ireland" 

bes$partyIdNW3 = factor( bes$partyIdW3 )
bes$partyIdNW9 = factor( bes$partyIdW9 )

#
# If you do vote in the referendum on Britain’s membership of the European Union, 
# how do you think you will vote EULeave.. (actually, this is post-vote in W9)
# leave == 1
#
bes$vote_leave_eu <- bes$euRefVoteW9 == 1;
label( bes$vote_leave_eu) <- "EU Referendum: Voted Leave"

bes$vote_yes_scot <- bes$scotReferendumVoteW3 == 1;
label( bes$vote_yes_scot) <- "Scottish Referendum: Voted Yes"

bes$male   <- bes$gender == 1;
label( bes$male) <- "Male"

bes$female <- bes$gender == 2;
label( bes$female) <- "Female"

#
# party ID is *identifying* with that party, not necessarily who you last voted for.
#
# For Scot Ref (wave 3)
#
bes$conservative_w3 <- bes$partyIdW3 == 1
label( bes$conservative_w3 ) <- "Indentifies Conservative"

bes$labour_w3       <- bes$partyIdW3 == 2
label( bes$labour_w3 ) <- "Indentifies Labour"

bes$libdem_w3     <- bes$partyIdW3 == 3
label( bes$libdem_w3 ) <- "Indentifies Libdem"

bes$scot_nat_w3     <- bes$partyIdW3 == 4
label( bes$scot_nat_w3 ) <- "Indentifies SNP"

bes$ukip_w3         <- bes$partyIdW3 == 6
label( bes$ukip_w3 ) <- "Indentifies UKIP"

bes$green_w3        <- bes$partyIdW3 == 7
label( bes$green_w3 ) <- "Indentifies Green"
#
# EU Ref wave 9  
#
bes$conservative_w9 <- bes$partyIdW9 == 1
label( bes$conservative_w9 ) <- "Indentifies Conservative"

bes$labour_w9       <- bes$partyIdW9 == 2
label( bes$labour_w9 ) <- "Indentifies Labour"

bes$libdem_w9     <- bes$partyIdW9 == 3
label( bes$libdem_w9 ) <- "Indentifies Libdem"

bes$scot_nat_w9     <- bes$partyIdW9 == 4
label( bes$scot_nat_w9 ) <- "Indentifies SNP"

bes$ukip_w9         <- bes$partyIdW9 == 6
label( bes$ukip_w9 ) <- "Indentifies UKIP"

bes$green_w9        <- bes$partyIdW9 == 7
label( bes$green_w9 ) <- "Indentifies Green"


bes$catholic <- bes$profile_religion == 3;
label( bes$catholic) <- "Religion: Catholic"

bes$protestant <- bes$profile_religion == 2 | ( bes$profile_religion>= 4 & bes$profile_religion <= 9 ); 
label( bes$catholic) <- "Religion: Any Protestant Church"

bes$other_religion <- bes$profile_religion >= 10;
label( bes$other_religion) <- "Religion: Any Non Christian"

print( "Religions and parties created" )

# case change

bes <- rename(bes, c(Age="age"));
label( bes$age) <- "Age (in 2014)"

bes$age_square  <- bes$age*bes$age;
label( bes$age_square) <- "Age Squared"

bes$age_cubed   <- bes$age_square*bes$age;
label( bes$age_cubed) <- "Age Cubed"

bes$has_children <- bes$profile_household_children > 0;

bes$is_house_owner <- bes$housing < 2;
label( bes$is_house_owner) <- "Housing - Owned Outright or Mortaged" 
bes$is_partnered <- bes$marital == 1 | bes$marital == 2 | bes$marital == 7;
label( bes$is_partnered) <- "Has a partner" 

print( "ages created" )

#
# shorten some names for prettier output
#
bes <- rename( bes, c( personality_openness = "big5_openness" ))
label( bes$big5_openness ) <- "Big 5 Personality: Openness" 

bes <- rename( bes, c( personality_neuroticism = "big5_neuroticism" ))
label( bes$big5_neuroticism) <- "Big 5 Personality: Neuroticism" 

bes <- rename( bes, c( personality_extraversion = "big5_extraversion" ))
label( bes$big5_extraversion) <- "Big 5 Personality: Extraversion" 

bes <- rename( bes, c( personality_conscientiousness = "big5_conscientiousness" ))
label( bes$big5_conscientiousness) <- "Big 5 Personality: Conscientiousness" 

bes <- rename( bes, c( personality_agreeableness = "big5_agreeableness" ))
label( bes$big5_agreeableness) <- "Big 5 Personality: Agreeableness" 

print( "big 5 created ")

#
# hhinc as midpoints of ranges, topped at 150.000 and with D/Ks treated as missing
#
hhinc = bes$profile_gross_household; # not really needed
bes$v_hhinc[ hhinc == 1 ] <- 2500;
bes$v_hhinc[ hhinc == 2 ] <- 7500;
bes$v_hhinc[ hhinc ==  3 ] <-  12500;
bes$v_hhinc[ hhinc ==  4 ] <-  17500;
bes$v_hhinc[ hhinc ==  5 ] <-  22500;
bes$v_hhinc[ hhinc ==  6 ] <-  27500;
bes$v_hhinc[ hhinc ==  7 ] <-  32500;
bes$v_hhinc[ hhinc ==  8 ] <-  37500;
bes$v_hhinc[ hhinc ==  9 ] <-  52500;
bes$v_hhinc[ hhinc ==  10 ] <-  57500;
bes$v_hhinc[ hhinc ==  11 ] <-  55000;
bes$v_hhinc[ hhinc ==  12 ] <-  65000;
bes$v_hhinc[ hhinc ==  13 ] <-  80000;
bes$v_hhinc[ hhinc ==  14 ] <-  125000;
bes$v_hhinc[ hhinc ==  15 ] <-  150000;
bes$v_hhinc[ hhinc >=  16 ] <-  NA;

label( bes$v_hhinc) <- "Household Gross Income (£p.a)" 

bes$log_hh_inc <- log( bes$v_hhinc );
label( bes$log_hh_inc) <- "Log of Household Gross Income (£p.a)" 

print( "incomes created" )

bes$is_white_brit      <- bes$profile_ethnicity == 1;
label(  bes$is_white_brit ) <- "White British"

bes$is_white_other     <- bes$profile_ethnicity == 2;
label(  bes$is_white_other ) <- "Non British White"

bes$is_ethnic_minority <- bes$profile_ethnicity > 2;
label(  bes$is_ethnic_minority ) <- "Ethnic Minority"

# doesn't seem to be same definition as in the JRE paper
bes$a_level_equiv <- bes$education>= 11 & bes$education <= 12;
label(  bes$a_level_equiv ) <- "Highest Education: A Level/Higher Grade"

bes$other_higher_ed <- bes$education >= 13 & bes$education <= 15;
label(  bes$other_higher_ed ) <- "Highest Education: Non-Degree Further"

bes$degree_equiv <- bes$education>= 16 & bes$education <= 18;
label(  bes$degree_equiv ) <- "Highest Education: Degree or Equivalent"

# country of birth

bes$bornEngland   = bes$countryOfBirth == 1;
bes$bornScotland  = bes$countryOfBirth == 2;
bes$bornUK        = bes$countryOfBirth <= 4;
bes$bornOutsideUK = bes$countryOfBirth > 4;
bes$bornEU        = bes$countryOfBirth == 8 | bes$countryOfBirth == 5;
bes$bornOutsideEU = ! (bes$bornUK | bes$bornEU )

if( is_local ){
  save( bes, file="data/BES2015_W9_Panel_v1.0_with_added_vars.RData" )
} else {
  save( bes, file="/mnt/data/bes/BES2015_W9_Panel_v1.0_with_added_vars.RData" )
}

sink()     