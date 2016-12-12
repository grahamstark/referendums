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
sink( "outputs/regressions.R.log" );
#
# the converted dataset
#
# local version: 
is_local = FALSE;
if( is_local ){
        load( "data/BES2015_W9_Panel_v1.0_with_added_vars.RData", verbose=TRUE )
} else {
        load( "/mnt/data/bes/BES2015_W9_Panel_v1.0_with_added_vars.RData", verbose=TRUE )
}

print( "dataset loaded" )

# Scotland only core subsets, waves 3 (indie) and 9 (brexit)
#
besScotW3 <- bes[ which( bes$scotland & (bes$wt_core_W3 > 0 )), ]
besScotW9 <- bes[ which( bes$scotland & (bes$wt_core_W9 > 0 )), ]
# GB wave 9 core
besFullW9 <- bes[ which( bes$wt_core_W9 > 0 ), ]
besScotFull <- bes[ which( bes$scotland ), ]

#        
# note: is_house_owner is dropped from this version since lots of missing and values not in docs
# note: possibly? weights=besScot$wt_full_W3 etc. (No - so much missing data that it probably 
# makes things worse).
#
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
        
stdLabels_2 <- stdLabels[ -length( stdLabels )] # remove last indieref vote
#
# for Indieref regressions, we need to 
# map the w_3/w_9 parties. This is just to make the regression labelling using stargazer a bit easier
# since we can use the same party variable names as in the EU regressions
#
besScotW3$conservative <- besScotW3$conservative_w3;
besScotW3$labour <- besScotW3$labour_w3;
besScotW3$libdem <- besScotW3$libdem_w3;
besScotW3$ukip <- besScotW3$ukip_w3;
besScotW3$green <- besScotW3$green_w3;
besScotW3$scot_nat <- besScotW3$scot_nat_w3;

besScotW9$conservative <- besScotW9$conservative_w9;
besScotW9$labour <- besScotW9$labour_w9;
besScotW9$libdem <- besScotW9$libdem_w9;
besScotW9$ukip <- besScotW9$ukip_w9;
besScotW9$green <- besScotW9$green_w9;
besScotW9$scot_nat <- besScotW9$scot_nat_w9;

besScotFull$conservative <- besScotFull$conservative_w9;
besScotFull$labour <- besScotFull$labour_w9;
besScotFull$libdem <- besScotFull$libdem_w9;
besScotFull$ukip <- besScotFull$ukip_w9;
besScotFull$green <- besScotFull$green_w9;
besScotFull$scot_nat <- besScotFull$scot_nat_w9;

besFullW9$conservative <- besFullW9$conservative_w9;
besFullW9$labour <- besFullW9$labour_w9;
besFullW9$libdem <- besFullW9$libdem_w9;
besFullW9$ukip <- besFullW9$ukip_w9;
besFullW9$green <- besFullW9$green_w9;
besFullW9$scot_nat <- besFullW9$scot_nat_w9;

#
# .. add 2 to 2014 ages for brexit
#
besScotW9$age <- besScotW9$age+2;
besScotW9$age_square <- besScotW9$age*besScotW9$age 

besFullW9$age <- besFullW9$age+2;
besFullW9$age_square <- besFullW9$age*besFullW9$age 

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
        
        
probit.scotref_2<- glm(
    formula=vote_yes_scot~
        log_hh_inc+ 
        age+ 
        age_square+
        female+ 
        a_level_equiv+ 
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
        scot_nat,        
    family=binomial(link='probit'), 
    data=besScotW3 );
        
probit.scotref_3 <- glm(
    formula=vote_yes_scot~
        log_hh_inc+ 
        age+ 
        age_square+ 
        female+ 
        a_level_equiv+ 
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
        protestant,
    family=binomial(link='probit'), 
    data=besScotW3 );
        
probit.scotref_4 <- glm(
    formula=vote_yes_scot~
        log_hh_inc+ 
        age+ 
        age_square+ 
        female+ 
        a_level_equiv+ 
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
        big5_openness,        
    family=binomial(link='probit'), 
    data=besScotW3 );
