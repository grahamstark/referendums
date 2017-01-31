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
# install.packages("PerformanceAnalytics")
library("PerformanceAnalytics")
# install.packages("corrplot")
# install.packages("polycor")
library( "corrplot")

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
setwd( "~/VirtualWorlds/projects/scotland/referendums/bes/")
sink( "outputs/regressions.article_2.log" );

is_local = FALSE;
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
#
# if you want the core subset ...
#
# besScot <- bes[ which( bes$scotland & (bes$wt_core_W3 > 0 )), ]
# print( besScot )

# summary( lm( formula=EUIntegrationSelf_dk5~log_hh_inc, data=besScot )) 

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
    "Voted Leave, Brexit",
    "Integration with Europe (Lower=would prefer more)"
);



# regression. Indieref first using the w3 scottish sample
# indieref 
#
# this is just to help Stargazer label things ..
besScot$conservative <- besScot$conservative_w3;
besScot$labour <- besScot$labour_w3;
besScot$libdem <- besScot$libdem_w3;
besScot$ukip <- besScot$ukip_w3;
besScot$green <- besScot$green_w3;
besScot$scot_nat <- besScot$scot_nat_w3;
besScot$EUIntegrationSelf_dk5 <- besScot$EUIntegrationSelfW3_dk5

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
        conservative+
        libdem+
        labour+
        green+
        ukip+
        scot_nat+
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

probit.scotref_3 <- glm(
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
        conservative +
        libdem +
        labour +
        green +
        ukip +
        scot_nat +
        catholic +
        protestant +
        big5_openness +
        scottish_city +
        scottish_highlands +
        scottish_borders +
        born_england + 
        born_eu +
        vote_leave_eu,
    family=binomial(link='probit'), 
    data=besScot );

probit.scotref_4 <- glm(
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
        conservative +
        libdem +
        labour +
        green +
        ukip +
        scot_nat +
        catholic +
        protestant +
        big5_openness +
        scottish_city +
        scottish_highlands +
        scottish_borders +
        born_england + 
        born_eu +
        EUIntegrationSelf_dk5,
    family=binomial(link='probit'), 
    data=besScot );

probit.scotswitch_yes_no <- glm(
    formula=indyref_switch_yes_2_no~
        log_hh_inc+ 
        age+ 
        age_square+ 
        female+ 
        conservative +
        libdem +
        labour +
        green +
        ukip +
        scot_nat +
        catholic+
        protestant+
        big5_openness+
        born_england + 
        EUIntegrationSelf_dk5,
    family=binomial(link='probit'), 
    data=besScot );
        
probit.indyref_not_vote_post <-glm(
    formula=indyref_didnt_vote ~
        log_hh_inc+ 
        age+ 
        age_square+ 
        female+ 
        conservative +
        libdem +
        labour +
        green +
        ukip +
        scot_nat +
        catholic+
        protestant+
        big5_openness+
        born_england + 
        EUIntegrationSelf_dk5,
    family=binomial(link='probit'), 
    data=besScot );

#
# use minimal regressors since we were getting warning messages
#
probit.scotswitch_no_yes <- glm(
    formula=indyref_switch_no_2_yes~
        log_hh_inc+ 
        age+ 
        age_square+ 
        female+ 
        conservative +
        libdem +
        labour +
        green +
        ukip +
        scot_nat +
        catholic+
        protestant+
        big5_openness+
        born_england + 
        EUIntegrationSelf_dk5,
        
    family=binomial(link='probit'), 
    data=besScot );

#
# == current choice
# rename politics stuff for StarGazer
#  
besScot$conservative <- besScot$conservative_w9;
besScot$labour <- besScot$labour_w9;
besScot$libdem <- besScot$libdem_w9;
besScot$ukip <- besScot$ukip_w9;
besScot$green <- besScot$green_w9;
besScot$scot_nat <- besScot$scot_nat_w9;
besScot$EUIntegrationSelf_dk5 <- besScot$EUIntegrationSelfW9_dk5

#
# .. add 2 to 2014 ages for brexit
#
besScot$age <- besScot$age+2;
besScot$age_square <- besScot$age*besScot$age 

probit.scotref_w9_2 <- glm(
    formula=yesW9~
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
        conservative+
        libdem+
        labour+
        green+
        ukip+
        scot_nat+
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

probit.scotref_w9_3 <- glm(
    formula=yesW9~
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
        conservative +
        libdem +
        labour +
        green +
        ukip +
        scot_nat +
        catholic +
        protestant +
        big5_openness +
        scottish_city +
        scottish_highlands +
        scottish_borders +
        born_england + 
        born_eu +
        vote_leave_eu,
    family=binomial(link='probit'), 
    data=besScot );

probit.scotref_w9_4 <- glm(
    formula=yesW9~
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
        conservative +
        libdem +
        labour +
        green +
        ukip +
        scot_nat +
        catholic +
        protestant +
        big5_openness +
        scottish_city +
        scottish_highlands +
        scottish_borders +
        born_england + 
        born_eu +
        EUIntegrationSelf_dk5,
    family=binomial(link='probit'), 
    data=besScot );


stargazer( 
        probit.scotref_2,
        probit.scotref_3,
        probit.scotref_4,
        probit.scotref_w9_2,
        probit.scotref_w9_3,
        probit.scotref_w9_4,
        probit.scotswitch_yes_no,
        probit.scotswitch_no_yes,
        probit.indyref_not_vote_post,
        covariate.labels = stdLabels, 
        dep.var.labels = c("Indyref Vote Yes", "Current Vote Yes", "Yes-No","No-Yes", "Not Likely to vote" ),
        type='html',
        report = "vc*",
        align=TRUE )
   
stargazer(         
        probit.scotref_2,
        probit.scotref_3,
        probit.scotref_4,
        probit.scotref_w9_2,
        probit.scotref_w9_3,
        probit.scotref_w9_4,
        probit.scotswitch_yes_no,
        probit.scotswitch_no_yes,
        probit.indyref_not_vote_post,
        covariate.labels = stdLabels, 
        dep.var.labels = c("Indyref Vote Yes", "Current Vote Yes", "Yes->No","No->Yes", "Not Likely to vote" ),
        type='text',
        align=TRUE )
        
stargazer(         
        probit.scotref_2,
        probit.scotswitch_yes_no,
        probit.scotswitch_no_yes,
        probit.scotref_w9_2,
        probit.scotref_w9_3,
        probit.scotref_w9_4,
        probit.indyref_not_vote_post,
        covariate.labels = stdLabels, 
        dep.var.labels = c("Indyref Vote Yes", "Current Vote Yes", "Yes->No","No->Yes", "Not Likely to vote" ),
        type='html',
        report = "vc*",
        align=TRUE )
        
print( summary( probit.scotref_2 ));
print( summary( probit.scotref_3 ));
print( summary( probit.scotref_4 ));
print( summary( probit.scotswitch_yes_no ));
print( summary( probit.scotswitch_no_yes ));
print( summary( probit.indyref_not_vote_post ));
print( summary( probit.scotref_w9_2 ));
print( summary( probit.scotref_w9_3 ));
print( summary( probit.scotref_w9_4 ));
#
# close output buffer
#
sink();
