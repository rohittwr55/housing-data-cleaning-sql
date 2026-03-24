/*
Retrive Data
*/
Use HousingAnalysis;
select 
	[UniqueID ],
	ParcelID,
	LandUse,
	PropertyAddress,
	SaleDate,
	SalePrice,
	LegalReference,
	SoldAsVacant,
	OwnerAddress,
	Acreage,
	TaxDistrict,
	LandValue,
	BuildingValue,
	TotalValue,
	YearBuilt,
	Bedrooms,
	FullBath,
	HalfBath
from [dbo].[HouseData]

----------------------------------------------------------
/*
	Standardize Date Format
*/
--Selecting the Column name
select 
	SaleDate
from Dbo.HouseData

--Adding New Column
ALTER TABLE HouseData
ADD SalesDate date;

--Updating the New Column 
Update HouseData
set SalesDate = CONVERT(date,SaleDate)

--Droping the Old column
ALTER TABLE HouseData 
DROP COLUMN SaleDate;

--Now Again running the whole table
select * from Dbo.HouseData

----------------------------------------------------------
/*
	Populate Property Address data
*/
----Selecting the Property Address column
select PropertyAddress from HousingAnalysis.dbo.HouseData

---Checking how many null values are 
select PropertyAddress from HousingAnalysis.dbo.HouseData
where PropertyAddress is null

---We found that some column have same Address have same Parcel ID 
select ParcelID, PropertyAddress from HousingAnalysis.dbo.HouseData
where ParcelID = '026 06 0A 038.00'

-- We will use Join to get if We have same more than one ParcelID cell 
--and one property addess cell is null and another is not ha
select 
	a.ParcelID,
	a.PropertyAddress,
	b.ParcelID,
	b.PropertyAddress,
	ISNULL(a.PropertyAddress,b.PropertyAddress) as NewAddress
from HousingAnalysis.dbo.HouseData a
join HousingAnalysis.dbo.HouseData b
on a.ParcelID = b.ParcelID
and a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is null

--Now we will update the Property Adress
update a
set PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)
from HousingAnalysis.dbo.HouseData a
join HousingAnalysis.dbo.HouseData b
on a.ParcelID = b.ParcelID
and a.[UniqueID ] <> b.[UniqueID ]

--Checking if updated Properly or not
select * from HousingAnalysis.dbo.HouseData

----------------------Breaking out PropertyAddress column into Address and city
--Select Property Address
select PropertyAddress from HousingAnalysis.dbo.HouseData

--Now we will seprate address and city using subrting based on (,)

select 
	SUBSTRING(PropertyAddress,1,CHARINDEX(',',PropertyAddress)-1) as Address,
	SUBSTRING(PropertyAddress,CHARINDEX(',',PropertyAddress) +1, LEN(PropertyAddress)) as City
from HousingAnalysis.dbo.HouseData

--Adding New Column PropertySpilitAddress
ALTER TABLE HouseData
ADD PropertySpilitAddress varchar(255);

--Updating the New Column PropertySpilitAddress
Update HouseData
set PropertySpilitAddress = SUBSTRING(PropertyAddress,1,CHARINDEX(',',PropertyAddress)-1)

--Adding New Column PropertySpilitCity
ALTER TABLE HouseData
ADD PropertySpilitCity varchar(255);

--Updating the New Column PropertySpilitCity 
Update HouseData
set PropertySpilitCity = SUBSTRING(PropertyAddress,CHARINDEX(',',PropertyAddress) +1, LEN(PropertyAddress))

--Now checking the updated column
select 
	*
from HousingAnalysis.dbo.HouseData

----------------------Breaking out OwnerAddress column into Address,city and state
select 
	*
from HousingAnalysis.dbo.HouseData

---------------We will seprate using parse name
select 
PARSENAME(REPLACE(OwnerAddress,',','.'),3),
PARSENAME(REPLACE(OwnerAddress,',','.'),2),
PARSENAME(REPLACE(OwnerAddress,',','.'),1)
from HousingAnalysis.dbo.HouseData

----We will use Alter and update to update the data

--Adding New Column OwnerSpilitAddress
ALTER TABLE HouseData
ADD OwnerSpilitAddress varchar(255);

--Updating the New Column OwnerSpilitAddress
Update HouseData
set OwnerSpilitAddress = PARSENAME(REPLACE(OwnerAddress,',','.'),3)

--Adding New Column OwnerSpilitCity
ALTER TABLE HouseData
ADD OwnerSpilitCity varchar(255);

--Updating the New Column OwnerSpilitCity
Update HouseData
set OwnerSpilitCity = PARSENAME(REPLACE(OwnerAddress,',','.'),2)

--Adding New Column OwnerSpilitstate
ALTER TABLE HouseData
ADD OwnerSpilitstate varchar(255);

--Updating the New Column OwnerSpilitstate
Update HouseData
set OwnerSpilitstate = PARSENAME(REPLACE(OwnerAddress,',','.'),1)

----Updated Column
select 
	*
from HousingAnalysis.dbo.HouseData

-----------------Change to Y or N For SoldAsVacant

--selecting the column
select 
	SoldAsVacant
from HousingAnalysis.dbo.HouseData

----------------replacing value
select 
	distinct REPLACE(REPLACE(SoldAsVacant,'Yes','Y'),'No','N')
from HousingAnalysis.dbo.HouseData

-------------------Updating table 
update HouseData
set SoldAsVacant = REPLACE(REPLACE(SoldAsVacant,'Yes','Y'),'No','N')
from HousingAnalysis.dbo.HouseData

----Updated Column
select 
	*
from HousingAnalysis.dbo.HouseData

----------------------------------Removing Duplicate like if ParcelID,PropertyAddress, sale Price, Legal reference 
----------------------------------is same then we will remove it

----Row number to get the duplicate value
select 
	*,
	ROW_NUMBER() over (
	PARTITION by ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SalesDate,
				 LegalReference
				 order by UniqueID) as row_num
from HousingAnalysis.dbo.HouseData
order by ParcelID

----Adding under CTE
with ROWNUMCTE as
(
	select 
	*,
	ROW_NUMBER() over (
	PARTITION by ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SalesDate,
				 LegalReference
				 order by UniqueID) as row_num
	from HousingAnalysis.dbo.HouseData
)

select * from ROWNUMCTE
where row_num > 1

--Removing Duplicate

with ROWNUMCTE as
(
	select 
	*,
	ROW_NUMBER() over (
	PARTITION by ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SalesDate,
				 LegalReference
				 order by UniqueID) as row_num
	from HousingAnalysis.dbo.HouseData
)
delete from ROWNUMCTE
where row_num > 1

----Updated Final Data
select 
	*
from HousingAnalysis.dbo.HouseData
