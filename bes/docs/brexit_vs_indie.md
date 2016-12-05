Title: Were the Scottish and EU Referendums driven by the same things?
Author: Graham Stark 
Address: 
Date: 28th November 2016

Brexit and the US Presidential, Marine Le Pen []. Is the independence movement part of that? 
Didn't feel like that to me. But the link has been made. David Torrance, for example [wrote]

> Of course all these things aren’t true, not that that really matters, and just because one of those nationalisms is
admirably pro-immigration and the other anti- doesn’t mean there is some fundamental difference between the two, just
that it manifests itself in different ways.

[Wings of Scotland][Wings] has a 

There has been, of course, lots of good journalism on Brexit and its aftermath
(I particularly like [John Harris]() and [Chris Arnade](). But there are also now
some good scholarly, empirical studies of the Brexit vote:

* [A recent study by Matthew Goodwin and Oliver Heath for the Rowntree Foundation][Rowntree] uses data on 19,000
  individual voters from the [British Election Survey][BES] (BES). Goodwin and Heath build a statistical model (a 'binomial
  logit regression') which links the Brexit vote[^FN1] chiefly to economic factors - poverty, low skills, deprivation, and
  as well as demographic factors such as age and gender.

* by contrast, [Eric Kaufmann of the London School of Economics][LSE] also uses the BES dataset but argues *against* the
  primacy of economic factors in the Brexit Vote [^FN2].Instead he argues for authoritarian and conformist attitudes as
  the main driver.

* [A study for the Resolution Foundation by Stephen Clarke][Resolution] uses local authority level data - unemployment
  rates, educational attainment, numbers of recent immigrants and so on, to paint a picture somewhere between the two -
  they find high recent immigration a driver.

What I'm going to do here is build a statistical model in a similar vein to these, using a later version of the same
data as the LSE and Rowntree study. I'll use the model to explain the Brexit vote but also apply it to the IndieRef
vote, which is also recorded in the BES data. I'll show that the model explains both votes well, but the factors (age,
sex, etc.) often work differently in the two cases - sometimes working in the opposite way, sometimes working strongly
for one vote but not for the other.

[A companion note][TECHNOTE] discusses my model in a detail. There, you'll fine everything you'll need to replicate and
extend my model, discussions of the choices I've made, and full results for several different model variants. But, for
now, in summary:

* I'm building a statistical model that shows how the vote in both referenda was influenced by various factors such as
  education, age, income and political allegiance;

* I'm using a more recent version of the same BES data as the Rowntree and LSE studies. The data in those studies
  doesn't actually have peoples Brexit vote in it, instead they used either intended votes (Rowntree) or attitudes to the
  EU (LSE). My version does have people's actual Brexit vote, as well as the IndieRef vote;

* the model allows each factor to be isolated from the others - so, for example, we can study the influence of education
  on voting, holding income and other factors constant;

* my model is closest in spirit to the Rowntree study, though I do some things differently. There are also some ideas from
  the other studies thrown in;

* I'm going to use the same set of factors (income, age, gender and so on) to explain *both* the Scottish Independence
  and EU Referendum Votes. That puts a few constraints on what parts of the data I can use.

[Table 1](#table-1) summarises the main findings.

This is the simplest way I can find to boil down the huge amount of information the computer program spits out. Each
column summarises one of our models that explain the votes. The first column (1) is our model of the Scottish
Independence vote. The other (2 - 3) are models of the EU Referendum, one for Great Britain as a whole [^FN4], and one
for Scotland. The rows summarise the effect of one variable on the vote. An up arrow ![<span
class='negative_strong'>&#x1F883;'</span>] means that that thing has a strong positive influence on voting 'yes'; the
thicker the arrow the stronger the influence, and vice-versa for the down arrows

Let's look at IndyRef first. That's column (1). 

* The first cell summarises the influence of income on the Scottish Independence
  vote. The '<span class='negative_strong'>&#x21ca;</span>' in that cell indicates that income has a strongly
  significant *negative* effect on the likelihood of voting "Yes" in the indyRef - 
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
  Unionist) party. We might need a more sophisticated model to capture what's really going on there. For Labour, the
  Greens and the Liberal Democrats it's perhaps more plausible that the effects we see run from identification with the party to
  which way people voted - perhaps some people really do follow the lead of their parties. Modelling this interaction fully
  would be an interesting exercise.
  
* Perhaps unsurprisingly, practising Protestants were significantly less likely to vote yes (and Catholics slightly more
  likely to vote Yes)..
  
* Finally, in the spirit of the LSE study, we include a measure of how openness to new experiences influences the vote.
 (https://en.wikipedia.org/wiki/Big_Five_personality_traits). "Openness is a general appreciation for art, emotion,
 adventure, unusual ideas, imagination, curiosity, and variety of experience". "Openness in this sense is strongly
 associated with a "Yes" vote.
 
In sum, the picture that emerges is that yes was in most respects the progressive, optimistic, vote. Yes votes were associated
with lower incomes, but people of all education levels voted both ways, and open-minded and the young, were more likely to
vote 'yes'. Conventional politics and religion mattered in interesting ways.

Next, the Brexit vote. We're modelling a "Leave" vote, so Up-Arrows mean "more likely to vote 'Leave'. Column 2 uses
data from the whole UK; column 3 just uses Scottish cases. For the all-UK case I'm also going to capture regional
effects - was there really a 'London Effect', or indeed 'Scottish Effect' that can't be explained by Londoners and Scots
having income, education [FN we report the model without these [below][], showing that adding these doesn't affect our
other conclusions, so this model is still comparable with the Indie ref one even though it has more variables].

Reading down column 2 shows a very different pattern than for the Indie ref. The unqualified were much more likely to
vote "Leave", " whilst political affiliations work in reverse from the IndieRef. "Leave" rises steadily with age. The
more open minded you are, the less likely to vote "Leave". The regional effects are interesting: , once we've controlled
for the other factors, there is no evidence of a distinct "London effect" for Remain, or a North East of England effect
for Leave [^FN3] FN: Resolution Foundation finds this, too].But there *are* a Scottish and Welsh
effect (for Remain).

That was for the whole GB; column (3) runs this analysis for Scotland only. The drivers for 'Leave' are very similar,
but weaker, than for GB as a whole. 

### Table 1 ###

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
<td class='positive_weak'>&#x21e1;</td>
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
<td class='positive_weak'>&#x21e1;</td>
<td class='negative_strong'>&#x21ca;</td>
<td class='negative_strong'>&#x21ca;</td>
</tr>
<tr>
<th class='row_header'>Ethnic Minority</th>
<td class='nonsig'>&#x25CF;</td>
<td class='nonsig'>&#x25CF;</td>
<td class='nonsig'>&#x25CF;</td>
</tr>
<tr>
<th class='row_header'>Has Children</th>
<td class='nonsig'>&#x25CF;</td>
<td class='positive_strong'>&#x21c8;</td>
<td class='positive_strong'>&#x21c8;</td>
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
<table class='easytable'>
<tr><th>Positive Association</th>
<td class='positive_strong'>&#x21c8; Strong </td>
<td class='positive_med'>&#x2191; Medium</td>
<td class='positive_weak'>&#x21e1;</td>
</tr>
<tr><th>Negative Association</th>
<td class='negative_strong'>Strong &#x21ca;</td>
<td class='negative_med'>Medium &#x2193;</td>
<td class='negative_weak'>Weak &#x21e3;</td>
</tr>
<tr><th>No Significant Association</th>
<td class='nonsig'>&#x25CF;</td>
<td colspan='2'>
</tr>
</table>


[Graham Stark](mailto:graham.stark@virtual-worlds-research.com)

[^FN1]: The study was completed after the vote but before an edition of the BES with the vote data had been released;
instead, Goodwin and Heath model *intention* to vote (6 months before), which is a good though not perfect correlate with actual vote.

[^FN2]: Kaufmann's study was carried out even earlier, before the actual Brexit vote: instead of explaining the vote he is modelling the
extent to which people disapprove of the EU, which, too, is a good predictor of the final vote.

[^FN3]: Strictly speaking, there is no London effect relative to the "ommited dummy", - the Midlands - the [technical note][TECHNOTE] explains this in more detail; 

[^FN4]: it's 'Great Britain' rather than 'United Kingdom' since Northern Ireland is not in the BES data.

[^FN5]: in the IndieRef case, this is actually a bit of a simplification - see the [Technical Note][TECHNOTE] for more detail.

[^FN6]: these are the parties people *identify* with; they needn't be members.

[Resolution]: http://www.resolutionfoundation.org/media/blog/why-did-we-vote-to-leave-what-an-analysis-of-place-can-tell-us-about-brexit/ "Clarke, Stephen. Why Did We Vote to Leave? What an Analysis of Place Can Tell Us about Brexit. Resolution Foundation, 15 July 2016."
[Wings]: http://wingsoverscotland.com/spotting-the-differences/ "Campbell, Stuart ‘Spotting the Differences’. Wings Over Scotland, 10 November 2016."
[Rowntree]: https://www.jrf.org.uk/report/brexit-vote-explained-poverty-low-skills-and-lack-opportunities "Goodwin, Matthew, and Oliver Heath. ‘Brexit Vote Explained: Poverty, Low Skills and Lack of Opportunities’. JRF, 26 August 2016."
[LSE]: http://blogs.lse.ac.uk/politicsandpolicy/personal-values-brexit-vote/ "Kaufmann, Eric: ‘It’s NOT the Economy, Stupid: Brexit as a Story of Personal Values’. British Politics and Policy at LSE, 7 July 2016."
[TECHNOTE]: http://virtual-worlds-research.com/scot/brexit_model_discussion.html "Stark, Graham: Brexit vs Indie: Model Notes and Links"
[BES]: http://www.britishelectionstudy.com/ "The British Election Study"