#
# EU Ref regressions on the full w9 sample
#
probit.euref_1 <- glm(
    formula=vote_leave_eu~
        log_hh_inc+ 
        age+ 
        age_square+ 
        female+ 
        a_level_equiv+ 
        other_higher_ed + 
        degree_equiv +
        is_ethnic_minority+ 
        has_children+ 
        is_partnered,
    family=binomial(link='probit'), 
    data=besFullW9 );

probit.euref_2 <- glm(
    formula=vote_leave_eu~
        log_hh_inc+ 
        age+ 
        age_square+ 
        female+ 
        a_level_equiv+ 
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
        scot_nat,
    family=binomial(link='probit'), 
    data=besFullW9 );
       
probit.euref_3 <- glm(
    formula=vote_leave_eu~
        log_hh_inc+ 
        age+ 
        age_square+ 
        female+ 
        a_level_equiv+ 
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
        protestant,
    family=binomial(link='probit'), 
    data=besFullW9 );
        
probit.euref_4 <- glm(
    formula=vote_leave_eu~
        log_hh_inc+ 
        age+ 
        age_square+ 
        female+ 
        a_level_equiv+ 
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
        big5_openness,
    family=binomial(link='probit'), 
    data=besFullW9 );
        
probit.euref_5 <- glm(
    formula=vote_leave_eu~
        log_hh_inc+ 
        age+ 
        age_square+ 
        female+ 
        a_level_equiv+ 
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
        # regions relative to Midlands
        north_east+  
        north_west+
        yorkshire+
        london+
        south+
        wales+
        scotland,
        
    family=binomial(link='probit'), 
    data=besFullW9 );
                
        
probit.euref_scot_only_1 <- glm(
    formula=vote_leave_eu~
        log_hh_inc+ 
        age+ 
        age_square+ 
        female+ 
        a_level_equiv+ 
        other_higher_ed + 
        degree_equiv +
        is_ethnic_minority+ 
        has_children+ 
        is_partnered,
    family=binomial(link='probit'), 
    data=besScotW9 );

probit.euref_scot_only_2 <- glm(
    formula=vote_leave_eu~
        log_hh_inc+ 
        age+ 
        age_square+ 
        female+ 
        a_level_equiv+ 
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
        scot_nat,
    family=binomial(link='probit'), 
    data=besScotW9 );
       
probit.euref_scot_only_3 <- glm(
    formula=vote_leave_eu~
        log_hh_inc+ 
        age+ 
        age_square+ 
        female+ 
        a_level_equiv+ 
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
        protestant,
    family=binomial(link='probit'), 
    data=besScotW9 );
        
probit.euref_scot_only_4 <- glm(
    formula=vote_leave_eu~
        log_hh_inc+ 
        age+ 
        age_square+ 
        female+ 
        a_level_equiv+ 
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
        big5_openness,
    family=binomial(link='probit'), 
    data=besScotW9 );

probit.euref_scot_only_5 <- glm(
    formula=vote_leave_eu~
        log_hh_inc+ 
        age+ 
        age_square+ 
        female+ 
        a_level_equiv+ 
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
        vote_yes_scot, 
    family=binomial(link='probit'), 
    data=besScotFull ); # full scottish ample, since w3 and w9 both in there

probit.euref_scot_only_6 <- glm(
  formula=vote_leave_eu~
        log_hh_inc+ 
        age+ 
        age_square+ 
        female+ 
        a_level_equiv+ 
        other_higher_ed + 
        degree_equiv +
        is_ethnic_minority+ 
        has_children+ 
        is_partnered +
        vote_yes_scot, 
  family=binomial(link='probit'), 
  data=besScotFull );  # full scottish ample, since w3 and w9 both in there

