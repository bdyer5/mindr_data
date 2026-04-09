USE [mindr-live]
GO

/****** Object:  UserDefinedFunction [dbo].[dtime]    Script Date: 4/6/2026 4:51:06 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE FUNCTION [dbo].[dtime](@dtdate datetime,@ihh char(2),@imin char(2), @iampm char(1))
RETURNS datetime
AS
BEGIN
--This function finds the date and time of a child's death
   DECLARE @dtime datetime,@month varchar(2),@year varchar(4),@ampm varchar(2), @dstring char(20)
   if @iampm='1'  set @ampm='am'
   if @iampm='2'  set @ampm='pm'

   select @dtime = null --return null if we don't have a valid date/time of birth
   if @ihh in ('$$','99','00','') or (@ihh is null) set @ihh='00'--if we don't have year of death use empty
   if @imin in ('$$','99','00','') or (@imin is null) set @imin='00'--if we don't have year of death use empty
   if @iampm in ('$','9','0','') or (@iampm is null) set @ampm='am'--if we don't have year of death use empty
	

   set @dstring =  convert(varchar(10),@dtdate,110)+ ' ' + @ihh + ':'+ @imin +@ampm

   if isdate(@dstring)=1
   	set @dtime = cast(@dstring as datetime)
    

   return( @dtime)
END
GO


