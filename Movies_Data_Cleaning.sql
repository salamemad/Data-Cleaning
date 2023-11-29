create database moives
  
use moives
--to identify and remove duplicate records.
---by using subquery
SELECT *
FROM [dbo].[Top_1000_Highest_Grossing_Movie$]
WHERE [Movie Title] IN (
    SELECT [Movie Title] as countt
    FROM [dbo].[Top_1000_Highest_Grossing_Movie$]
    GROUP BY [Movie Title]
    HAVING COUNT(*) > 1
);
---by using CTE
with dup as (select [Movie Title], count(*) as dup_count
from [dbo].[Top_1000_Highest_Grossing_Movie$]
group by [Movie Title])
select [dbo].[Top_1000_Highest_Grossing_Movie$].*,dup_count
from dup
join [dbo].[Top_1000_Highest_Grossing_Movie$]
on [dbo].[Top_1000_Highest_Grossing_Movie$].[Movie Title]=dup.[Movie Title]
where dup_count>1
ORDER BY [Movie Title]

-- to get no.columns
SELECT count(*) as No_of_Column FROM information_schema.columns 
-------------------------------------------------------------------------------------------------------------------------------------
--Remove leading and trailing spaces in text columns.
update [dbo].[Top_1000_Highest_Grossing_Movie$]
set [Movie Title]= TRIM([Movie Title])
, [Genre]= trim([Genre])
, [Logline] = trim([Logline])

-------------Identify columns with missing values
select*
from [dbo].[Top_1000_Highest_Grossing_Movie$]
where [Movie Title] is null

-------------------------------------------------------------------------------------------------------------------------------------
--change the type of coulmn [Year of Realease]
alter table [dbo].[Top_1000_Highest_Grossing_Movie$]
alter column [Year of Realease] int  ----as year data type is not provided in SSMS

-------------------------------------------------------------------------------------------------------------------------------------
-- Introduce a new field showing how old the movie is
select [Movie Title],[Year of Realease], year(GETDATE())-[Year of Realease] AS MOVIE_AGE
from [dbo].[Top_1000_Highest_Grossing_Movie$]

alter table [dbo].[Top_1000_Highest_Grossing_Movie$]
add movie_age int

update [dbo].[Top_1000_Highest_Grossing_Movie$]
set movie_age=year(GETDATE())-[Year of Realease]

select [Year of Realease], [movie_age]
from [dbo].[Top_1000_Highest_Grossing_Movie$]
-------------------------------------------------------------------------------------------------------------------------------------
-- Give an unique id to each movie
alter table [dbo].[Top_1000_Highest_Grossing_Movie$]
add Moive_ID varchar(225)

update [dbo].[Top_1000_Highest_Grossing_Movie$]
set Moive_ID=concat([Movie Title],'_',[Year of Realease])

select * 
from [dbo].[Top_1000_Highest_Grossing_Movie$]
-------------------------------------------------------------------------------------------------------------------------------------
--Convert 'Duration' column into 'Hours:HH' format
alter table [dbo].[Top_1000_Highest_Grossing_Movie$]
alter column [Duration] varchar(225)

UPDATE [dbo].[Top_1000_Highest_Grossing_Movie$]
SET [Duration] = CONVERT(varchar,[Duration] , 108); --https://learn.microsoft.com/en-us/sql/t-sql/functions/cast-and-convert-transact-sql?view=sql-server-ver16 (date format)
-------------------------------------------------------------------------------------------------------------------------------------
--check for the presence of special characters in a column
SELECT [Gross]
FROM [dbo].[Top_1000_Highest_Grossing_Movie$]
WHERE PATINDEX('%[^a-zA-Z0-9]%',[Gross] ) > 0;

