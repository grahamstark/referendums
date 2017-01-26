Title: Were the Scottish and EU Referendums driven by the same things - Brexit vs Indie: Model Notes and Links
Author: Graham Stark [graham.stark@virtual-worlds-research.com](mailto:graham.stark@virtual-worlds-research.com')
Date: 4th Decembber 2016

This note accompanies [a short paper on Brexit vs IndieRefs](http://virtual-worlds.biz/scot/brexit_vs_indie.html). This
is *incomplete* but should contain all the relevant links to code and data.

Data
----

To quote [the BES website]():

> "The British Election Study (BES) is one of the longest running election
> studies world-wide and the longest running social science survey in the UK. It
> has made a major contribution to the understanding of political attitudes and
> behaviour over nearly sixty years. Surveys have taken place immediately after
> every general election since 1964."

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
 
Main Results
=============================================================================

[Table 1](#table-1) is the full table for the three main regressions summarised in the paper.

[Table 2](#table-2) is the complete set of regressions, showing groups of variables being added progressively.


###TABLE 1###
<table style="text-align:center"><tr><td colspan="4" style="border-bottom: 1px solid black"></td></tr><tr><td style="text-align:left"></td><td colspan="3"><em>Dependent variable:</em></td></tr>
<tr><td></td><td colspan="3" style="border-bottom: 1px solid black"></td></tr>
<tr><td style="text-align:left"></td><td>Voted Yes in Scottish Referendum</td><td colspan="2">Voted Leave in EU Ref</td></tr>
<tr><td style="text-align:left"></td><td>Scotland Only</td><td>All GB</td><td>Scotland Only</td></tr>
<tr><td style="text-align:left"></td><td>(1)</td><td>(2)</td><td>(3)</td></tr>
<tr><td colspan="4" style="border-bottom: 1px solid black"></td></tr><tr><td style="text-align:left">Log of Household Gross Income (£p.a)</td><td>-0.131<sup>***</sup></td><td>-0.214<sup>***</sup></td><td>-0.124<sup>**</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td><td></td></tr>
<tr><td style="text-align:left">Age</td><td>0.059<sup>***</sup></td><td>0.048<sup>***</sup></td><td>0.034<sup>**</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td><td></td></tr>
<tr><td style="text-align:left">Age Squared</td><td>-0.001<sup>***</sup></td><td>-0.0004<sup>***</sup></td><td>-0.0003</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td><td></td></tr>
<tr><td style="text-align:left">Female</td><td>-0.207<sup>***</sup></td><td>-0.053<sup>*</sup></td><td>0.069</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td><td></td></tr>
<tr><td style="text-align:left">Highest Education: A Level/Higher Grade</td><td>-0.019</td><td>-0.259<sup>***</sup></td><td>-0.348<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td><td></td></tr>
<tr><td style="text-align:left">Highest Education: Non-Degree Further</td><td>0.126</td><td>-0.316<sup>***</sup></td><td>-0.390<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td><td></td></tr>
<tr><td style="text-align:left">Highest Education: Degree or Equivalent</td><td>0.136</td><td>-0.508<sup>***</sup></td><td>-0.701<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td><td></td></tr>
<tr><td style="text-align:left">Ethnic Minority</td><td>0.276</td><td>-0.124<sup>*</sup></td><td>0.171</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td><td></td></tr>
<tr><td style="text-align:left">Has Children</td><td>0.075</td><td>0.104<sup>***</sup></td><td>0.215<sup>**</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td><td></td></tr>
<tr><td style="text-align:left">Has a Partner</td><td>-0.053</td><td>0.099<sup>***</sup></td><td>0.015</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td><td></td></tr>
<tr><td style="text-align:left">Identifies Conservative</td><td>-1.360<sup>***</sup></td><td>0.246<sup>***</sup></td><td>0.271<sup>**</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td><td></td></tr>
<tr><td style="text-align:left">Identifies Libdem</td><td>-0.883<sup>***</sup></td><td>-0.784<sup>***</sup></td><td>-0.829<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td><td></td></tr>
<tr><td style="text-align:left">Identifies Labour</td><td>-0.506<sup>***</sup></td><td>-0.533<sup>***</sup></td><td>-0.478<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td><td></td></tr>
<tr><td style="text-align:left">Identifies Green</td><td>0.789<sup>***</sup></td><td>-0.994<sup>***</sup></td><td>-0.801<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td><td></td></tr>
<tr><td style="text-align:left">Identifies UKIP</td><td>-0.700<sup>***</sup></td><td>2.003<sup>***</sup></td><td>5.625</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td><td></td></tr>
<tr><td style="text-align:left">Identifies SNP</td><td>1.890<sup>***</sup></td><td>-0.491<sup>***</sup></td><td>-0.456<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td><td></td></tr>
<tr><td style="text-align:left">Religion: Catholic</td><td>0.193<sup>*</sup></td><td>0.058</td><td>-0.073</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td><td></td></tr>
<tr><td style="text-align:left">Religion: Any Protestant</td><td>-0.238<sup>***</sup></td><td>0.168<sup>***</sup></td><td>0.289<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td><td></td></tr>
<tr><td style="text-align:left">Big5: Openness</td><td>0.059<sup>***</sup></td><td>-0.016<sup>**</sup></td><td>0.029</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td><td></td></tr>
<tr><td style="text-align:left">North East</td><td></td><td>0.034</td><td></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td><td></td></tr>
<tr><td style="text-align:left">North West of England</td><td></td><td>-0.005</td><td></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td><td></td></tr>
<tr><td style="text-align:left">Yorkshire and Humberside</td><td></td><td>0.067</td><td></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td><td></td></tr>
<tr><td style="text-align:left">London</td><td></td><td>-0.086<sup>*</sup></td><td></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td><td></td></tr>
<tr><td style="text-align:left">South of England</td><td></td><td>-0.117<sup>***</sup></td><td></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td><td></td></tr>
<tr><td style="text-align:left">Wales</td><td></td><td>-0.249<sup>***</sup></td><td></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td><td></td></tr>
<tr><td style="text-align:left">Scotland</td><td></td><td>-0.302<sup>***</sup></td><td></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td><td></td></tr>
<tr><td style="text-align:left">Constant</td><td>-0.313</td><td>1.213<sup>***</sup></td><td>0.135</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td><td></td></tr>
<tr><td colspan="4" style="border-bottom: 1px solid black"></td></tr><tr><td style="text-align:left">Observations</td><td>2,256</td><td>10,540</td><td>1,553</td></tr>
<tr><td style="text-align:left">Log Likelihood</td><td>-866.535</td><td>-5,934.568</td><td>-855.068</td></tr>
<tr><td style="text-align:left">Akaike Inf. Crit.</td><td>1,773.070</td><td>11,923.140</td><td>1,750.136</td></tr>
<tr><td colspan="4" style="border-bottom: 1px solid black"></td></tr><tr><td style="text-align:left"><em>Note:</em></td><td colspan="3" style="text-align:right"><sup>*</sup>p<0.1; <sup>**</sup>p<0.05; <sup>***</sup>p<0.01</td></tr>
</table>

###TABLE 2###

<table style="text-align:center"><tr><td colspan="16" style="border-bottom: 1px solid black"></td></tr><tr><td style="text-align:left"></td><td colspan="15"><em>Dependent variable:</em></td></tr>
<tr><td></td><td colspan="15" style="border-bottom: 1px solid black"></td></tr>
<tr><td style="text-align:left"></td><td colspan="4">Voted Yes in Scottish Referendum</td><td colspan="11">Voted Leave in EU Ref</td></tr>
<tr><td style="text-align:left"></td><td colspan="4">Scotland Only</td><td colspan="5">All GB</td><td colspan="6">Scotland Only</td></tr>
<tr><td style="text-align:left"></td><td>(1)</td><td>(2)</td><td>(3)</td><td>(4)</td><td>(5)</td><td>(6)</td><td>(7)</td><td>(8)</td><td>(9)</td><td>(10)</td><td>(11)</td><td>(12)</td><td>(13)</td><td>(14)</td><td>(15)</td></tr>
<tr><td colspan="16" style="border-bottom: 1px solid black"></td></tr><tr><td style="text-align:left">Log of Household Gross Income (£p.a)</td><td>-0.225<sup>***</sup></td><td>-0.135<sup>***</sup></td><td>-0.124<sup>***</sup></td><td>-0.131<sup>***</sup></td><td>-0.128<sup>***</sup></td><td>-0.202<sup>***</sup></td><td>-0.201<sup>***</sup></td><td>-0.215<sup>***</sup></td><td>-0.214<sup>***</sup></td><td>-0.064</td><td>-0.116<sup>**</sup></td><td>-0.116<sup>**</sup></td><td>-0.124<sup>**</sup></td><td>-0.190<sup>***</sup></td><td>-0.170<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td>(0.036)</td><td>(0.046)</td><td>(0.048)</td><td>(0.048)</td><td>(0.017)</td><td>(0.019)</td><td>(0.019)</td><td>(0.020)</td><td>(0.020)</td><td>(0.046)</td><td>(0.050)</td><td>(0.050)</td><td>(0.051)</td><td>(0.049)</td><td>(0.045)</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
<tr><td style="text-align:left">Age</td><td>0.031<sup>***</sup></td><td>0.053<sup>***</sup></td><td>0.059<sup>***</sup></td><td>0.059<sup>***</sup></td><td>0.038<sup>***</sup></td><td>0.049<sup>***</sup></td><td>0.048<sup>***</sup></td><td>0.048<sup>***</sup></td><td>0.048<sup>***</sup></td><td>0.010</td><td>0.029<sup>*</sup></td><td>0.034<sup>**</sup></td><td>0.034<sup>**</sup></td><td>0.039<sup>**</sup></td><td>0.027<sup>*</sup></td></tr>
<tr><td style="text-align:left"></td><td>(0.011)</td><td>(0.015)</td><td>(0.016)</td><td>(0.016)</td><td>(0.005)</td><td>(0.005)</td><td>(0.006)</td><td>(0.006)</td><td>(0.006)</td><td>(0.015)</td><td>(0.016)</td><td>(0.016)</td><td>(0.017)</td><td>(0.017)</td><td>(0.016)</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
<tr><td style="text-align:left">Age Squared</td><td>-0.0004<sup>***</sup></td><td>-0.001<sup>***</sup></td><td>-0.001<sup>***</sup></td><td>-0.001<sup>***</sup></td><td>-0.0003<sup>***</sup></td><td>-0.0004<sup>***</sup></td><td>-0.0004<sup>***</sup></td><td>-0.0004<sup>***</sup></td><td>-0.0004<sup>***</sup></td><td>-0.00001</td><td>-0.0002</td><td>-0.0003<sup>*</sup></td><td>-0.0003</td><td>-0.0003<sup>*</sup></td><td>-0.0002</td></tr>
<tr><td style="text-align:left"></td><td>(0.0001)</td><td>(0.0002)</td><td>(0.0002)</td><td>(0.0002)</td><td>(0.00005)</td><td>(0.0001)</td><td>(0.0001)</td><td>(0.0001)</td><td>(0.0001)</td><td>(0.0001)</td><td>(0.0002)</td><td>(0.0002)</td><td>(0.0002)</td><td>(0.0002)</td><td>(0.0002)</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
<tr><td style="text-align:left">Female</td><td>-0.210<sup>***</sup></td><td>-0.222<sup>***</sup></td><td>-0.193<sup>***</sup></td><td>-0.207<sup>***</sup></td><td>-0.043<sup>*</sup></td><td>-0.041</td><td>-0.050<sup>*</sup></td><td>-0.049<sup>*</sup></td><td>-0.053<sup>*</sup></td><td>-0.006</td><td>0.055</td><td>0.058</td><td>0.069</td><td>0.052</td><td>0.0002</td></tr>
<tr><td style="text-align:left"></td><td>(0.052)</td><td>(0.068)</td><td>(0.069)</td><td>(0.070)</td><td>(0.024)</td><td>(0.026)</td><td>(0.026)</td><td>(0.027)</td><td>(0.027)</td><td>(0.066)</td><td>(0.070)</td><td>(0.070)</td><td>(0.071)</td><td>(0.067)</td><td>(0.063)</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
<tr><td style="text-align:left">Highest Education: A Level/Higher Grade</td><td>0.044</td><td>0.041</td><td>-0.0003</td><td>-0.019</td><td>-0.352<sup>***</sup></td><td>-0.323<sup>***</sup></td><td>-0.308<sup>***</sup></td><td>-0.277<sup>***</sup></td><td>-0.259<sup>***</sup></td><td>-0.326<sup>***</sup></td><td>-0.410<sup>***</sup></td><td>-0.377<sup>***</sup></td><td>-0.348<sup>***</sup></td><td>-0.349<sup>***</sup></td><td>-0.338<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td>(0.081)</td><td>(0.106)</td><td>(0.110)</td><td>(0.110)</td><td>(0.037)</td><td>(0.040)</td><td>(0.040)</td><td>(0.042)</td><td>(0.042)</td><td>(0.096)</td><td>(0.102)</td><td>(0.103)</td><td>(0.105)</td><td>(0.103)</td><td>(0.097)</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
<tr><td style="text-align:left">Highest Education: Non-Degree Further</td><td>0.016</td><td>0.164</td><td>0.149</td><td>0.126</td><td>-0.433<sup>***</sup></td><td>-0.372<sup>***</sup></td><td>-0.361<sup>***</sup></td><td>-0.331<sup>***</sup></td><td>-0.316<sup>***</sup></td><td>-0.384<sup>***</sup></td><td>-0.418<sup>***</sup></td><td>-0.397<sup>***</sup></td><td>-0.390<sup>***</sup></td><td>-0.390<sup>***</sup></td><td>-0.415<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td>(0.102)</td><td>(0.136)</td><td>(0.139)</td><td>(0.139)</td><td>(0.048)</td><td>(0.053)</td><td>(0.053)</td><td>(0.054)</td><td>(0.054)</td><td>(0.125)</td><td>(0.133)</td><td>(0.134)</td><td>(0.136)</td><td>(0.126)</td><td>(0.118)</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
<tr><td style="text-align:left">Highest Education: Degree or Equivalent</td><td>0.067</td><td>0.165<sup>*</sup></td><td>0.155<sup>*</sup></td><td>0.136</td><td>-0.653<sup>***</sup></td><td>-0.573<sup>***</sup></td><td>-0.556<sup>***</sup></td><td>-0.522<sup>***</sup></td><td>-0.508<sup>***</sup></td><td>-0.720<sup>***</sup></td><td>-0.719<sup>***</sup></td><td>-0.698<sup>***</sup></td><td>-0.701<sup>***</sup></td><td>-0.695<sup>***</sup></td><td>-0.728<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td>(0.067)</td><td>(0.089)</td><td>(0.090)</td><td>(0.091)</td><td>(0.029)</td><td>(0.031)</td><td>(0.032)</td><td>(0.033)</td><td>(0.033)</td><td>(0.082)</td><td>(0.087)</td><td>(0.088)</td><td>(0.090)</td><td>(0.082)</td><td>(0.076)</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
<tr><td style="text-align:left">Ethnic Minority</td><td>0.409<sup>**</sup></td><td>0.287</td><td>0.267</td><td>0.276</td><td>-0.152<sup>**</sup></td><td>-0.149<sup>**</sup></td><td>-0.131<sup>**</sup></td><td>-0.114<sup>*</sup></td><td>-0.124<sup>*</sup></td><td>0.226</td><td>0.196</td><td>0.188</td><td>0.171</td><td>0.109</td><td>0.164</td></tr>
<tr><td style="text-align:left"></td><td>(0.169)</td><td>(0.217)</td><td>(0.222)</td><td>(0.223)</td><td>(0.059)</td><td>(0.064)</td><td>(0.064)</td><td>(0.066)</td><td>(0.067)</td><td>(0.226)</td><td>(0.245)</td><td>(0.251)</td><td>(0.251)</td><td>(0.229)</td><td>(0.210)</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
<tr><td style="text-align:left">Has Children</td><td>0.020</td><td>0.076</td><td>0.067</td><td>0.075</td><td>0.110<sup>***</sup></td><td>0.120<sup>***</sup></td><td>0.108<sup>***</sup></td><td>0.103<sup>***</sup></td><td>0.104<sup>***</sup></td><td>0.202<sup>**</sup></td><td>0.229<sup>**</sup></td><td>0.203<sup>**</sup></td><td>0.215<sup>**</sup></td><td>0.199<sup>**</sup></td><td>0.200<sup>**</sup></td></tr>
<tr><td style="text-align:left"></td><td>(0.066)</td><td>(0.083)</td><td>(0.086)</td><td>(0.087)</td><td>(0.031)</td><td>(0.034)</td><td>(0.034)</td><td>(0.035)</td><td>(0.035)</td><td>(0.086)</td><td>(0.091)</td><td>(0.092)</td><td>(0.094)</td><td>(0.092)</td><td>(0.086)</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
<tr><td style="text-align:left">Has a Partner</td><td>0.034</td><td>-0.025</td><td>-0.060</td><td>-0.053</td><td>0.081<sup>***</sup></td><td>0.091<sup>***</sup></td><td>0.087<sup>***</sup></td><td>0.107<sup>***</sup></td><td>0.099<sup>***</sup></td><td>-0.053</td><td>-0.026</td><td>-0.022</td><td>0.015</td><td>0.061</td><td>0.056</td></tr>
<tr><td style="text-align:left"></td><td>(0.060)</td><td>(0.078)</td><td>(0.080)</td><td>(0.081)</td><td>(0.028)</td><td>(0.031)</td><td>(0.031)</td><td>(0.032)</td><td>(0.032)</td><td>(0.076)</td><td>(0.081)</td><td>(0.082)</td><td>(0.084)</td><td>(0.078)</td><td>(0.074)</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
<tr><td style="text-align:left">Identifies Conservative</td><td></td><td>-1.453<sup>***</sup></td><td>-1.373<sup>***</sup></td><td>-1.360<sup>***</sup></td><td></td><td>0.320<sup>***</sup></td><td>0.291<sup>***</sup></td><td>0.274<sup>***</sup></td><td>0.246<sup>***</sup></td><td></td><td>0.320<sup>***</sup></td><td>0.269<sup>**</sup></td><td>0.271<sup>**</sup></td><td>0.228<sup>**</sup></td><td></td></tr>
<tr><td style="text-align:left"></td><td></td><td>(0.136)</td><td>(0.139)</td><td>(0.140)</td><td></td><td>(0.038)</td><td>(0.038)</td><td>(0.039)</td><td>(0.040)</td><td></td><td>(0.112)</td><td>(0.113)</td><td>(0.115)</td><td>(0.107)</td><td></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
<tr><td style="text-align:left">Identifies Libdem</td><td></td><td>-0.901<sup>***</sup></td><td>-0.910<sup>***</sup></td><td>-0.883<sup>***</sup></td><td></td><td>-0.737<sup>***</sup></td><td>-0.753<sup>***</sup></td><td>-0.765<sup>***</sup></td><td>-0.784<sup>***</sup></td><td></td><td>-0.773<sup>***</sup></td><td>-0.825<sup>***</sup></td><td>-0.829<sup>***</sup></td><td>-0.973<sup>***</sup></td><td></td></tr>
<tr><td style="text-align:left"></td><td></td><td>(0.170)</td><td>(0.174)</td><td>(0.176)</td><td></td><td>(0.056)</td><td>(0.057)</td><td>(0.058)</td><td>(0.058)</td><td></td><td>(0.179)</td><td>(0.180)</td><td>(0.181)</td><td>(0.183)</td><td></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
<tr><td style="text-align:left">Identifies Labour</td><td></td><td>-0.497<sup>***</sup></td><td>-0.506<sup>***</sup></td><td>-0.506<sup>***</sup></td><td></td><td>-0.498<sup>***</sup></td><td>-0.500<sup>***</sup></td><td>-0.505<sup>***</sup></td><td>-0.533<sup>***</sup></td><td></td><td>-0.485<sup>***</sup></td><td>-0.482<sup>***</sup></td><td>-0.478<sup>***</sup></td><td>-0.611<sup>***</sup></td><td></td></tr>
<tr><td style="text-align:left"></td><td></td><td>(0.087)</td><td>(0.089)</td><td>(0.090)</td><td></td><td>(0.037)</td><td>(0.037)</td><td>(0.038)</td><td>(0.039)</td><td></td><td>(0.106)</td><td>(0.107)</td><td>(0.109)</td><td>(0.102)</td><td></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
<tr><td style="text-align:left">Identifies Green</td><td></td><td>0.887<sup>***</sup></td><td>0.803<sup>***</sup></td><td>0.789<sup>***</sup></td><td></td><td>-1.066<sup>***</sup></td><td>-1.033<sup>***</sup></td><td>-1.007<sup>***</sup></td><td>-0.994<sup>***</sup></td><td></td><td>-0.792<sup>***</sup></td><td>-0.790<sup>***</sup></td><td>-0.801<sup>***</sup></td><td>-0.860<sup>***</sup></td><td></td></tr>
<tr><td style="text-align:left"></td><td></td><td>(0.157)</td><td>(0.164)</td><td>(0.164)</td><td></td><td>(0.109)</td><td>(0.109)</td><td>(0.112)</td><td>(0.112)</td><td></td><td>(0.257)</td><td>(0.259)</td><td>(0.263)</td><td>(0.248)</td><td></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
<tr><td style="text-align:left">Identifies UKIP</td><td></td><td>-0.700<sup>***</sup></td><td>-0.718<sup>***</sup></td><td>-0.700<sup>***</sup></td><td></td><td>2.005<sup>***</sup></td><td>1.992<sup>***</sup></td><td>2.011<sup>***</sup></td><td>2.003<sup>***</sup></td><td></td><td>5.587</td><td>5.580</td><td>5.625</td><td>5.382</td><td></td></tr>
<tr><td style="text-align:left"></td><td></td><td>(0.195)</td><td>(0.202)</td><td>(0.202)</td><td></td><td>(0.130)</td><td>(0.131)</td><td>(0.137)</td><td>(0.139)</td><td></td><td>(58.378)</td><td>(58.377)</td><td>(58.622)</td><td>(58.183)</td><td></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
<tr><td style="text-align:left">Identifies SNP</td><td></td><td>1.862<sup>***</sup></td><td>1.895<sup>***</sup></td><td>1.890<sup>***</sup></td><td></td><td>-0.684<sup>***</sup></td><td>-0.680<sup>***</sup></td><td>-0.687<sup>***</sup></td><td>-0.491<sup>***</sup></td><td></td><td>-0.445<sup>***</sup></td><td>-0.439<sup>***</sup></td><td>-0.456<sup>***</sup></td><td>-0.506<sup>***</sup></td><td></td></tr>
<tr><td style="text-align:left"></td><td></td><td>(0.101)</td><td>(0.105)</td><td>(0.106)</td><td></td><td>(0.068)</td><td>(0.069)</td><td>(0.070)</td><td>(0.080)</td><td></td><td>(0.099)</td><td>(0.099)</td><td>(0.102)</td><td>(0.102)</td><td></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
<tr><td style="text-align:left">Religion: Catholic</td><td></td><td></td><td>0.170</td><td>0.193<sup>*</sup></td><td></td><td></td><td>0.080<sup>*</sup></td><td>0.069</td><td>0.058</td><td></td><td></td><td>-0.008</td><td>-0.073</td><td>0.151</td><td></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td><td>(0.115)</td><td>(0.116)</td><td></td><td></td><td>(0.049)</td><td>(0.050)</td><td>(0.050)</td><td></td><td></td><td>(0.125)</td><td>(0.131)</td><td>(0.117)</td><td></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
<tr><td style="text-align:left">Religion: Any Protestant</td><td></td><td></td><td>-0.260<sup>***</sup></td><td>-0.238<sup>***</sup></td><td></td><td></td><td>0.180<sup>***</sup></td><td>0.177<sup>***</sup></td><td>0.168<sup>***</sup></td><td></td><td></td><td>0.263<sup>***</sup></td><td>0.289<sup>***</sup></td><td>0.186<sup>**</sup></td><td></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td><td>(0.079)</td><td>(0.080)</td><td></td><td></td><td>(0.029)</td><td>(0.030)</td><td>(0.030)</td><td></td><td></td><td>(0.079)</td><td>(0.080)</td><td>(0.074)</td><td></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
<tr><td style="text-align:left">Big5: Openness</td><td></td><td></td><td></td><td>0.059<sup>***</sup></td><td></td><td></td><td></td><td>-0.017<sup>**</sup></td><td>-0.016<sup>**</sup></td><td></td><td></td><td></td><td>0.029</td><td>-0.002</td><td></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td><td></td><td>(0.020)</td><td></td><td></td><td></td><td>(0.008)</td><td>(0.008)</td><td></td><td></td><td></td><td>(0.021)</td><td>(0.019)</td><td></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
<tr><td style="text-align:left">North East</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td>0.034</td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td>(0.070)</td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
<tr><td style="text-align:left">North West of England</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td>-0.005</td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td>(0.051)</td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
<tr><td style="text-align:left">Yorkshire and Humberside</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td>0.067</td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td>(0.054)</td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
<tr><td style="text-align:left">London</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td>-0.086<sup>*</sup></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td>(0.051)</td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
<tr><td style="text-align:left">South of England</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td>-0.117<sup>***</sup></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td>(0.041)</td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
<tr><td style="text-align:left">Wales</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td>-0.249<sup>***</sup></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td>(0.053)</td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
<tr><td style="text-align:left">Scotland</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td>-0.302<sup>***</sup></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td>(0.050)</td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
<tr><td style="text-align:left">Voted Yes in IndieRef</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td>-0.036</td><td>-0.281<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td>(0.092)</td><td>(0.063)</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
<tr><td style="text-align:left">Constant</td><td>1.860<sup>***</sup></td><td>0.186</td><td>-0.015</td><td>-0.313</td><td>0.400<sup>**</sup></td><td>0.975<sup>***</sup></td><td>0.943<sup>***</sup></td><td>1.146<sup>***</sup></td><td>1.213<sup>***</sup></td><td>0.181</td><td>0.415</td><td>0.254</td><td>0.135</td><td>0.882</td><td>0.866</td></tr>
<tr><td style="text-align:left"></td><td>(0.432)</td><td>(0.552)</td><td>(0.577)</td><td>(0.594)</td><td>(0.203)</td><td>(0.225)</td><td>(0.227)</td><td>(0.244)</td><td>(0.247)</td><td>(0.552)</td><td>(0.596)</td><td>(0.612)</td><td>(0.658)</td><td>(0.654)</td><td>(0.600)</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
<tr><td colspan="16" style="border-bottom: 1px solid black"></td></tr><tr><td style="text-align:left">Observations</td><td>2,457</td><td>2,374</td><td>2,281</td><td>2,256</td><td>11,649</td><td>11,190</td><td>11,143</td><td>10,540</td><td>10,540</td><td>1,656</td><td>1,614</td><td>1,608</td><td>1,553</td><td>1,896</td><td>1,948</td></tr>
<tr><td style="text-align:left">Log Likelihood</td><td>-1,656.315</td><td>-925.873</td><td>-878.954</td><td>-866.535</td><td>-7,499.412</td><td>-6,319.826</td><td>-6,279.390</td><td>-5,968.492</td><td>-5,934.568</td><td>-1,013.896</td><td>-898.282</td><td>-887.847</td><td>-855.068</td><td>-1,020.807</td><td>-1,149.595</td></tr>
<tr><td style="text-align:left">Akaike Inf. Crit.</td><td>3,334.630</td><td>1,885.745</td><td>1,795.908</td><td>1,773.070</td><td>15,020.830</td><td>12,673.650</td><td>12,596.780</td><td>11,976.990</td><td>11,923.140</td><td>2,049.793</td><td>1,830.564</td><td>1,813.694</td><td>1,750.136</td><td>2,083.614</td><td>2,323.190</td></tr>
<tr><td colspan="16" style="border-bottom: 1px solid black"></td></tr><tr><td style="text-align:left"><em>Note:</em></td><td colspan="15" style="text-align:right"><sup>*</sup>p<0.1; <sup>**</sup>p<0.05; <sup>***</sup>p<0.01</td></tr>
</table>

Equations 1-4 show IndieRef estimates, based on Scottish Subsample, with
regressors added progressively: basic regressors (age, sex, education, income), then: politics, religion, psychology.

Equations 5-9 show Brexit estimates on the whole GB sample, using the same
regressors, plus (Eqn. 9) regional dummies

Equations 10-13 are the same as 5-8, but for the Scottish subsample only.

Finally, 14 and 15 use vote in Indie Ref as a predictor. With all the other variables in, it's not a good predictor
since the variables we use themselves predict the indieref vote. Using the indieref without the full variable set 
is a good predictor.

We make the pretty-ish arrows table in the article from [Table 1 above](#table-1) using a [little Ruby script](https://github.com/grahamstark/referendums/blob/master/bes/scripts/make_pretty_table.rb).

<table class='easytable'>
<thead>
<tr>
<td class='col_header' style='border-bottom: 1px solid black' colspan='7'></td>
</tr>
<tr>
<td class='col_header' style='text-align:left'></td>
<td class='col_header' colspan='6'></td>
</tr>
<tr>
<td class='col_header'></td>
<td class='col_header' style='border-bottom: 1px solid black' colspan='6'></td>
</tr>
<tr>
<td class='col_header' style='text-align:left'></td>
<td class='col_header'>Voted Yes in Scottish Referendum</td>
<td class='col_header' colspan='5'>Voted Leave in EU Ref</td>
</tr>
<tr>
<td class='col_header' style='text-align:left'></td>
<td class='col_header'>Scotland Only</td>
<td class='col_header' colspan='2'>All GB</td>
<td class='col_header' colspan='3'>Scotland Only</td>
</tr>
<tr>
<td class='col_header' style='text-align:left'></td>
<td class='col_header'>(1)</td>
<td class='col_header'>(2)</td>
<td class='col_header'>(3)</td>
<td class='col_header'>(4)</td>
<td class='col_header'>(5)</td>
<td class='col_header'>(6)</td>
</tr>
</thead>
<tbody>
<tr>
<th class='row_header'>Log of Household Gross Income (£p.a)</th>
<td class='negative_strong'>&#x1F883;</td>
<td class='negative_strong'>&#x1F883;</td>
<td class='negative_strong'>&#x1F883;</td>
<td class='negative_med'>&#x1F873;</td>
<td class='negative_strong'>&#x1F883;</td>
<td class='negative_strong'>&#x1F883;</td>
</tr>
<tr>
<th class='row_header'>Age</th>
<td class='positive_strong'>&#x1F881;</td>
<td class='positive_strong'>&#x1F881;</td>
<td class='positive_strong'>&#x1F881;</td>
<td class='positive_med'>&#x1F871;</td>
<td class='positive_med'>&#x1F871;</td>
<td class='positive_weak'>&#x1F861;</td>
</tr>
<tr>
<th class='row_header'>Age Squared</th>
<td class='negative_strong'>&#x1F883;</td>
<td class='negative_strong'>&#x1F883;</td>
<td class='negative_strong'>&#x1F883;</td>
<td class='nonsig'>&#x25CF;</td>
<td class='negative_weak'>&#x1F863;</td>
<td class='nonsig'>&#x25CF;</td>
</tr>
<tr>
<th class='row_header'>Female</th>
<td class='negative_strong'>&#x1F883;</td>
<td class='negative_weak'>&#x1F863;</td>
<td class='negative_weak'>&#x1F863;</td>
<td class='nonsig'>&#x25CF;</td>
<td class='nonsig'>&#x25CF;</td>
<td class='nonsig'>&#x25CF;</td>
</tr>
<tr>
<th class='row_header'>Highest Education: A Level/Higher Grade</th>
<td class='nonsig'>&#x25CF;</td>
<td class='negative_strong'>&#x1F883;</td>
<td class='negative_strong'>&#x1F883;</td>
<td class='negative_strong'>&#x1F883;</td>
<td class='negative_strong'>&#x1F883;</td>
<td class='negative_strong'>&#x1F883;</td>
</tr>
<tr>
<th class='row_header'>Highest Education: Non-Degree Further</th>
<td class='nonsig'>&#x25CF;</td>
<td class='negative_strong'>&#x1F883;</td>
<td class='negative_strong'>&#x1F883;</td>
<td class='negative_strong'>&#x1F883;</td>
<td class='negative_strong'>&#x1F883;</td>
<td class='negative_strong'>&#x1F883;</td>
</tr>
<tr>
<th class='row_header'>Highest Education: Degree or Equivalent</th>
<td class='nonsig'>&#x25CF;</td>
<td class='negative_strong'>&#x1F883;</td>
<td class='negative_strong'>&#x1F883;</td>
<td class='negative_strong'>&#x1F883;</td>
<td class='negative_strong'>&#x1F883;</td>
<td class='negative_strong'>&#x1F883;</td>
</tr>
<tr>
<th class='row_header'>Ethnic Minority</th>
<td class='nonsig'>&#x25CF;</td>
<td class='negative_weak'>&#x1F863;</td>
<td class='negative_weak'>&#x1F863;</td>
<td class='nonsig'>&#x25CF;</td>
<td class='nonsig'>&#x25CF;</td>
<td class='nonsig'>&#x25CF;</td>
</tr>
<tr>
<th class='row_header'>Has Children</th>
<td class='nonsig'>&#x25CF;</td>
<td class='positive_strong'>&#x1F881;</td>
<td class='positive_strong'>&#x1F881;</td>
<td class='positive_med'>&#x1F871;</td>
<td class='positive_med'>&#x1F871;</td>
<td class='positive_med'>&#x1F871;</td>
</tr>
<tr>
<th class='row_header'>Has a Partner</th>
<td class='nonsig'>&#x25CF;</td>
<td class='positive_strong'>&#x1F881;</td>
<td class='positive_strong'>&#x1F881;</td>
<td class='nonsig'>&#x25CF;</td>
<td class='nonsig'>&#x25CF;</td>
<td class='nonsig'>&#x25CF;</td>
</tr>
<tr>
<th class='row_header'>Identifies Conservative</th>
<td class='negative_strong'>&#x1F883;</td>
<td class='positive_strong'>&#x1F881;</td>
<td class='positive_strong'>&#x1F881;</td>
<td class='positive_med'>&#x1F871;</td>
<td class='positive_med'>&#x1F871;</td>
<td></td>
</tr>
<tr>
<th class='row_header'>Identifies Libdem</th>
<td class='negative_strong'>&#x1F883;</td>
<td class='negative_strong'>&#x1F883;</td>
<td class='negative_strong'>&#x1F883;</td>
<td class='negative_strong'>&#x1F883;</td>
<td class='negative_strong'>&#x1F883;</td>
<td></td>
</tr>
<tr>
<th class='row_header'>Identifies Labour</th>
<td class='negative_strong'>&#x1F883;</td>
<td class='negative_strong'>&#x1F883;</td>
<td class='negative_strong'>&#x1F883;</td>
<td class='negative_strong'>&#x1F883;</td>
<td class='negative_strong'>&#x1F883;</td>
<td></td>
</tr>
<tr>
<th class='row_header'>Identifies Green</th>
<td class='positive_strong'>&#x1F881;</td>
<td class='negative_strong'>&#x1F883;</td>
<td class='negative_strong'>&#x1F883;</td>
<td class='negative_strong'>&#x1F883;</td>
<td class='negative_strong'>&#x1F883;</td>
<td></td>
</tr>
<tr>
<th class='row_header'>Identifies UKIP</th>
<td class='negative_strong'>&#x1F883;</td>
<td class='positive_strong'>&#x1F881;</td>
<td class='positive_strong'>&#x1F881;</td>
<td class='nonsig'>&#x25CF;</td>
<td class='nonsig'>&#x25CF;</td>
<td></td>
</tr>
<tr>
<th class='row_header'>Identifies SNP</th>
<td class='positive_strong'>&#x1F881;</td>
<td class='negative_strong'>&#x1F883;</td>
<td class='negative_strong'>&#x1F883;</td>
<td class='negative_strong'>&#x1F883;</td>
<td class='negative_strong'>&#x1F883;</td>
<td></td>
</tr>
<tr>
<th class='row_header'>Religion: Catholic</th>
<td class='positive_weak'>&#x1F861;</td>
<td class='nonsig'>&#x25CF;</td>
<td class='nonsig'>&#x25CF;</td>
<td class='nonsig'>&#x25CF;</td>
<td class='nonsig'>&#x25CF;</td>
<td></td>
</tr>
<tr>
<th class='row_header'>Religion: Any Protestant</th>
<td class='negative_strong'>&#x1F883;</td>
<td class='positive_strong'>&#x1F881;</td>
<td class='positive_strong'>&#x1F881;</td>
<td class='positive_strong'>&#x1F881;</td>
<td class='positive_med'>&#x1F871;</td>
<td></td>
</tr>
<tr>
<th class='row_header'>Big5: Openness</th>
<td class='positive_strong'>&#x1F881;</td>
<td class='negative_med'>&#x1F873;</td>
<td class='negative_med'>&#x1F873;</td>
<td class='nonsig'>&#x25CF;</td>
<td class='nonsig'>&#x25CF;</td>
<td></td>
</tr>
<tr>
<th class='row_header'>North East</th>
<td></td>
<td></td>
<td class='nonsig'>&#x25CF;</td>
<td></td>
<td></td>
<td></td>
</tr>
<tr>
<th class='row_header'>North West of England</th>
<td></td>
<td></td>
<td class='nonsig'>&#x25CF;</td>
<td></td>
<td></td>
<td></td>
</tr>
<tr>
<th class='row_header'>Yorkshire and Humberside</th>
<td></td>
<td></td>
<td class='nonsig'>&#x25CF;</td>
<td></td>
<td></td>
<td></td>
</tr>
<tr>
<th class='row_header'>London</th>
<td></td>
<td></td>
<td class='negative_weak'>&#x1F863;</td>
<td></td>
<td></td>
<td></td>
</tr>
<tr>
<th class='row_header'>South of England</th>
<td></td>
<td></td>
<td class='negative_strong'>&#x1F883;</td>
<td></td>
<td></td>
<td></td>
</tr>
<tr>
<th class='row_header'>Wales</th>
<td></td>
<td></td>
<td class='negative_strong'>&#x1F883;</td>
<td></td>
<td></td>
<td></td>
</tr>
<tr>
<th class='row_header'>Scotland</th>
<td></td>
<td></td>
<td class='negative_strong'>&#x1F883;</td>
<td></td>
<td></td>
<td></td>
</tr>
<tr>
<th class='row_header'>Voted Yes in IndieRef</th>
<td></td>
<td></td>
<td></td>
<td></td>
<td class='nonsig'>&#x25CF;</td>
<td class='negative_strong'>&#x1F883;</td>
</tr>
</tbody>
</table>


**Notes To The Article**

The Commonspace CMS system unfortunately chopped out the article's footnotes, so I'll reproduce them here:

*Matthew Goodwin and Oliver Heath Study* : The study was completed after the vote but before the edition of the BES with the actual data on the Brexit vote
had been released; instead, Goodwin and Heath model *intention* to vote (6 months before), which is a good though not
perfect correlate with actual vote. I'm using the version (9) of the BES with the actual vote in it.

*Kauffmann Study*: this was carried out even earlier, before the actual Brexit vote: instead of explaining the vote he is modelling the
extent to which people disapprove of the EU, which, too, is a good predictor of the final vote.

*Paragraph on 'Main Findings'*: We say 'Great Britain' rather than 'United Kingdom' since Northern Ireland is not in the BES data.

*Relationship between age and voting*: in the IndieRef case (but not the Brexit vote), this is actually a bit
of a simplification - 'Yes' is modelled to rise till about age 40 and fall
thereafter, whereas 'Leave' rises steadily at all ages. This is 'all else
equal', and of course incomes generally rise between those ages, which may
explain why simple tabulations from polling data don't show quite this pattern.
See the [Technical Note][TECHNOTE] for more detail.

*Political Parties*: These are the parties people *identify* with; they needn't be members of them.

*Strength of statistical relationships* : A technical aside: I'm using statistical significance for this (the p-values) rather than, for example, effect
size. So I give more weight in that table to a small but certain influence than to a potentially large effect which has
more uncertainty attached to it. [The American Statistical Association has a good short paper on this][ASA]

*On Modelling Brexit*: I report above a version of the model without these regional dummies, showing that
adding or removing these variables doesn't affect our other conclusions in any major way. So model in column (2) is
still comparable with the Indie ref one even though it has more variables.

*Analysis of Scottish Voters*: 'Scottish', as is customary, simply means people living (or at least interviewed) in Scotland. Adding country of birth as an explanatory variable would be interesting.

*London (non) Effect*: The [Resolution Foundation study][Resolution] finds this, too.


Code and Further Reading
=============================================================================
The regressions show how the probability of voting yes to Scottish Independence or Brexit varies with
age, income, gender, political and religious affiliation, holding all else constant.

Regressions are Binomial Probits. Variables used are in the standard forms used in the
economics literature (age and age-squared, log of household income..). [Reference that paper]

More on the techniques used here:

* The [Khan Academy](https://www.khanacademy.org/math/statistics-probability) is a good place to start if
  you want to brush up on statistics; 
* The Probit model we use is well discussed in [this presentation](https://www3.nd.edu/~rwilliam/xsoc73994/Margins02.pdf);
* [A good online course on using our R program for economic modelling](http://www.urfie.net/).


Regressions were done in [R](https://www.r-project.org/). 

All the code and full output are available on the [GitHub code sharing site](https://github.com/grahamstark/referendums/).

* [Code for variable creation](https://github.com/grahamstark/referendums/blob/master/bes/scripts/data_creation.R)
* [Code for Probit binary regressions](https://github.com/grahamstark/referendums/blob/master/bes/scripts/regressions.R)
* [Complete output from all regressions, plus summary stats](https://github.com/grahamstark/referendums/tree/master/bes/outputs).

Please refer to these for data construction. 

TODO (at least).
==================

* Better understanding of missing variables;
* How to handle "Don't Vote" better;
* Diagnostics - non-normality of errors in Brexit looks bad;
* much more of summary data;
* Marginal Effects
* Pretty pictures.
* Code on GITHUB
* Brexit regressions by Party/Region subsamples - e.g. did the Labour/North-East vote behave strangely?


Some Crude Summary Crosstabs
==============================
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


**Notes**

[^FN1]: The study was completed after the vote but before the edition of the BES with the actual data on the Brexit vote
had been released; instead, Goodwin and Heath model *intention* to vote (6 months before), which is a good though not
perfect correlate with actual vote. I'm using the version (9) of the BES with the actual vote in it.

[^FN2]: Kaufmann's study was carried out even earlier, before the actual Brexit vote: instead of explaining the vote he is modelling the
extent to which people disapprove of the EU, which, too, is a good predictor of the final vote.

[^FN3]: Strictly speaking, there is no London effect relative to the "ommited dummy", - the Midlands - the [technical note][TECHNOTE] explains this in more detail; 

[^FN4]: 'Great Britain' rather than 'United Kingdom' since Northern Ireland is not in the BES data.

[^FN5]: in the IndieRef case (but not the Brexit vote), this is actually a bit
of a simplification - 'Yes' is modelled to rise till about age 40 and fall
thereafter, whereas 'Leave' rises steadily at all ages. This is 'all else
equal', and of course incomes generally rise between those ages, which may
explain why simple tabulations from polling data don't show quite this pattern.
See the [Technical Note][TECHNOTE] for more detail.

[^FN6]: These are the parties people *identify* with; they needn't be members of them.

[^FNSIG]: A technical aside: I'm using statistical significance for this (the p-values) rather than, for example, effect
size. So I give more weight in that table to a small but certain influence than to a potentially large effect which has
more uncertainty attached to it. [The American Statistical Association has a good short paper on this][ASA]

[^FNMODEL]: See the [Technical Note][TECHNOTE] for more on all this; there is in particular a tricky issue here that many people have
dropped out of the survey between the Indie and Brexit votes.

[^FNREG]: in the [Technical Note][TECHNOTE] I report a version of the model without these regional dummies, showing that
adding or removing these variables doesn't affect our other conclusions in any major way. So model in column (2) is
still comparable with the Indie ref one even though it has more variables.

[^FNSCOT]: 'Scottish', as is customary, simply means people living (or at least interviewed) in Scotland. Adding country of birth as an explanatory variable would be interesting.

[^FNLON]: The [Resolution Foundation study][Resolution] finds this, too.

[Resolution]: http://www.resolutionfoundation.org/media/blog/why-did-we-vote-to-leave-what-an-analysis-of-place-can-tell-us-about-brexit/ "Clarke, Stephen. Why Did We Vote to Leave? What an Analysis of Place Can Tell Us about Brexit. Resolution Foundation, 15 July 2016."
[Wings]: http://wingsoverscotland.com/spotting-the-differences/ "Campbell, Stuart ‘Spotting the Differences’. Wings Over Scotland, 10 November 2016."
[Rowntree]: https://www.jrf.org.uk/report/brexit-vote-explained-poverty-low-skills-and-lack-opportunities "Goodwin, Matthew, and Oliver Heath. ‘Brexit Vote Explained: Poverty, Low Skills and Lack of Opportunities’. JRF, 26 August 2016."
[LSE]: http://blogs.lse.ac.uk/politicsandpolicy/personal-values-brexit-vote/ "Kaufmann, Eric: ‘It’s NOT the Economy, Stupid: Brexit as a Story of Personal Values’. British Politics and Policy at LSE, 7 July 2016."
[TECHNOTE]: http://virtual-worlds-research.com/scot/brexit_model_discussion.html "Stark, Graham: Brexit vs Indie: Model Notes and Links"
[BES]: http://www.britishelectionstudy.com/ "The British Election Study"
[ASA]: http://www.tandfonline.com/doi/full/10.1080/00031305.2016.1154108 "Wasserstein, Ronald L., and Nicole A. Lazar. ‘The ASA’s Statement on P-Values: Context, Process, and Purpose’. The American Statistician 70, no. 2 (2 April 2016): 129–33. doi:10.1080/00031305.2016.1154108."