#
# print a monster side-by-side table, as plain text
# see: http://jakeruss.com/cheatsheets/stargazer.html 
#
stargazer( probit.scotref_1,
           probit.scotref_2, 
           probit.scotref_3,
           probit.scotref_4,
           probit.euref_1,
           probit.euref_2,
           probit.euref_3,
           probit.euref_4,
           probit.euref_5,
           probit.euref_scot_only_1,
           probit.euref_scot_only_2,
           probit.euref_scot_only_3,
           probit.euref_scot_only_4,
           probit.euref_scot_only_5,
           probit.euref_scot_only_6,
           
           covariate.labels = stdLabels, 
           dep.var.labels = c("Voted Yes in Scottish Referendum","Voted Leave in EU Ref" ),
           type='text',
           column.labels   = c("Scotland Only", "All GB", "Scotland Only" ),
           column.separate = c(4, 5, 6),
           align=TRUE )

#
# this is tge little one from the main paper - just indie, brexit(uk), brexit(scot)
#
stargazer( probit.scotref_4,
           probit.euref_5,
           probit.euref_scot_only_4,
           covariate.labels = stdLabels_2, 
           dep.var.labels = c("Voted 'Yes' in Scottish Referendum","Voted 'Leave' in EU Ref" ),
           type='text',
           column.labels   = c("Scotland Only", "All GB", "Scotland Only" ),
           column.separate = c(1, 1, 1),
           align=TRUE )
           
           
stargazer( probit.scotref_4,
           probit.euref_4,
           probit.euref_5,
           probit.euref_scot_only_4,
           probit.euref_scot_only_5,
           probit.euref_scot_only_6,
           covariate.labels = stdLabels, 
           dep.var.labels = c("Voted Yes in Scottish Referendum","Voted Leave in EU Ref" ),
           type='text',
           column.labels   = c("Scotland Only", "All GB", "Scotland Only" ),
           column.separate = c(1, 2, 3),
           align=TRUE )
#
# repeat for html tables - not a loop since we also want to mess with 'report' options
#
stargazer( probit.scotref_1,
           probit.scotref_2, 
           probit.scotref_3,
           probit.scotref_4,
           probit.euref_1,
           probit.euref_2,
           probit.euref_3,
           probit.euref_4,
           probit.euref_5,
           probit.euref_scot_only_1,
           probit.euref_scot_only_2,
           probit.euref_scot_only_3,
           probit.euref_scot_only_4,
           probit.euref_scot_only_5,
           probit.euref_scot_only_6,
           
           covariate.labels = stdLabels, 
           dep.var.labels = c("Voted Yes in Scottish Referendum","Voted Leave in EU Ref" ),
           type='html',
           column.labels   = c("Scotland Only", "All GB", "Scotland Only" ),
           column.separate = c(4, 5, 6),
           align=TRUE )

stargazer( probit.scotref_4,
           probit.euref_4,
           probit.euref_5,
           probit.euref_scot_only_4,
           probit.euref_scot_only_5,
           probit.euref_scot_only_6,
           covariate.labels = stdLabels, 
           dep.var.labels = c("Voted Yes in Scottish Referendum","Voted Leave in EU Ref" ),
           type='html',
           column.labels   = c("Scotland Only", "All GB", "Scotland Only" ),
           column.separate = c(1, 2, 3 ),
           align=TRUE )

stargazer( probit.scotref_4,
           probit.euref_4,
           probit.euref_5,
           probit.euref_scot_only_4,
           probit.euref_scot_only_5,
           probit.euref_scot_only_6,
           covariate.labels = stdLabels, 
           dep.var.labels = c("Voted Yes in Scottish Referendum","Voted Leave in EU Ref" ),
           type='html',
           report = "vc*",
           column.labels   = c("Scotland Only", "All GB", "Scotland Only" ),
           column.separate = c(1, 2, 3 ),
           align=TRUE )

stargazer( probit.scotref_4,
           probit.euref_5,
           probit.euref_scot_only_4,
           covariate.labels = stdLabels_2, 
           dep.var.labels = c("Voted Yes in Scottish Referendum","Voted Leave in EU Ref" ),
           type='html',
           report = "vc*",
           column.labels   = c("Scotland Only", "All GB", "Scotland Only" ),
           column.separate = c(1, 1, 1),
           align=TRUE )
           
