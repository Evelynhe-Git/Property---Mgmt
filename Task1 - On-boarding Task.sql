USE Keys
GO

---TASk1 

--- a. Display a list of all property names and their property id¡¯s for Owner Id: 1426. 

SELECT p.Name AS PropertyName, p.Id AS PropertyID
FROM dbo.Property p
INNER JOIN dbo.OwnerProperty op
ON p.Id = op.PropertyId
WHERE op.OwnerId = 1426

--- b. Display the current home value for each property in question a). 

SELECT p.Name AS PropertyName, p.Id AS PropertyID, pv.Value AS HomeValue, op.OwnerId
FROM dbo.Property p
INNER JOIN dbo.OwnerProperty op
ON p.Id = op.PropertyId
INNER JOIN dbo.PropertyHomeValue pv
ON pv.PropertyId = op.PropertyId
WHERE op.OwnerId = 1426 and pv.IsActive = 1

--- c i. Using rental payment amount, rental payment frequency, tenant start date and tenant end date to write a query that returns the sum of all payments FROM start date to end date. 

SELECT p.Name AS PropertyName, p.Id AS PropertyID, pv.Value AS HomeValue, tp.PaymentAmount, tp.StartDate, tp.EndDate, op.OwnerId, 

CASE

	WHEN tp.PaymentFrequencyId = 1 THEN 'Weekly'

	WHEN tp.PaymentFrequencyId = 2 THEN 'Fortnightly'

	WHEN tp.PaymentFrequencyId = 3 THEN 'Monthly'
End
AS 'PaymentFrequency',

CASE
	WHEN tp.PaymentFrequencyId = 1
	THEN 
			(datediff(week, StartDate, EndDate)) * PaymentAmount
	WHEN tp.PaymentFrequencyId = 2
	THEN			
			(DATEDIFF(week, StartDate, EndDate))/2 * PaymentAmount
	WHEN tp.PaymentFrequencyId = 3
	THEN			
			(DATEDIFF(month, StartDate, EndDate)) * PaymentAmount
END
AS 'Sum'

FROM dbo.Property p
INNER JOIN dbo.OwnerProperty op
ON p.Id = op.PropertyId
INNER JOIN dbo.PropertyHomeValue pv
ON pv.PropertyId = op.PropertyId
INNER JOIN dbo.TenantProperty tp
ON tp.PropertyId = op.PropertyId
WHERE op.OwnerId = 1426 and pv.IsActive = 1

--- c.ii Display the yield. 

SELECT p.Name AS PropertyName, p.Id AS PropertyID, f.Yield, op.OwnerId
FROM dbo.Property p
INNER JOIN dbo.OwnerProperty op
ON p.Id = op.PropertyId
INNER JOIN dbo.PropertyHomeValue pv
ON pv.PropertyId = op.PropertyId
INNER JOIN dbo.PropertyFinance f
ON f.PropertyId = pv.PropertyId
WHERE op.OwnerId = 1426 and pv.IsActive = 1

--- d. Display all the jobs available

SELECT j.Id AS JobId, j.JobDescription
FROM dbo.Job j
WHERE j.JobStatusId = 1




---Display all property names, current tenants first and last names and rental payments per week/ fortnight/month for the properties in question a). 

SELECT p.Name AS PropertyName, p.Id AS PropertyID, tp.PaymentAmount, op.OwnerId, ps.FirstName, ps.LastName, tp.IsActive,
CASE
	WHEN tp.PaymentFrequencyId = 1 THEN 'Weekly'

	WHEN tp.PaymentFrequencyId = 2 THEN 'Fortnightly'

	WHEN tp.PaymentFrequencyId = 3 THEN 'Monthly'
End
AS 'PaymentFrequency'

FROM dbo.Property p
INNER JOIN dbo.OwnerProperty op
ON p.Id = op.PropertyId
INNER JOIN dbo.PropertyHomeValue pv
ON pv.PropertyId = op.PropertyId
INNER JOIN dbo.TenantProperty tp
ON tp.PropertyId = op.PropertyId
INNER JOIN dbo.Person ps
ON ps.Id = tp.TenantId
WHERE op.OwnerId = 1426 and pv.IsActive = 1 and tp.IsActive = 1




