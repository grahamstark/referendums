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
is_local = FALSE;
setwd( "~/VirtualWorlds/projects/scotland/referendums/bes/")
if( is_local ){
        load( "data/BES2015_W9_Panel_v1.0_with_added_vars.RData", verbose=TRUE )
} else {
        load( "/mnt/data/bes/BES2015_W9_Panel_v1.0_with_added_vars.RData", verbose=TRUE )
}

                
sink( "outputs/regressions.article_2.log" );

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
    "North East",
    "North West of England",
    "Yorkshire and Humberside",
    "London",
    "South of England",
    "Wales",
    "Scotland",
    "Voted Yes in IndieRef"
)


        # regression. Indieref first using the w3 scottish sample
        # indieref 
        #
        probit.scotref_1 <- glm(
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
                is_partnered,
            family=binomial(link='probit'), 
            data=besScotW3 );


sink();
