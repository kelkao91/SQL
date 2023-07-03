#16
Select Tag.TagID, Tag.TagName, Played.PID
from Tag inner join Played on Tag.TagID = Played.TagID;

#17
Select Tag.TagID, Tag.TagName, Played.PID
from Tag left join Played on Tag.TagID = Played.TagID;

#18
Select member.userid as "userID", member.username as "Username", 
manager.userid as "ID of Manager", manager.username as "Username of manager"
from users member left join users manager on member.fpmanager_id = manager.userid
order by member.userid;

#19
Select member.userid as "userID", member.username as "Username", 
manager.username as "Username of manager", track.tname as "Track Name"
from users member left join users manager on member.fpmanager_id = manager.userid
inner join played on played.userid = member.userid
inner join track on played.tid = track.tid                                        
order by member.userid;

#20
Select ArtistID, ArtistName, Number_of_Awards
From Artist top3
Where (select count(distinct number_of_awards)
from Artist others
Where top3.number_of_awards < others.number_of_awards) <3
order by number_of_awards desc;

#21_CTE_method
With pop_albums as (select count(*) as "Number of Pop Albums" from album where genre='Pop'),
country_albums as (select count(*) as "Number of Country Albums" from album where genre='Country')
Select *
From pop_albums, country_albums;

#21_select_method
Select *
From (select count(*) as "Number of Pop Albums" from album where genre='Pop')  pop_albums, 
(select count(*) as "Number of Country Albums" from album where genre='Country')  country_albums;

#example_for_Case

SELECT aid, aname, 
CASE when price > price_per_track*5 
then 'Best Deal' else 'fff' 
END AS "Deal"
FROM album;


#22
With pop_albums as (select count(*) as "Number of Pop Albums" from album where genre='Pop'),
country_albums as (select count(*) as "Number of Country Albums" from album where genre='Country')
Select * 
CASE
    when "Number of Pop Albums" > "Number of Country Albums"
    then "Pop"
    else "Country"
END as "Higher Count Genre"
From pop_albums, country_albums;

#22_from_piazza
WITH pop_albums AS (SELECT COUNT(*) AS "Number of Pop Albums" FROM ALBUM WHERE genre = 'Pop'),
country_albums AS (SELECT COUNT(*) AS "Number of Country Albums" FROM ALBUM WHERE genre = 'Country')
SELECT "Number of Pop Albums", "Number of Country Albums",  
CASE WHEN "Number of Pop Albums" > "Number of Country Albums"
THEN 'Pop' ELSE 'Country'
END AS "Higher Count Genre"
FROM pop_albums, country_albums;

#22myself
with pop_albums as (select count(*) as "Number of Pop Album" from album where genre='Pop'),
country_albums as (select count(*) as "Number of Country Album" from album where genre='Country')
Select "Number of Pop Album", "Number of Country Album", 
case 
    when "Number of Pop Album" > "Number of Country Album"
    then 'Pop'
    else 'Country'
end as "Higher Count Genre"
from pop_albums, country_albums;

#23
SELECT SUM(
CASE
WHEN genre = 'Pop' THEN sales_qty
ELSE 0
END)/
SUM(
CASE 
WHEN genre = 'Country' THEN sales_qty
ELSE 0
END) AS "ratio"
FROM album;

#23myself
select sum(
case 
when genre='Pop' then sales_qty
else 0
end)/
sum(
case
when genre='Country' then sales_qty
else 0
end) as "Ratio"
from album;
