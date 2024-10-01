USE [TheBigfootIsReal]
GO

/****** Object:  View [dbo].[vwSightings2]    Script Date: 12/11/2022 1:55:42 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
-- number of sightings and follow up reports per yer
Create View [dbo].[vwSightings5] as Select Count(ID) NumberOfSightings, dateYear as Year, count(Case when Follow_up = 'yes' then 1 else Null end) FUreportexists, count(Case when Follow_up = 'no' then 1 else NULL end) as numberOfNotReports from dbo.BIGFOOT_Data group by dateYear;
GO
-- most popular season for Bigfoot
Create View dbo.vwBigfootSeasons as Select Count(ID) NumberOfSightings, Season from dbo.BIGFOOT_Data group by Season;
go
-- most popular states for Big Foot locations
Create View dbo.BigfootLocations as select Count(ID) NumberOfSightings, State from dbo.BIGFOOT_Data group by State;
go
-- Most recent sightings of Big Foot in each state
Select Max(dateYear) as lastSightedYear, State from dbo.BIGFOOT_Data group by State order by lastSightedYear desc;

alter table dbo.BIGFOOT_Data add SeasonNum int;

update dbo.BIGFOOT_Data Set SeasonNum = 1 where Season = 'Winter';
update dbo.BIGFOOT_Data set SeasonNum = 2 where Season = 'Spring';
update dbo.BIGFOOT_Data set SeasonNum = 3 where Season = 'Summer';
update dbo.BIGFOOT_Data set SeasonNum = 4 where Season = 'Fall';
go

Create View MostRecentBigfoot as Select Max(dateYear) as lastSightedYear, Season, SeasonNum, 
concat(Season,'-', Max(dateYear)) labelDT, State from dbo.BIGFOOT_Data group by State, Season, SeasonNum;
go

Create View dbo.vwBigfootVScellPhones as Select NumberOfSightings, dbo.vwSightings5.Year as Year, SMARTPHONES_per10million as SMRTPhoneSales FROM dbo.vwSightings5 inner join dbo.Smartphone_Sales_Cameras on dbo.Smartphone_Sales_Cameras.YEAR = dbo.vwSightings5.Year;
GO

Create View dbo.BigfootOlympian as Select * from dbo.BIGFOOT_Data where dateYear = 1904 and State = 'Missouri' or dateYear = 1932 and State = 'California' or dateYear = 1932 and State = 'New York' or dateYear = 1960 and State = 'California' or dateYear = 1980 and State = 'New York' and Season = 'Winter' or dateYear = 1984 and State = 'Georgia' and Season = 'Summer' or dateYear = 1996 and State = 'Utah' and Season = 'Summer' or dateYear = 2002 and State = 'California' and Season = 'Winter';
go 

Create View dbo.BigfootOlympianConfirmed as Select * from dbo.BIGFOOT_Data where dateYear = 1904 and State = 'Missouri' or dateYear = 1932 and State = 'California' or dateYear = 1932 and State = 'New York' or dateYear = 1960 and State = 'California' or dateYear = 1980 and State = 'New York' or dateYear = 1984 and State = 'Georgia' or dateYear = 1996 and State = 'Utah'  or dateYear = 2002 and State = 'California' 
-- most visited place per yer. max number of sightings in which place per year.
go

Delete from BIGFOOT_Data where Season = ''


--Delete from dbo.BIGFOOT_Data where Season = '' and Follow_up = 'no' ;









