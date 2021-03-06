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
require( plyr ) # rename
# not used yet require( survey 
        

# TODO use optparse or something so we can pass file locations in 

# clear the workspace
rm(list = ls(all = TRUE));

#
#  identify 9999, 9998 everywhere as a missing value value
#
#
# start an output file
#
setwd( "~/VirtualWorlds/projects/scotland/referendums/bes/")
sink( "outputs/data_creation.R.log" );
source( "scripts/utils.R" );        


#
#
# note my R won't read the stata version

is_local = FALSE

if( is_local ){
  filename = "data/BES2015_W9_Panel_v1.0.sav"
} else {
  filename = "/mnt/data/bes/BES2015_W9_Panel_v1.0.sav"
}
bes <- read.spss( 
         file <- filename,
         convert.dates <- TRUE,
         convert.factors <- TRUE,
         use.missings <- TRUE,
         warn.missing.labels <- TRUE );

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
# FIXME W3 (actual version) is missing

# W2 coding frame:
# Don't know 9999
# Very likely that I will vote 5 
# Fairly likely 4   
# Neither likely nor unlikely 3 
# Fairly unlikely 2 Very unlikely that I will vote 1 
# obviously this is a misnomer
bes$indyref_didnt_vote <- bes$scotReferendumTurnoutW2 <= 3;
bes$indyref_did_vote <- ! bes$indyref_didnt_vote;

label( bes$vote_yes_scot) <- "Scottish Referendum: Voted Yes"
bes$vote_no_scot <- bes$scotReferendumVoteW3 == 0;
label( bes$indyref_didnt_vote ) <- "Indyref: eligible but didn't vote"
#
# should be W3, but hey ho..
# FIXME missing in data, but we have bes$scotReferendumTurnoutW1 == 5 means 'very likely'
# bes$voted_scot <- bes$scotReferendumTurnoutW3 == 1;
# bes$did_not_vote_scot <- bes$scotReferendumTurnoutW3 == 2; 
# bes$ineligble_scot <- bes$scotReferendumTurnoutW3 > 2; 

#
# TODO turnout out of:
#
# head(bes$euRefTurnoutRetroW9,100)

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

bes$other_religion <- bes$profile_religion >= 10 & bes$profile_religion < 9999;
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

bes$is_house_owner <- bes$housing <= 3;
bes$is_renter <- ( bes$housing > 3 ) & ( bes$housing <= 7 );

label( bes$is_house_owner) <- "Housing - Owned Outright, Mortaged, Shared Ownership" 
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

bes$born_england   = bes$countryOfBirth == 1;
bes$born_scotland  = bes$countryOfBirth == 2;
bes$born_uk        = bes$countryOfBirth <= 4;
bes$born_outside_uk = bes$countryOfBirth > 4;
bes$born_eu        = bes$countryOfBirth == 8 | bes$countryOfBirth == 5;
bes$born_outside_eu = ! (bes$born_uk | bes$born_eu )

# intention waves 4,6,7,9 only
bes$yesW9 <- bes$scotReferendumIntentionW9 == 1;
bes$yesW7 <- bes$scotReferendumIntentionW7 == 1;
bes$yesW6 <- bes$scotReferendumIntentionW6 == 1;
bes$yesW4 <- bes$scotReferendumIntentionW4 == 1;

bes$noW9 <- bes$scotReferendumIntentionW9 == 0;
bes$noW7 <- bes$scotReferendumIntentionW7 == 0;
bes$noW6 <- bes$scotReferendumIntentionW6 == 0;
bes$noW4 <- bes$scotReferendumIntentionW4 == 0;

bes$notW9 <- bes$scotReferendumIntentionW9 == 2;
bes$notW7 <- bes$scotReferendumIntentionW7 == 2;
bes$notW6 <- bes$scotReferendumIntentionW6 == 2;
bes$notW4 <- bes$scotReferendumIntentionW4 == 2;

bes$dkW9 <- bes$scotReferendumIntentionW9 == 9999;
bes$dkW7 <- bes$scotReferendumIntentionW7 == 9999;
bes$dkW6 <- bes$scotReferendumIntentionW6 == 9999;
bes$dkW4 <- bes$scotReferendumIntentionW4 == 9999;

#
# if ever indicated dk or no, even if changed mind back
#
bes$indyref_dk_vote_post_any_period <- ( bes$dkW9 | bes$dkW7 | bes$dkW6 | bes$dkW4 )
bes$indyref_not_vote_post_any_period <- ( bes$notW9 | bes$notW7 | bes$notW6 | bes$notW4 )

#
# dk/ no vote in latest data only
#
bes$indyref_dk_vote_post <- ( bes$dkW9 )
bes$indyref_not_vote_post <- ( bes$notW9 )

#
# switch in latest data
#
bes$indyref_switch_yes_2_no <- bes$vote_yes_scot & ( bes$noW9 )
bes$indyref_switch_no_2_yes <- bes$vote_no_scot & ( bes$yesW9  )
bes$indyref_switch_yes_2_other <- bes$indyref_switch_yes_2_no | bes$indyref_dk_vote_post | bes$indyref_not_vote_post;

