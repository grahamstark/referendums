Hi,

I've been using the Wave 9 (post Brexit) edition of BES for a series of articles
for the CommonSpace group. The first of them is here, if you're interested:

https://www.commonspace.scot/articles/10077/graham-stark-were-indyref-and-brexit-driven-same-factors

It runs a few Probits on 'Yes' vs 'Leave' votes and compares them.

For this, I'm using Wave 9 edition 1 BES from:

http://www.britishelectionstudy.com/data-object/british-election-study-combined-wave-1-9-internet-panel/

I'm using the SPSS version `BES2015_W9_Panel_v1.0.sav`

I'm analysing using R 3.2.3 on Linux using `read.spss` from `foreign` to import
the data.

My scripts are in GitHub, here:

    https://github.com/grahamstark/referendums/bes/scripts/

In the course of this I've found a few apparent problems with the data. (They
may of course be my mistakes, or problems with the R import routine).

1. the IndyRef turnout variable `scotReferendumTurnoutW3` is missing (documentation
   p101); however there are `scotReferendumTurnoutW[1|2]` which records intentions to 
   turn out;

2. There *is* a variable`scotReferendumRetroW3` which looks as if it might be
   the turnout variable, but there are implausibly few non-voters there:
   
   `scotReferendumRetroW3` (unweighted):
    yes     no   Not eligible 
    5,120   71   46 
    
   that implies an unweighted turnout of 99% against actual 85%.

3. the post-IndyRef `scotReferendumIntentionW[9|7|6|4]` questions also have
   implausibly few not intending to vote:
   
   `scotReferendumIntentionW9` (unweighted):
   
    No:             1,671 
    Yes:            1,759 
    Will Not Vote:     40     
    D/K               422  

4. the `housing` variable seems to differ from the coding frame in the docs
   (p190). The data has the additional fields:

                                                                Don't know 9999 
                                                                     Other 9 
               Neither I live rent-free with my parents, family or friends 8 
    Neither I live with my parents, family or friends but pay some rent to 7 
                                           Rent from a housing association 6
   
   Note that '6' is 'missing' in the docs, not 'Housing Association'.
   
   Also, 18,392 of the 57,494 housing records (31%) are missing, which seems a
   lot for a fairly simple quesion. 

5. In the docs, the `euRefVote` question is: "If you do vote in the referendum
   on Britain’s membership of the European Union, how do you think you will vote?".
   
   You should probably make clear that `euRefVoteW9` is the *actual* vote? (If
   that's what it is!)

I hope that's of a little use to you, and many thanks indeed to you and all your
colleagues for all your work on this data.

regards,

Graham Stark

