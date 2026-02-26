--Creating a new table with proper data types
CREATE TABLE [dbo].[netflix_raw](
    [show_id] NVARCHAR(10) primary key ,
    [type] NVARCHAR(10) NULL,
    [title] NVARCHAR(200) NULL,
    [director] NVARCHAR(250) NULL,
    [cast] NVARCHAR(1000) NULL,
    [country] NVARCHAR(150) NULL,
    [date_added] NVARCHAR(20) NULL,
    [release_year] INT NULL,
    [rating] NVARCHAR(10) NULL,
    [duration] NVARCHAR(10) NULL,
    [listed_in] NVARCHAR(100) NULL,
    [description] NVARCHAR(500) NULL);

select * from netflix_raw where show_id='s5023'
--checking for dublicates
select show_id, count(*)
from netflix_raw
group by show_id
having count(*) >1


select * from netflix_raw
where CONCAT(title,type) in (
select concat (title,type)
from netflix_raw
group by title,type
having count(*) >1 )
order by title

with cte as ( select * ,
row_number() over (partition by title , type order by show_id ) as rn 
from netflix_raw
)
select show_id,type,title,CAST(date_added as date)as date_added, release_year,rating,case when duration is null then rating else duration end as duration  ,description  
into netflix
from cte where rn=1 
select* from netflix

--new table for listed_in,director, country,cast

--data type conversions for date added 

--populate missing values in country,duration columns

select show_id, trim(value) as Director
into netflix_directors
from netflix_raw
cross apply string_split(director, ',')

select show_id, trim(value) as country
into netflix_country
from netflix_raw
cross apply string_split(country, ',')


select show_id, trim(value) as cast
into netflix_cast
from netflix_raw
cross apply string_split(cast, ',')

select show_id, trim(value) as genre
into netflix_genre
from netflix_raw
cross apply string_split(listed_in, ',')

insert into netflix_country
select show_id,m.country
from netflix_raw nr
inner join( select director,country
from netflix_country nc 
inner join netflix_directors nd  on nc.show_id=nd.show_id
group by country, director)m on nr.director=m.director
where nr.country is null 

select director , country
from netflix_country nc inner join
netflix_directors nd on nc.show_id=nd.show_id
group by director, country 
order by Director

select* from netflix
select * from netflix_raw where duration is null 
--populate rest of the nulls as not_available
--drop columns director , listed_in,country,cast


-----------DATA ANALYSIS----------

--Q1 for each director count the no of movies and tv shows created by them in seperate columns for directpors who have created tv shows and movies both 
select nd.director ,COUNT(distinct case when n.type='movie' then n.show_id end )as no_of_movies 
,COUNT(distinct case when n.type='TV show' then n.show_id end )as no_of_tvshows
from netflix n  inner join netflix_directors nd on n.show_id = nd.show_id 
group by nd.director
having count(distinct n.type)>1

--Q2 which country has the highest no of comedy movies 
select top 1 nc.country ,count(distinct ng.show_id) as no_of_movies
from netflix_genre ng
inner join netflix_country nc on ng.show_id=nc.show_id
inner join netflix n on n.show_id=ng.show_id
where ng.genre='comedies' and n.type='movie'
group by nc.country
order by no_of_movies desc

--Q3 for each year ( as per date added to netflix) , which director has maximum number of movies released 
with cte as (

select nd.Director,year(n.date_added) as Added_year, count (n.show_id) as Number_of_movies from  netflix n
    inner join netflix_directors nd 
        on n.show_id=nd.show_id
        where type='Movie'
        group by nd.Director,year(n.date_added)
            )
, cte2 as(
select*, row_number() over(partition by Added_year order by Number_of_movies desc, director)as Rank
from cte)

select* from cte2 where Rank=1

--Q4 what is average duration of movies in each gener 

select n.show_id,ng.genre, avg(cast(replace(duration,' min','')as int))as Duration_of_movie
from netflix n 
inner join netflix_genre ng on n.show_id=ng.show_id
where type = 'Movie'
group by n.show_id,ng.genre
order by Duration_of_movie desc

--Q5 find the list of directors who have created horror and comedy movies both 
--Q5a display directors names along with number of comedy and horror movies directed by them 

select nd.director, 
count(distinct case when ng.genre='comedies' then n.show_id end) as No_of_Comedy,
 count(distinct case when ng.genre='Horror Movies' then n.show_id end) as No_of_Horror
  from netflix n 
    inner join netflix_genre ng on n.show_id=ng.show_id
        inner join netflix_directors nd on n.show_id = nd.show_id
            where type ='Movie' and genre in('Comedies','Horror Movies')
                group by nd.Director        
                    having count(distinct ng.genre)=2
             
            

