use Keys
go

---Task1 

--- a. Display a list of all property names and their property id¡¯s for Owner Id: 1426. 

select p.Name as PropertyName, p.Id as PropertyID, 
from dbo.Property p
inner join dbo.OwnerProperty op
on p.Id = op.PropertyId
where op.OwnerId = 1426

--- b. Display the current home value for each property in question a). 

select p.Name as PropertyName, p.Id as PropertyID, pv.Value as HomeValue, op.OwnerId
from dbo.Property p
inner join dbo.OwnerProperty op
on p.Id = op.PropertyId
inner join dbo.PropertyHomeValue pv
on pv.PropertyId = op.PropertyId
where op.OwnerId = 1426 and pv.IsActive = 1

--- c i. Using rental payment amount, rental payment frequency, tenant start date and tenant end date to write a query that returns the sum of all payments from start date to end date. 

select p.Name as PropertyName, p.Id as PropertyID, pv.Value as HomeValue, tp.PaymentAmount, tp.PaymentFrequencyId, tp.StartDate, tp.EndDate,op.OwnerId, 
case
	when tp.PaymentFrequencyId = 1
	then 
			(datediff(week, StartDate, EndDate)) * PaymentAmount
	when tp.PaymentFrequencyId = 2
	then			
			(DATEDIFF(week, StartDate, EndDate))/2 * PaymentAmount
	when tp.PaymentFrequencyId = 3
	then			
			(DATEDIFF(month, StartDate, EndDate)) * PaymentAmount
END
AS 'Sum'

from dbo.Property p
inner join dbo.OwnerProperty op
on p.Id = op.PropertyId
inner join dbo.PropertyHomeValue pv
on pv.PropertyId = op.PropertyId
inner join dbo.TenantProperty tp
on tp.PropertyId = op.PropertyId
where op.OwnerId = 1426 and pv.IsActive = 1

--- c.i Display the yield. 

select p.Name as PropertyName, p.Id as PropertyID, f.Yield, op.OwnerId
from dbo.Property p
inner join dbo.OwnerProperty op
on p.Id = op.PropertyId
inner join dbo.PropertyHomeValue pv
on pv.PropertyId = op.PropertyId
inner join dbo.PropertyFinance f
on f.PropertyId = pv.PropertyId
where op.OwnerId = 1426 and pv.IsActive = 1

--- d. Display all the jobs available

select *
from dbo.Job j
Where j.JobStatusId = 1




---Display all property names, current tenants first and last names and rental payments per week/ fortnight/month for the properties in question a). 

select p.Name as PropertyName, p.Id as PropertyID, tp.PaymentAmount, op.OwnerId, ps.FirstName, ps.LastName, tp.IsActive, tp.*, pv.*, op.*,
Case
	When tp.PaymentFrequencyId = 1 then 'Weekly'

	When tp.PaymentFrequencyId = 2 then 'Fortnightly'

	When tp.PaymentFrequencyId = 3 then 'Monthly'
End
As 'PaymentFrequency'

from dbo.Property p
inner join dbo.OwnerProperty op
on p.Id = op.PropertyId
inner join dbo.PropertyHomeValue pv
on pv.PropertyId = op.PropertyId
inner join dbo.TenantProperty tp
on tp.PropertyId = op.PropertyId
inner join dbo.Person ps
on ps.Id = tp.TenantId
where op.OwnerId = 1426 and pv.IsActive = 1 and tp.IsActive = 1