# TODO some nice prediction charts, see           
# http://www.ats.ucla.edu/stat/r/dae/probit.htm
#
# dummyData <- data.frame(
#    age = rep( seq(from = 18, to = 100, length.out = 100 ), 4 * 4),
#    gpa = rep(c(2.5, 3, 3.5, 4), each = 100 * 4),
#    rank = factor(rep(rep(1:4, each = 100), 4)))
#
#preds <- data.frame();
#    
#preds[ c("scotref_4_p", "scotref_4_se") ] <- predict( 
#        probit.scotref_4, besScotW3,
#        type = "response", 
#        se.fit=TRUE )[3]
#
#ggplot( besScotW3, aes(x = age, y = scotref_4_p, colour = 10 )) +
#    geom_line() + facet_wrap(~age)

# TODO lots of nice crosstabs using Survey
# simple unweighted one ... 
scotVsBrexTab = table( 
    besScotW3$vote_yes_scot, 
    besScotW3$vote_leave_eu )
stargazer( scotVsBrexTab, ## todo check what's possible here
           type='text',
           column.labels  = c("Vote No", "Vote Yes" ),
           row.labels   = c("Vote Leave", "Vote Remain" ))
#
# diagnostics for the probits
#
print( summary( probit.scotref_1 ));
print( summary( probit.scotref_2 )); 
print( summary( probit.scotref_3 ));
print( summary( probit.scotref_4 ));
print( summary( probit.euref_1 ));
print( summary( probit.euref_2 ));
print( summary( probit.euref_3 ));
print( summary( probit.euref_4 ));
print( summary( probit.euref_5 ));
print( summary( probit.euref_scot_only_1 ));
print( summary( probit.euref_scot_only_2 ));
print( summary( probit.euref_scot_only_3 ));
print( summary( probit.euref_scot_only_4 ));

#
# dump summaries of all the data
print("Scottish Sample; W3 Core")
stargazer( besScotW3, type='text' )
print("Scottish Sample; W9 Core")
stargazer( besScotW9, type='text' )
print("GB Sample; W9 Core")
stargazer( besFullW9, type='text' )

#
# ========== calculations for example people
# 1) scotref
scotCoeffs = probit.scotref_4$coefficients
scotBrexitCoeffs = probit.euref_scot_only_4$coefficients
brexitCoeffs = probit.euref_5$coefficients
#
# set up a sample person: 30 yo female with below degree education
#
mean_inc_scot   = mean(besScotW3$v_hhinc[! is.na( besScotW3$v_hhinc )])
median_inc_scot   = median(besScotW3$v_hhinc[! is.na( besScotW3$v_hhinc )])
age                = 30
female             = 1
a_level_equiv      = 0
other_higher_ed    = 1
degree_equiv       = 0
is_ethnic_minority = 0
has_children       = 0
is_partnered       = 1
conservative       = 0
libdem             = 0
labour             = 0
green              = 0
ukip               = 0
scot_nat           = 0
catholic           = 0
protestant         = 0
big5_openness      =  mean(besScotW3$big5_openness[! is.na( besScotW3$big5_openness )])
north_east         = 0  
north_west         = 0
yorkshire          = 0
london             = 0
south              = 0
wales              = 0
scotland           = 0


# prob of that person voting 'Yes' in indieref
#
# female, average hhld income, all else off by default
#


scotProbsIndie <- data.frame(
        ages <- rep( seq( 16, 80 , by = 1 ), 6 ),
        cases <- c( rep( "Female", 65 ), rep( "Male", 65 ), rep( "SNP", 65 ), rep( "Conservative", 65 ), rep( "Labour", 65 ), rep( "Protestant", 65 )),
        probYes <- rep( 0.0, 65*6 ))
scotProbsBrexit <- data.frame(
        ages <- rep( seq( 16, 80 , by = 1 ), 6 ),
        cases <- c( rep( "Female", 65 ), rep( "Male", 65 ), rep( "SNP", 65 ), rep( "Conservative", 65 ), rep( "Labour", 65 ), rep( "Protestant", 65 )),
        probLeave <- rep( 0.0, 65*6 ))
