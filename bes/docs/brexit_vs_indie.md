Title: The Scottish IndieRef and Brexit: how similar were they? A look at the data.
Author: Graham Stark 
Address: 
Date: 4th December 2016

Brexit, the US Presidential election, the rise of far-right parties in France,
Holland, Austria and elsewhere all seem to be part of a new and disturbing
Populist wave. Was the Scottish Independence referendum part of that? It's
certainly been portrayed in that way: Wings Over Scotland - not everyone's cup
of tea, but usually careful and accurate - has [a compendium of claims on this
from the Twittersphere][WINGS].

The Indie and EU Referendums certainly *felt* very different to me, and the Scottish Independence movement seems a very
different thing to Vote Leave. But that's just one person's impressions. Sometimes, you have to look at the numbers -
the big picture can be very different.

The [Wings blogpost][WINGS] uses some opinion poll data to make a case for the
IndieRef being different. That's useful, but I'd like to look at this in a
slightly more systematic and precise way, using techniques from my day-job doing
economic modelling.

There are now some good empirical studies of the type I have in mind, trying to explain the Brexit vote:

* [A recent study by Matthew Goodwin and Oliver Heath for the Rowntree Foundation][Rowntree] uses data on 19,000
  individual voters from the [British Election Survey][BES] (BES). Goodwin and Heath build a statistical model which links
  the Brexit vote[^FN1] chiefly to economic factors - poverty, low skills, deprivation, and as well as demographic factors
  such as age and gender.

* by contrast, [Eric Kaufmann of the London School of Economics][LSE] also uses the BES dataset but argues *against* the
  primacy of economic factors in the Brexit Vote [^FN2].Instead he argues for authoritarian and conformist attitudes as
  the main driver.

* [A study for the Resolution Foundation by Stephen Clarke][Resolution] uses local authority level data - unemployment
  rates, educational attainment, numbers of recent immigrants and so on, to paint a picture somewhere between the two -
  they find high recent immigration a driver.

What I'm going to do here is build a statistical model in a similar vein to these, using a later version of the same
data as the LSE and Rowntree study. Like those studies, my model uses a variety of factors ("explanatory variables", in
the jargon) to explain how people voted in the European Referendum. I'll then apply the model to the Scottish[^FNSCOT] part
of the BES data, to explain the IndieRef vote [^FNMODEL]. I show that the model explains both votes well, but the
factors (age, sex, etc.) often work very differently in the two cases - sometimes working in the opposite way, sometimes
working strongly in one case but not the other.

[A companion note][TECHNOTE] discusses my model in a detail. There, you'll fine everything you'll need to replicate and
extend my model, discussions of the choices I've made, and full results for several different model variants. But, for
now, in summary:

* I'm building a statistical model (a "binomial Probit regression", in the
  jargon) that shows how the vote in both referendums was influenced by various
  factors such as education, age, income and political allegiance;

* I'm using a more recent version of the same BES data as the Rowntree and LSE studies. The data in those studies
  doesn't actually have peoples' Brexit vote in it; instead they used either intended votes (Rowntree) or attitudes to the
  EU (LSE). My version does have people's actual Brexit vote, as well as the IndieRef vote;

* the model allows each factor to be isolated from the others - so, for example, we can study the influence of education
  on voting, holding income and other factors constant. This is important as our explanatory variables are often correlated with each
  other - better education usually leads to higher incomes, earnings increases (up to a point) with age, and so on;

* my model is closest in spirit to the Rowntree study, though I do some things differently. There are also some ideas from
  the other studies thrown in;

* I'm going to use the same set of factors (income, age, gender and so on) to explain *both* the Scottish Independence
  and EU Referendum Votes. That puts a few constraints on what parts of the data I can use.