#
# switch in any period, even if now back again
#
bes$indyref_switch_yes_2_no_any_period <- bes$vote_yes_scot & ( bes$noW9 | bes$noW7 | bes$noW6 | bes$noW4 )
bes$indyref_switch_no_2_yes_any_period <- bes$vote_no_scot & ( bes$yesW9 | bes$yesW7 | bes$yesW6 | bes$yesW4 )
bes$indyref_switch_yes_2_other_any_period <- bes$indyref_switch_yes_2_no | bes$indyref_dk_vote_post | bes$indyref_not_vote_post;

print( "yes 2 no" ); summary( bes$indyref_switch_yes_2_no )
print( "yes 2 any other" ); summary( bes$indyref_switch_yes_2_other )
print( "no 2 yes" ); summary( bes$indyref_switch_no_2_yes )

#
# Scottish cities, excl Stirling
#
bes$glasgow = bes$profile_oslaua == 164;
bes$dundee  = bes$profile_oslaua == 156;
bes$edinburgh = bes$profile_oslaua == 161;
#
# Scottish Councils, crudely classified
#
bes$scottish_city =  
        # Glasgow City
        bes$profile_oslaua == 164 |  
        # Edinburgh, City of 
        bes$profile_oslaua == 161 | 
        # Dundee City  
        bes$profile_oslaua == 156 |
        # Aberdeen City                     
        bes$profile_oslaua == 148;  
#
# especially dodgy ...
#
bes$scottish_urban = 
        bes$scottish_city |
        # Renfrewshire 
        bes$profile_oslaua == 173 |
        # East Renfrewshire 
        bes$profile_oslaua == 160 |                    
        # North Lanarkshire 
        bes$profile_oslaua == 170 |                    
        # Falkirk  
        bes$profile_oslaua == 162;  

bes$scottish_highlands = 
        # Eilean Siar (H)
        bes$profile_oslaua == 179 | 
        # Shetland Islands (H)            
        bes$profile_oslaua ==  174 |             
        # Perth & Kinross (H)        
        bes$profile_oslaua ==  172 |           
        # Orkney Islands (H) 
        bes$profile_oslaua == 171 |         
        # Highland (H)
        bes$profile_oslaua == 165 |
        # Moray (H)  
        bes$profile_oslaua == 168 |     
        #Argyll & Bute (H)
        bes$profile_oslaua == 151 |
        # Aberdeenshire (H) 
        bes$profile_oslaua == 149 |
        # Angus (H)   
        bes$profile_oslaua == 150  |     
        # Aberdeen City (HCU) 
        bes$profile_oslaua == 148;

bes$scottish_borders = 
        # Dumfries & Galloway (B)
        bes$profile_oslaua == 155 |
        # Scottish Borders (B) 
        bes$profile_oslaua == 152;                  
               
#
# attitudes to EU, with DK set to midpoint,or null, and with < 5 (want less integration) dummy, waves 3 and 6 (last with question)
# should europe integrate?
#
bes$eesEUIntegrationSelfW3_dk5 <- ifelse( bes$eesEUIntegrationSelfW3 == 9999, 5, bes$eesEUIntegrationSelfW3 )
bes$eesEUIntegrationSelfW3_dknull <- ifelse( bes$eesEUIntegrationSelfW3 == 9999, NA, bes$eesEUIntegrationSelfW3 )
bes$eesEUIntegrationSelfW3_dummy <- bes$eesEUIntegrationSelfW3 < 5

bes$eesEUIntegrationSelfW6_dk5 <- ifelse( bes$eesEUIntegrationSelfW6 == 9999, 5, bes$eesEUIntegrationSelfW6 )
bes$eesEUIntegrationSelfW6_dknull <- ifelse( bes$eesEUIntegrationSelfW6 == 9999, NA, bes$eesEUIntegrationSelfW6 )
bes$eesEUIntegrationSelfW6_dummy <- bes$eesEUIntegrationSelfW6 < 5

bes$EUIntegrationSelfW3_dk5 <- ifelse( bes$EUIntegrationSelfW3 == 9999, 5, bes$EUIntegrationSelfW3 )
bes$EUIntegrationSelfW3_dknull <- ifelse( bes$EUIntegrationSelfW3 == 9999, NA, bes$EUIntegrationSelfW3 )
bes$EUIntegrationSelfW3_dummy <- bes$EUIntegrationSelfW3 < 5

bes$EUIntegrationSelfW9_dk5 <- ifelse( bes$EUIntegrationSelfW9 == 9999, 5, bes$EUIntegrationSelfW9 )
bes$EUIntegrationSelfW9_dknull <- ifelse( bes$EUIntegrationSelfW9 == 9999, NA, bes$EUIntegrationSelfW9 )
bes$EUIntegrationSelfW9_dummy <- bes$EUIntegrationSelfW9 < 5


if( is_local ){
  save( bes, file="data/BES2015_W9_Panel_v1.0_with_added_vars.RData" )
} else {
  save( bes, file="/mnt/data/bes/BES2015_W9_Panel_v1.0_with_added_vars.RData" )
}

sink()     