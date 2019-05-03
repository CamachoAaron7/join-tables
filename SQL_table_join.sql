show databases; -- Shows available databases -- 
use dev_tt_56421087; -- Tells MySQL to use a particular database in this case "dev_tt_56421087" --
show tables; -- Shows available tables the database being used -- 
Select * from state_population_estimates_2016; -- Selects ALL from a TABLE -- 
Select * from state_population_estimates_2015; -- Selects ALL from a TABLE --

#  Shows the unrounded difference between the current and vintage State population estimates for years 2010 through 2015.
SELECT State, results.est_diff_2010, results.est_diff_2011, results.est_diff_2012, results.est_diff_2013, results.est_diff_2014, results.est_diff_2015 from
(SELECT State, 
(state_population_estimates_2016.est2010_16 - state_population_estimates_2015.est2010_15) as est_diff_2010,
(state_population_estimates_2016.est2011_16 - state_population_estimates_2015.est2011_15) as est_diff_2011,
(state_population_estimates_2016.est2012_16 - state_population_estimates_2015.est2012_15) as est_diff_2012,
(state_population_estimates_2016.est2013_16 - state_population_estimates_2015.est2013_15) as est_diff_2013,
(state_population_estimates_2016.est2014_16 - state_population_estimates_2015.est2014_15) as est_diff_2014,
(state_population_estimates_2016.est2015_16 - state_population_estimates_2015.est2015_15) as est_diff_2015 
FROM state_population_estimates_2016
INNER JOIN state_population_estimates_2015 
ON state_population_estimates_2016.est_id = state_population_estimates_2015.est_id 
group by state_population_estimates_2016.est_id)
as results
order by results.State ASC
;

# Retuns Differences of all Calculated Values rounded to tens of thousands that are > 10,0000 
SELECT State, results.est_diff_2010, results.est_diff_2011, results.est_diff_2012, results.est_diff_2013, results.est_diff_2014, results.est_diff_2015 from
(SELECT State, 
ROUND(state_population_estimates_2016.est2010_16 - state_population_estimates_2015.est2010_15, -4) as est_diff_2010,
ROUND(state_population_estimates_2016.est2011_16 - state_population_estimates_2015.est2011_15, -4) as est_diff_2011,
ROUND(state_population_estimates_2016.est2012_16 - state_population_estimates_2015.est2012_15, -4) as est_diff_2012,
ROUND(state_population_estimates_2016.est2013_16 - state_population_estimates_2015.est2013_15, -4) as est_diff_2013,
ROUND(state_population_estimates_2016.est2014_16 - state_population_estimates_2015.est2014_15, -4) as est_diff_2014,
ROUND(state_population_estimates_2016.est2015_16 - state_population_estimates_2015.est2015_15, -4) as est_diff_2015 
FROM state_population_estimates_2016
INNER JOIN state_population_estimates_2015 
ON state_population_estimates_2016.est_id = state_population_estimates_2015.est_id 
WHERE (ABS(state_population_estimates_2016.est2010_16 - state_population_estimates_2015.est2010_15) > 10000
or ABS(state_population_estimates_2016.est2011_16 - state_population_estimates_2015.est2011_15) > 10000
or ABS(state_population_estimates_2016.est2012_16 - state_population_estimates_2015.est2012_15) > 10000
or ABS(state_population_estimates_2016.est2013_16 - state_population_estimates_2015.est2013_15) > 10000
or ABS(state_population_estimates_2016.est2014_16 - state_population_estimates_2015.est2014_15) > 10000
or ABS(state_population_estimates_2016.est2015_16 - state_population_estimates_2015.est2015_15) > 10000)
group by state_population_estimates_2016.est_id)
as results
order by results.State ASC
;