--remove special char
update [dbo].[Top_1000_Highest_Grossing_Movie$]
set Gross=REPLACE([Gross],'$','')
update [dbo].[Top_1000_Highest_Grossing_Movie$]
set Gross=REPLACE([Gross],'M','')
update [dbo].[Top_1000_Highest_Grossing_Movie$]
set Gross=0
where Gross like '%*%'
--------------------------------------------------------------------------------------
--chnage the name of column to refer that Gross is in Milions
EXEC sp_rename '[dbo].[Top_1000_Highest_Grossing_Movie$].[Gross]' , 'Gross_M', 'column' ;
--------------------------------------------------------------------------------------
update [dbo].[Top_1000_Highest_Grossing_Movie$]
set [Worldwide LT Gross]=REPLACE([Worldwide LT Gross],'$','')

update [dbo].[Top_1000_Highest_Grossing_Movie$]
set [Worldwide LT Gross]=0
where [Worldwide LT Gross] like '%*%'

alter table [dbo].[Top_1000_Highest_Grossing_Movie$]
alter column [Gross_M] int

alter table [dbo].[Top_1000_Highest_Grossing_Movie$]
alter column [Worldwide LT Gross] bigint

select [Worldwide LT Gross]
from Top_1000_Highest_Grossing_Movie$
-------------------------------------------------------------------------------------------------------------------------------------
-- Convert votes into categorical data format
select distinct(len([Votes]))
from Top_1000_Highest_Grossing_Movie$

alter table [dbo].[Top_1000_Highest_Grossing_Movie$]
add Vote_Catg text

update Top_1000_Highest_Grossing_Movie$
set [Vote_Catg]= (case
   when len([Votes])>=7 then 'High'
   when len(Votes)=6 then 'Adequate'
   when len(votes)=5 then 'Satisfactory'
   when len(votes)=4 then 'Low'
   when len(votes)<4 then 'Unconsiderable'
   end);
-------------------------------------------------------------------------------------------------------------------------------------
--Labelling the film based on 'genre' column

select distinct(genre)
from Top_1000_Highest_Grossing_Movie$  --action,adventure,comedy,crime,drama,mystery,western,sci-fi,fantasy,biography,,war,thriller,romance,music,horror,family,sport,history

Alter Table [dbo].[Top_1000_Highest_Grossing_Movie$]
add Actionn int
, Comedy int
,Drama int
,Romance int
,Horror int
,Sci_fi int
,Family int

update [dbo].[Top_1000_Highest_Grossing_Movie$]
set Actionn=1
where Genre like '%action%'

update [dbo].[Top_1000_Highest_Grossing_Movie$]
set Horror=1
where Genre like '%Horror%'

update [dbo].[Top_1000_Highest_Grossing_Movie$]
set Comedy=1
where Genre like '%Comedy%'

update [dbo].[Top_1000_Highest_Grossing_Movie$]
set Family=1
where Genre like '%Family%'

update [dbo].[Top_1000_Highest_Grossing_Movie$]
set Sci_fi=1
where Genre like '%sci%'

update [dbo].[Top_1000_Highest_Grossing_Movie$]
set Romance=1
where Genre like '%romance%'

update [dbo].[Top_1000_Highest_Grossing_Movie$]
set Drama=1
where Genre like '%drama%'
---------------------------------------------
update [dbo].[Top_1000_Highest_Grossing_Movie$]
set Actionn=0
where Actionn is null

update [dbo].[Top_1000_Highest_Grossing_Movie$]
set Horror=0
where Horror is null

update [dbo].[Top_1000_Highest_Grossing_Movie$]
set Comedy=0
where Comedy is null

update [dbo].[Top_1000_Highest_Grossing_Movie$]
set Family=0
where Family is null

update [dbo].[Top_1000_Highest_Grossing_Movie$]
set Sci_fi=0
where Sci_fi is null

update [dbo].[Top_1000_Highest_Grossing_Movie$]
set Romance=0
where Romance is null

update [dbo].[Top_1000_Highest_Grossing_Movie$]
set Drama=0
where Drama is null
-------------------------------------------------------------------------------------------------------------------------------------
--Drop useless columns
Alter table [dbo].[Top_1000_Highest_Grossing_Movie$]
drop column [Movie Title]
, [Year of Realease]
, Genre
, Votes
, Logline

select *
from [dbo].[Top_1000_Highest_Grossing_Movie$]