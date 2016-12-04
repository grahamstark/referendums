Title: Were the Scottish and EU Referendums driven by the same things - Brexit vs Indie: Model Notes and Links
Author: Graham Stark [graham.stark@virtual-worlds-research.com](mailto:graham.stark@virtual-worlds-research.com')
Date: 28th November 2016

Data
----
> The British Election Study (BES) is one of the longest running election
studies world-wide and the longest running social science survey in the UK. It
has made a major contribution to the understanding of political attitudes and
behaviour over nearly sixty years. Surveys have taken place immediately after
every general election since 1964.

We're going to use the [inter-election internet panel]() part of the study. The
'panel' here indicates that the same group of people is contacted repeatedly.
There are now 9 contact attempts ('waves' in the jargon) over the last 5 years -
including pre- and post-general election waves, a European Elections wave, and a
Scottish referendum wave. The panel aspect is nice for our purposes as we have
records of how some of the sample voted in both Indie and Brexit. The BES a very
rich dataset with information on attitudes, political allegiances, incomes,
demographics (age, sex, education level, race and so on). Anyone can download
this data [Wave 1-9 Internet
Panel](http://www.britishelectionstudy.com/data-object/british-election-study-combined-wave-1-9-internet-panel/).

Most voting data comes from polling organisations, and the public only gets to
see summaries of it, usually after it has been [processed in very opaque
ways](). Our BES dataset is different in that we get the individual records each
person interviewed. So we can make detailed analyses, and do it in a transparent
way.

We to build a statistical model that predicts how each person votes given their circumstances (age, gender, race,
education, income and so on). There is a tradition of building such models in the social sciences - long but not always
glorious. The models we're building here are known as [Binomial Probits]() - we take a specialised statistical computer
program, and feed it observations from the dataset on each person's vote, and on factors ("explanatory variables") that
might explain this vote. The program spits out (amongst other things) a number ("coefficient") for each explanatory
variable showing the apparent effect of each variable on voting behaviour. Of course, the model can't predict every vote
perfectly - inevitably there will be some people modelled as highly likely to vote one way who will nonetheless do the
oppositve. But, if done well, it can capture accurately the things that have a systematic effect.

As well as voting choices, modelling like this are routinely used to model, for example choices of education courses,
jobs, fertility and much more [BIG FOOTNOTE Ref Santos|Howard and Me|Benefit Takeup]. They are especially prevalent in
Economics; since my day-job is as an economist I've approached this rather as an economist would in exactly how I've
built my model; the models from politcal scientists I've mentioned above sometimes do things a little differently
(notably in how they include age and income). I would of course defend my choices over theirs but my story for Brexit is
ultimately similar.

There are two key advantages of this approach.

Firstly, we can capture the effect of each variable (education, gender, income and so on) on voting intention *all else
equal*. For example, London voted to Remain in the EU Ref; that could be because Londoners on average have higher
incomes, education levels, and so on, and those things are driving voting, or else it could be because of some (perhaps
cultural) "London Effect", or perhaps a bit of both. This is hard to work out from studies based on aggregate data, such
as the [REF Resolution Foundation](). But our individual-level data will inevitably include some poor Londoners and some
rich North-Easteners, and we can use these variations to isolate these different effects.

Secondly, our procedure can tell us how much confidence we can have that our findings are real and not just some fluke
result that's in this particular sample of people but isn't actually there in the population as a whole. We can never be
absolutely sure, of course, but we can put a number on how likely it is that there really is some relationship there.

This kind of modelling is tricky, however. There's rarely any very systematic way to choose which explanatory variables
to include. [Ref Hendry]. And, inevitably, relative to the whole population, the dataset has too many of some types of
people, and too few of other types - this can be because of design (the BES oversamples Scotland, for example), because
of non-response (the rich, the old and the sick are less likely to respond, for example), or other reasons [FOOTNOTE
PANEL ATTRITION]; Dealing with unrepresentative samples is not always easy. And the BES doesn't always ask the questions
you'd really like (there's very limited information on incomes, for example).

Usually, the best thing to do is to try things in a few ways (use different corrections for representativeness,
different explanatory variables, and so on) and see if the most important results persist (they do). And openness is
important; just as you can download the data, you can [download the statistical software], and the [scripts I've written
to drive it]().

The other big problem is not drowning in information. [Below]() I've tried to boil down the huge output from our
Statistics program's huge output into one simple(ish) table; the full outputs are available in [formatted]() and [raw]()
forms, and of course anyone interested should be able to replicate the full results using the [links below]().

* **Income**: the BES has only two income variables "Gross Household Income" and "Gross Personal Income", each given in 16 ranges. 
  For this analysis we replace this with the midpoint of each range (topped at £150,000) and then take the (natural) logarithm of that.
  Obviously this is crude and very approximate, but it's the best we can do with this data, and taking logs is a move 
  that works well in many studies in related fields; see for example [Deaton 2014]().  

* **Age** we actually use two age variables: age and age squared.This is standard in economics [FN originally due to Jacob Mincer]().
  this allows us to capture different shapes of response. For the indie ref we have 'yes' *rising* with age till about 
  age 28 and then falling thereafter. For Brexit, "Leave" rises steadily with income (the squared term is very small and negative, and the
  linear term positive). Note there are no 16-17 year olds in this dataset

* **Categorical Variables** Gender, Political Identification, Region, Race, Religion : these are treated as [dummy variables](); for example,
 for Gender we construct a variable which takes the value 1 for females and 0 otherwise. You always have to leave one
 such variable out - so no "male" dummy if you include a "female" one, and so on; the coefficient on "female" is then the effect
 relative to the ommitted 'male' one. The ommitted variables are:
    - *region*: the Midlands (East and West)
    - *party identification*: no party or a minor party;
    - *education* highest qualification is below A-Level/SCE Higher level;
    - *religion* non Catholic/Protestant, including atheists and agnostics;
    - *ethnic minority* - people who indentify as whites, including non British white people.
 
 the effects in the table are relative to these. 
 
See the [data creation script] for full details.  
 
 

The regressions show how the probability of voting yes to Scottish Independence or Brexit varies with
age, income, gender, political and religious affiliation, holding all else constant.

Regressions are Binomial Probits. Variables used are in the standard forms used in the
economics literature (age and age-squared, log of household income..). [Reference that paper]

More on the techniques used here:

* [Probit Handouts]()
* [Khan Academy]()
* [Examples of Use]()

This is preliminary (though an improvement in many ways on 
[recent JRE analysis](https://www.jrf.org.uk/report/brexit-vote-explained-poverty-low-skills-and-lack-opportunities).


Regressions were done in [R](https://www.r-project.org/).

* [Code for variable creation](data_creation.R)
* [Code for Probit binary regressions](regressions.R)
* [Complete output from all regressions, plus summary stats](regressions.R.log).

Please refer to these for data construction. 

Reference old Gretl version?

Brexit vs IndieRef Vote
-----------------------

Asks about both votes of

<pre>
               IndieRef
  +------+-----------+---------
         |    No     | Yes
  Remain | 0.5257854 | 0.6254072
  Leave  | 0.4742146 | 0.3745928
  
</pre>  
  
So 66% of 'yes' in this sample voted 'remain'.

(Why this is dodgy; comparison with exit polls).

Main Results
------------

Eqn 1 models the Indieref vote. Remainder the EURef. 2-3 are whole GB; 4-6 are on Scottish voters only.


Discussion
------------
The upshot is:

* Education (lack of?) was not a driver of Indieref voting choice, but strong driver of Brexit (discuss possible other measures of this e.g age left education);
* Income: (Explain what and why of logs). Very strong negative association in Brexit vote. Negative, but less
    significant in IndieRef;
* Age: (explain squared term) in IndieRef, all else equal, probability of yes increases to about age
     28, decreases thereafter. Probability of EU vote leave increases steadily with age (squared term much smaller);
* Political affiliation matters, in obvious ways;
* Religion - those identifying as Protestant much less likely to vote 'yes' in Indie, more likely to vote Brexit;
* Discuss big 5 - open minded people voted yes Indie, Remain in EURef;
* Regional dummies - note the Welsh are less likely to vote leave than other similarly poor areas (but still quite likely).

Compare to Rowntree study.

TODO (at least).

* Better understanding of missing variables;
* How to handle "Don't Vote" better;
* Diagnostics - non-normality of errors in Brexit looks bad;
* much more of summary data;
* Marginal Effects
* Pretty pictures.
* Code on GITHUB
* Brexit regressions by Party/Region subsamples - e.g. did the Labour/North-East vote behave strangely?


Full Results
----------------

Various formulations [..]()

Equations 1-4 show IndieRef estimates, based on Scottish Subsample, with
regressors added progressively: basic regressors (age, sex, education, income), then: politics, religion, psychology.

Equations 5-9 show Brexit estimates on the whole GB sample, using the same
regressors, plus (Eqn. 9) regional dummies

Equations 10-13 are the same as 5-8, but for the Scottish subsample only.

Finally, 14 and 15 use vote in Indie Ref [ ]

<pre>    
           Remain      Leave
  Con    0.36609426 0.63390574
  Lab    0.65898280 0.34101720
  Lib    0.76721079 0.23278921
  SNP    0.69285714 0.30714286
  Plaid  0.77570093 0.22429907
  UKIP   0.01440144 0.98559856
  Green  0.85496183 0.14503817
  Other  0.56000000 0.44000000
  None  0.47735072 0.52264928

        Remain      Leave
  Con   0.220656243 0.401527424
  Lab   0.396608677 0.215690812
  Lib   0.119026646 0.037954177
  SNP   0.053402334 0.024878500
  Plaid 0.009138956 0.002777135
  UKIP  0.001761726 0.126706781
  Green 0.036996256 0.006595695
  Other   0.009249064 0.007637121
  None 0.153160097 0.176232354

</pre>  

Scotref

<pre>
            No         Yes
Con   0.95893224 0.04106776
Lab   0.78534031 0.21465969
Lib   0.85294118 0.14705882
SNP   0.05899420 0.94100580
UKIP  0.84090909 0.15909091
Green 0.24806202 0.75193798
BNP   0.50000000 0.50000000
Other 0.12500000 0.87500000
None  0.59541985 0.40458015
    
            No         Yes
Con   0.279808268 0.013063357
Lab   0.359496705 0.107119530
Lib   0.069502696 0.013063357
SNP   0.036548832 0.635532332
UKIP  0.044337927 0.009144350
Green 0.019173158 0.063357283
BNP   0.001797484 0.001959504
Other 0.002396645 0.018288700
None  0.186938286 0.138471587

</pre>