probsBrexit <- data.frame(
        ages <- rep( seq( 16, 80 , by = 1 ), 6 ),
        cases <- c( rep( "Female", 65 ), rep( "Male", 65 ), rep( "SNP", 65 ), rep( "Conservative", 65 ), rep( "Labour", 65 ), rep( "Protestant", 65 )),
        probLeave <- rep( 0.0, 65*6 ))

j = 0

print( "age,case,prob_scotref,prob_brexit_scot,prob_brexit " )
for( case in seq( 1 , 6, by = 1 )){
        female             = 1
        conservative       = 0
        libdem             = 0
        labour             = 0
        scot_nat           = 0
        protestant         = 0
        if( case == 1 ){
                ;
        } else if( case == 2 ){
                female = 0
        } else if( case == 3 ){
                scot_nat = 1;
        } else if( case == 4 ){
                conservative = 1;
        } else if( case == 5 ){
                labour = 1;
        } else if( case == 6 ){
                protestant = 1;
        }
        for( age in seq( 16, 80 , by = 1 )){
                j = j + 1
                person = c( 
                        1, 
                        log(median_inc_scot), 
                        age, 
                        age**2,  
                        female,
                        a_level_equiv,
                        other_higher_ed,
                        degree_equiv,
                        is_ethnic_minority,
                        has_children,
                        is_partnered,
                        conservative,
                        libdem,
                        labour,
                        green,
                        ukip,
                        scot_nat,
                        catholic,
                        protestant,
                        big5_openness,
                        north_east,   
                        north_west,   
                        yorkshire,    
                        london,       
                        south,        
                        wales,        
                        scotland     
                        );
              scotProbsIndie$probYes[j] = pnorm( sum( scotCoeffs*person[1:length(scotCoeffs)] ))*100.0
              scotProbsBrexit$probLeave[j] = pnorm( sum( scotBrexitCoeffs*person[1:length(scotCoeffs)] ))*100.0
              probsBrexit$probLeave[j] = pnorm( sum( brexitCoeffs*person ))*100.0
              if(( age %% 10 ) == 0 ){
                    print( sprintf( "%d,%d,%6.2f,%6.2f,%6.2f", 
                            age, case, 
                            scotProbsIndie$probYes[j], scotProbsBrexit$probLeave[j],
                            probsBrexit$probLeave[j] ));               
              }
              
        }
}

#
# a wee GGPlot of probs by age
#
cbPalette <- c("#FF9999", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")

age_vs_yes_indie = ggplot( scotProbsIndie, aes(x = ages, y = probYes )) +
  geom_line( aes( color = cases ) ) + 
  scale_x_continuous(name = "Age In Years") +
  scale_y_continuous(name = "Probability of 'Yes' (%)")+
  scale_colour_manual(values=cbPalette) +
  ggtitle("IndieRef: Yes vote by age") 

ggsave( filename='outputs/yes_vs_age.png', age_vs_yes_indie )
ggsave( filename='outputs/yes_vs_age.svg', age_vs_yes_indie )

age_vs_leave_scot = ggplot( scotProbsBrexit, aes(x = ages, y = probLeave )) +
  geom_line( aes( color = cases ) ) + 
  scale_x_continuous(name = "Age In Years") +
  scale_y_continuous(name = "Probability of 'Leave' (%)")+
  scale_colour_manual(values=cbPalette) +
  ggtitle("IndieRef: Yes vote by age: Scotland") 

ggsave( filename='outputs/age_vs_leave_scot.png', age_vs_leave_scot )
ggsave( filename='outputs/age_vs_leave_scot.svg', age_vs_leave_scot )

age_vs_leave = ggplot( probsBrexit, aes(x = ages, y = probLeave )) +
  geom_line( aes( color = cases ) ) + 
  scale_x_continuous(name = "Age In Years") +
  scale_y_continuous(name = "Probability of 'Leave' (%)")+
  scale_colour_manual(values=cbPalette) +
  ggtitle("IndieRef: Yes vote by age: GB") 

ggsave( filename='outputs/age_vs_leave.png', age_vs_leave )
ggsave( filename='outputs/age_vs_leave.svg', age_vs_leave )
