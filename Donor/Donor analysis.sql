#1
select count(*)
from shares1;
#2
select min(shrprice)
from shares1;
#3
select avg(shrpe)
from shares1;
#4
select max(shrdiv/shrprice) as Highest_Yield
from shares1;

#5
select year,sum(amount) as Total_Amount
from gift
group by year
order by year;
#6
select year,count(distinct donorno) as Number_of_Donors
from gift 
group by year
having count(distinct donorno) >= 10;

#7
select donorno, dlname, dfname
from donor
where donorno not in (select donorno from gift where year = '1995');
#8
select donorno, dlname, dfname
from donor
where donorno in (select donorno 
                    from gift 
                    group by donorno
                    having sum(amount) > (select avg(amount) from gift)*2);
#9
select year,sum(amount) as Total_Donated
from gift 
group by year
having sum(amount) > (select max(yeargoal) from year);
#10
select donorno, dstate, dlname, dfname
from donor
where donorno = (select donorno from gift 
                    where year='1993'and 
                    amount=(select min(amount) from gift where year ='1993'));
#11
select donorno, dlname, dfname
from donor 
where donorno = (select donorno from gift 
                    where year='1992'and 
                    amount=(select max(amount) from gift where year ='1992'))
union
select donorno, dlname, dfname
from donor 
where donorno = (select donorno from gift 
                    where year='1992'and 
                    amount=(select min(amount) from gift where year ='1992'));
                    
#12
select *
from donor, gift, year
where donor.donorno = gift.donorno and gift.year = year.year;

#13
select donor.donorno, donor.dlname,donor.dfname,sum(gift.amount) as Total_Amount
from donor, gift
where donor.donorno = gift.donorno
group by donor.donorno,donor.dlname, donor.dfname
order by donor.dlname;

#14
select donor.dstate, sum(gift.amount) as Total_Amount
from donor,gift
where donor.donorno = gift.donorno and gift.year='1994'
group by donor.dstate;

#15
select distinct gift.donorno,donor.dlname, donor.dfname, gift.year
from donor, gift 
where donor.donorno = gift.donorno 
and gift.year in (select gift.year 
                     from gift, year
                     where gift.year = year.year
                     group by gift.year, year.yeargoal
                     having sum(gift.amount) > year.yeargoal);
                                

