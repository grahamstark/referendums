# 
# R Script to create Probit regressions on subsets of the British Electoral Survey (BES)
# dataset  
# By Graham Stark (graham.stark@virtual-worlds-research.com)
# (c) 2016 Virtual Worlds Research Ltd.
#
# This software is distributed under the terms of the GNU General
# Public License, either Version 2, June 1991 or Version 3, June 2007.
# Copies of both versions 2 and 3 of the license can be found
# at https://www.R-project.org/Licenses/.
# 

# pretty print regressions          
require( stargazer )
# weighted regressions, tables
# require( survey ) - not actually used yet
# support for binary regression diagnostics
# require( aod )
# Tufte style plots
require( ggplot2 )
#
# to install, for example, weights for 1st time, do: install.package( 'weights' ) 
#

# clear the workspace
rm(list = ls(all = TRUE));

#
# start an output file somewhere
#
#
# the converted dataset
#
# local version: 
sink( "outputs/regressions.article_2.log" );

is_local = FALSE;
setwd( "~/VirtualWorlds/projects/scotland/referendums/bes/")
source( "scripts/utils.R" );

if( is_local ){
        load( "data/BES2015_W9_Panel_v1.0_with_added_vars.RData", verbose=TRUE )
} else {
        load( "/mnt/data/bes/BES2015_W9_Panel_v1.0_with_added_vars.RData", verbose=TRUE )
}

#
# nuke all missing/dk values
#
bes = data.frame( lapply( bes, set_miss )) 

#
# everybody, inc. non-core
#
besScot <- bes[ which( bes$scotland ), ]

# print( besScot )

stdLabels = c(         
    "Log of Household Gross Income (£p.a)",
    "Age",
    "Age Squared",
    "Female",
    "Highest Education: A Level/Higher Grade",
    "Highest Education: Non-Degree Further",
    "Highest Education: Degree or Equivalent",
    "Ethnic Minority",
    "Has Children",
    "Has a Partner",
    "Identifies Conservative", 
    "Identifies Libdem",
    "Identifies Labour",
    "Identifies Green",
    "Identifies UKIP",
    "Identifies SNP",
    "Religion: Catholic",
    "Religion: Any Protestant",
    "Big5: Openness",
    "Lives in Scottish City",
    "Lives in Highlands",
    "Lives in Borders",
    "Born in England",
    "Born in EU",
    "Homeowner"    
);

# regression. Indieref first using the w3 scottish sample
# indieref 
#
probit.scotref_1 <- glm(
    formula=vote_yes_scot~
        log_hh_inc+ 
        age+ 
        age_square + 
        female+ 
        a_level_equiv +
        other_higher_ed + 
        degree_equiv +
        is_ethnic_minority+ 
        has_children+ 
        is_partnered +
        conservative_w3 +
        libdem_w3 +
        labour_w3 +
        green_w3 +
        ukip_w3 +
        scot_nat_w3 +
        catholic +
        protestant +
        big5_openness +
        scottish_city +
        scottish_highlands +
        scottish_borders +
        born_england + 
        born_eu +
        is_house_owner,
    family=binomial(link='probit'), 
    data=bes );

probit.scotref_2 <- glm(
    formula=vote_yes_scot~
        log_hh_inc+ 
        age+ 
        age_square+ 
        female+ 
        a_level_equiv +
        other_higher_ed + 
        degree_equiv +
        is_ethnic_minority+ 
        has_children+ 
        is_partnered +
        conservative_w3+
        libdem_w3+
        labour_w3+
        green_w3+
        ukip_w3+
        scot_nat_w3+
        catholic+
        protestant+
        big5_openness+
        scottish_city+
        scottish_highlands+
        scottish_borders +
        born_england + 
        born_eu,
    family = binomial(link='probit'), 
    data = besScot );

probit.scotswitch_yes_no <- glm(
    formula=indyref_switch_yes_2_no~
        log_hh_inc+ 
        age+ 
        age_square+ 
        female+ 
        a_level_equiv +
        other_higher_ed + 
        degree_equiv +
        is_ethnic_minority+ 
        has_children+ 
        is_partnered +
        conservative_w3 +
        libdem_w3 +
        labour_w3 +
        green_w3 +
        ukip_w3 +
        scot_nat_w3 +
        catholic+
        protestant+
        big5_openness+
        scottish_city +
        scottish_highlands +
        scottish_borders +
        born_england + 
        born_eu,
    family=binomial(link='probit'), 
    data=besScot );
        
probit.indyref_not_vote_post <-glm(
    formula=indyref_not_vote_post ~
        log_hh_inc+ 
        age+ 
        age_square+ 
        female+ 
        a_level_equiv +
        other_higher_ed + 
        degree_equiv +
        is_ethnic_minority+ 
        has_children+ 
        is_partnered +
        conservative_w3 +
        libdem_w3 +
        labour_w3 +
        green_w3 +
        ukip_w3 +
        scot_nat_w3 +
        catholic+
        protestant+
        big5_openness+
        scottish_city +
        scottish_highlands +
        scottish_borders +
        born_england + 
        born_eu,
    family=binomial(link='probit'), 
    data=besScot );
        
probit.scotswitch_no_yes <- glm(
    formula=indyref_switch_no_2_yes~
        log_hh_inc+ 
        age+ 
        age_square+ 
        female+ 
        a_level_equiv +
        other_higher_ed + 
        degree_equiv +
        is_ethnic_minority+ 
        has_children+ 
        is_partnered +
        conservative_w3 +
        libdem_w3 +
        labour_w3 +
        green_w3 +
        ukip_w3 +
        scot_nat_w3 +
        catholic+
        protestant+
        big5_openness+
        scottish_city +
        scottish_highlands +
        scottish_borders +
        born_england + 
        born_eu,
    family=binomial(link='probit'), 
    data=besScot );

stargazer( 
        probit.scotref_1,
        probit.scotref_2,
        probit.scotswitch_yes_no,
        probit.scotswitch_no_yes,
        probit.indyref_not_vote_post,
        covariate.labels = stdLabels, 
        dep.var.labels = c("Vote Yes", "Yes-No","No-Yes", "Not Likely to vote" ),
        type='html',
        report = "vc*",
        align=TRUE )
   
stargazer(         
        probit.scotref_2,
        probit.scotref_1,
        probit.scotswitch_yes_no,
        probit.scotswitch_no_yes,
        probit.indyref_not_vote_post,
        covariate.labels = stdLabels, 
        dep.var.labels = c("Vote Yes", "Yes->No","No->Yes", "Not Likely to vote" ),
        type='text',
        align=TRUE )
        
        
print( summary( probit.scotref_1 ));
print( summary( probit.scotref_2 ));
print( summary( probit.scotswitch_yes_no ));
print( summary( probit.scotswitch_no_yes ));
print( summary( probit.indyref_not_vote_post ));
        

#
# close output buffer
#
sink();