[Table 1](#table-1) summarises the main findings. This table is the simplest way I can think of to boil down the huge
amount of information my computer program spits out. I hope it makes sense; the full data is in [the companion
paper][TECHNOTE]. Each column summarises one of our models that explain the votes. The first column (1) is our model of
the Scottish Independence vote. Columns(2) and (3) are models of the EU Referendum; (2) uses data for Great Britain as a
whole [^FN4], and (3) just uses people living in Scotland. The rows summarise the effect of each variable on the vote.
The green up-arrows '<span class='positive_strong'>&#x21c8; </span>', '<span class='positive_med'>&#x2191;</span>' and
'<span class='positive_weak'>&#x21e1;</span>' indicate things that have a significant *positive* effect on a 'Yes' (or
'Leave'), vote, from the strongest to the weakest[^FNSIG]. Likewise the red down arrows '<span
class='negative_strong'>&#x21ca;</span>', '<span class='negative_med'>&#x2193;</span>' and '<span
class='negative_weak'>&#x21e3;</span>' signify negative effects. Variables that don't appear significant are
indicated with '<span class='nonsig'>&#x25CF;</span>'. Although my models do a good job of capturing how the votes
varied by income, age, sex and so on, they of course don't explain everything - you could posses all the indicators that
were associated with a 'Yes' note, but still have voted 'No', and vice versa.

**Table 1**

<table class='easytable'>
<thead>
<tr>
<td class='col_header' style='border-bottom: 1px solid black' colspan='4'></td>
</tr>
<tr>
<td class='col_header' style='text-align:left'></td>
<td class='col_header' colspan='3'></td>
</tr>
<tr>
<td class='col_header'></td>
<td class='col_header' style='border-bottom: 1px solid black' colspan='3'></td>
</tr>
<tr>
<td class='col_header' style='text-align:left'></td>
<td class='col_header'>Voted Yes in Scottish Referendum</td>
<td class='col_header' colspan='2'>Voted Leave in EU Ref</td>
</tr>
<tr>
<td class='col_header' style='text-align:left'></td>
<td class='col_header'>Scotland Only</td>
<td class='col_header'>All GB</td>
<td class='col_header'>Scotland Only</td>
</tr>
<tr>
<td class='col_header' style='text-align:left'></td>
<td class='col_header'>(1)</td>
<td class='col_header'>(2)</td>
<td class='col_header'>(3)</td>
</tr>
</thead>
<tbody>
<tr>
<th class='row_header'>Income</th>
<td class='negative_strong'>&#x21ca;</td>
<td class='negative_strong'>&#x21ca;</td>
<td class='negative_med'>&#x2193;</td>
</tr>
<tr>
<th class='row_header'>Age</th>
<td class='negative_strong'>&#x21ca;</td>
<td class='positive_strong'>&#x21c8;</td>
<td class='positive_med'>&#x2191;</td>
</tr>
<tr>
<th class='row_header'>Female</th>
<td class='negative_strong'>&#x21ca;</td>
<td class='negative_weak'>&#x21e3;</td>
<td class='nonsig'>&#x25CF;</td>
</tr>
<tr>
<th class='row_header'>Highest Education: A Level/Higher Grade</th>
<td class='nonsig'>&#x25CF;</td>
<td class='negative_strong'>&#x21ca;</td>
<td class='negative_strong'>&#x21ca;</td>
</tr>
<tr>
<th class='row_header'>Highest Education: Non-Degree Further</th>
<td class='nonsig'>&#x25CF;</td>
<td class='negative_strong'>&#x21ca;</td>
<td class='negative_strong'>&#x21ca;</td>
</tr>
<tr>
<th class='row_header'>Highest Education: Degree or Equivalent</th>
<td class='nonsig'>&#x25CF;</td>
<td class='negative_strong'>&#x21ca;</td>
<td class='negative_strong'>&#x21ca;</td>
</tr>
<tr>
<th class='row_header'>Ethnic Minority</th>
<td class='nonsig'>&#x25CF;</td>
<td class='negative_weak'>&#x21e3;</td>
<td class='nonsig'>&#x25CF;</td>
</tr>
<tr>
<th class='row_header'>Has Children</th>
<td class='nonsig'>&#x25CF;</td>
<td class='positive_strong'>&#x21c8;</td>
<td class='positive_med'>&#x2191;</td>
</tr>
<tr>
<th class='row_header'>Has a Partner</th>
<td class='nonsig'>&#x25CF;</td>
<td class='positive_strong'>&#x21c8;</td>
<td class='nonsig'>&#x25CF;</td>
</tr>
<tr>
<th class='row_header'>Identifies Conservative</th>
<td class='negative_strong'>&#x21ca;</td>
<td class='positive_strong'>&#x21c8;</td>
<td class='positive_med'>&#x2191;</td>
</tr>
<tr>
<th class='row_header'>Identifies Libdem</th>
<td class='negative_strong'>&#x21ca;</td>
<td class='negative_strong'>&#x21ca;</td>
<td class='negative_strong'>&#x21ca;</td>
</tr>
<tr>
<th class='row_header'>Identifies Labour</th>
<td class='negative_strong'>&#x21ca;</td>
<td class='negative_strong'>&#x21ca;</td>
<td class='negative_strong'>&#x21ca;</td>
</tr>
<tr>
<th class='row_header'>Identifies Green</th>
<td class='positive_strong'>&#x21c8;</td>
<td class='negative_strong'>&#x21ca;</td>
<td class='negative_strong'>&#x21ca;</td>
</tr>
<tr>
<th class='row_header'>Identifies UKIP</th>
<td class='negative_strong'>&#x21ca;</td>
<td class='positive_strong'>&#x21c8;</td>
<td class='nonsig'>&#x25CF;</td>
</tr>
<tr>
<th class='row_header'>Identifies SNP</th>
<td class='positive_strong'>&#x21c8;</td>
<td class='negative_strong'>&#x21ca;</td>
<td class='negative_strong'>&#x21ca;</td>
</tr>
<tr>
<th class='row_header'>Religion: Catholic</th>
<td class='positive_weak'>&#x21e1;</td>
<td class='nonsig'>&#x25CF;</td>
<td class='nonsig'>&#x25CF;</td>
</tr>
<tr>
<th class='row_header'>Religion: Any Protestant</th>
<td class='negative_strong'>&#x21ca;</td>
<td class='positive_strong'>&#x21c8;</td>
<td class='positive_strong'>&#x21c8;</td>
</tr>
<tr>
<th class='row_header'>Big5: Openness</th>
<td class='positive_strong'>&#x21c8;</td>
<td class='negative_med'>&#x2193;</td>
<td class='nonsig'>&#x25CF;</td>
</tr>
<tr>
<th class='row_header'>North East</th>
<td></td>
<td class='nonsig'>&#x25CF;</td>
<td></td>
</tr>
<tr>
<th class='row_header'>North West of England</th>
<td></td>
<td class='nonsig'>&#x25CF;</td>
<td></td>
</tr>
<tr>
<th class='row_header'>Yorkshire and Humberside</th>
<td></td>
<td class='nonsig'>&#x25CF;</td>
<td></td>
</tr>
<tr>
<th class='row_header'>London</th>
<td></td>
<td class='negative_weak'>&#x21e3;</td>
<td></td>
</tr>
<tr>
<th class='row_header'>South of England</th>
<td></td>
<td class='negative_strong'>&#x21ca;</td>
<td></td>
</tr>
<tr>
<th class='row_header'>Wales</th>
<td></td>
<td class='negative_strong'>&#x21ca;</td>
<td></td>
</tr>
<tr>
<th class='row_header'>Scotland</th>
<td></td>
<td class='negative_strong'>&#x21ca;</td>
<td></td>
</tr>
</tbody>
</table>

#### Key ####
<table>
<tr><th>Positive Association</th>
<td class='positive_strong'>&#x21c8; Strong </td>
<td class='positive_med'>&#x2191; Medium</td>
<td class='positive_weak'>&#x21e1; Weak</td>
</tr>
<tr><th>Negative Association</th>
<td class='negative_strong'>&#x21ca; Strong</td>
<td class='negative_med'>&#x2193; Medium </td>
<td class='negative_weak'>&#x21e3; Weak</td>
</tr>
<tr><th>No Significant Association</th>
<td class='nonsig'>&#x25CF;</td>
<td colspan='2'>
</tr>
</table>

Let's look at IndyRef first. That's column (1): 

* The first cell summarises the influence of income on the Scottish Independence
  vote. The '<span class='negative_strong'>&#x21ca;</span>' in that cell indicates that income has a strongly
  significant *negative* effect on the likelihood of voting "Yes" in the IndyRef - 
  the higher your household's income, the less likely you were to vote 'yes', all else equal, and we
  can be confident this effect is real;

* Next we have age - this is also significantly negative - the older you are,
  the less likely to vote 'yes' [^FN5];
   
* You interpret '<span class='negative_strong'>&#x21ca;'</span> in the next row "Gender - Female" as meaning that women
  were significantly less likely to vote 'yes' than men with the same level of income, qualifications, etc.;

* The next three lines show the effect of increasing levels of education. There's essentially no effect. People of all
  levels of education were equally likely to vote for Independence;

* Likewise, family circumstances seem to matter little;

* Political affiliation does matter [^FN6]. The results go the expected ways, though it's tricky to interpret this -
  whilst it's quite plausible that liking the SNP would make someone more likely to vote 'yes', it could just as easily be
  that that people identify with the SNP because they want independence. Likewise, in reverse, for the Conservative (and
  Unionist) party. We might need a more sophisticated model to capture what's really going on there; that would be an
  interesting exercise. For Labour, the Greens and the Liberal Democrats it's perhaps more plausible that the effects we
  see run from identification with the party to which way people voted - perhaps some people really do follow the lead of
  their parties.
  
* Practising Protestants were significantly more likely to vote 'No' (and Catholics slightly more
  likely to vote Yes)..
  
* Finally, in the spirit of the LSE study, we include a measure of how voting is influenced by a person's [openness to
  new experiences](https://en.wikipedia.org/wiki/Big_Five_personality_traits). "Openness" is defined as: "a general
  appreciation for art, emotion, adventure, unusual ideas, imagination, curiosity, and variety of experience". Openness in
  this sense is strongly associated with a "Yes" vote.
  
To make this a bit more concrete, imagine a 30 year old woman, politically
neutral, on median houshold income (about £27,000 in this dataset), with an HND,
and scoring averagely on our Openness scale. Our model gives her a 40% chance of
having voted 'Yes' in the IndieRef. A man in the same position would be 7 points
more likely to vote yes than this, whereas an otherwise similar woman aged 70 would be 9 points *less* likely.
SNP supporters, reasonably enough were virtual certainties to vote yes, regardless of
any other characteristic.
 
In sum, the picture that emerges is that Yes was in most respects the progressive, optimistic, Left-leaning vote. Yes
votes were associated with lower incomes, but people of all education levels voted both ways, and open-minded and the
young, were more likely to vote 'yes'. Conventional politics and religion mattered in interesting ways.

Next, the Brexit vote. We're modelling a "Leave" vote, so Up-Arrows mean "more likely to vote 'Leave'. Column 2 uses
data from the whole UK; column 3 just uses people living in Scotland. For the all-UK case I'm going to add in variables
showing which region people lived in; this can tell us (broadly) whether there really was a 'London Effect', or indeed
'Scottish Effect' in the Brexit vote that can't be explained by Londoners and Scots having different levels of
education, income, and so on[^FNREG].

Reading down column 2 shows a very different pattern than for the Indie ref, one which does seem consistent with the
Populist,or even reactionary, interpretation that many have put on the vote. There is a strong link between education
and a 'Leave' vote: those with degrees or 'A-levels' were much more likely to vote "Remain". Political affiliations work
in reverse from the IndieRef, with Conservatives much more likely to vote Leave and Socialists, Liberals and
Nationalists much more likely to vote 'Remain'. "Leave" rises steadily with age. The more open minded you are, the less
likely to vote "Leave". The regional effects are interesting: , once we've controlled for the other factors, there is no
real evidence of a distinct "London effect" for Remain, or a North East of England effect for Leave [^FNLON]. But there
*are* pro-Remain Scottish and Welsh effects - although Wales voted for Brexit, in this model the Leave vote was *lower*
than you'd expect given incomes, education and age.

Column (3) runs the same analysis for Scottish voters only. Here, you see some of the patterns of the UK-Wide
Brexit vote coming though, notably the negative effects education, income, and age, and political affiliations are
similar, but other things (openness, gender) that mattered GB-wide were not significant in Scotland.  

To return to our example, our 30 year old woman would have had about a 30%
chance of voting 'Leave' if she was living in Scotland; an otherwise similar
woman from the Midlands of England would have had a 40% chance of voting leave
Leave. At age 60, the chances of voting Leave would be about 12% higher.

It's customary to end work like this with "more research is required". And it is: there are certainly many things that
could be done better, or at least differently. If anyone is interested in taking this on, [most of what you'll need is
available][TECHNOTE]. But I'm confident that the key findings here are robust: empirically, IndieRef and the Brexit vote
were very different things.

[Graham Stark](mailto:graham.stark@virtual-worlds-research.com)

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