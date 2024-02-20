-- Cleaning Data in SQL Queries

SELECT *
From [Portfolio Project].dbo.NashvilleHousing

------------------------------------------------------

-- Standardize date format

Select SaleDate, CONVERT(Date,Saledate)
from [Portfolio Project].dbo.NashvilleHousing

Update [Portfolio Project].dbo.NashvilleHousing
SET Saledate = CONVERT(Date, Saledate)

ALTER TABLE [Portfolio Project].dbo.NashvilleHousing
ADD SaleDateConverted Date;
Update [Portfolio Project].dbo.NashvilleHousing
SET SaleDateConverted = CONVERT(Date, Saledate)

------------------------------------------------------

-- Populate Property address data using ISNULL and selfjoining tables

Select *
from [Portfolio Project].dbo.NashvilleHousing
Where PropertyAddress is null
order by ParcelID

Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, iSNULL(a.PropertyAddress, b.PropertyAddress)
from [Portfolio Project].dbo.NashvilleHousing as a
JOIN [Portfolio Project].dbo.NashvilleHousing as b
	on a.ParcelID = b.ParcelID
	and a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is null


update a
SET PropertyAddress = iSNULL(a.PropertyAddress, b.PropertyAddress)
from [Portfolio Project].dbo.NashvilleHousing as a
JOIN [Portfolio Project].dbo.NashvilleHousing as b
	on a.ParcelID = b.ParcelID
	and a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is null

------------------------------------------------------

--Breaking out Address into individual columns

Select PropertyAddress
from [Portfolio Project].dbo.NashvilleHousing
--Where PropertyAddress is null
--order by ParcelID

Select
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1) as Address
, SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1, LEN(PropertyAddress)) as Address
from [Portfolio Project].dbo.NashvilleHousing

ALTER TABLE [Portfolio Project].dbo.NashvilleHousing
Add PropertySplitAddress Nvarchar(255);

Update [Portfolio Project].dbo.NashvilleHousing
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1)

ALTER TABLE [Portfolio Project].dbo.NashvilleHousing
Add PropertySplitCity Nvarchar(255);

Update [Portfolio Project].dbo.NashvilleHousing
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1, LEN(PropertyAddress))

select * 
from [Portfolio Project].dbo.NashvilleHousing


select OwnerAddress
from [Portfolio Project].dbo.NashvilleHousing

Select
PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3)
, PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2)
, PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1)
from [Portfolio Project].dbo.NashvilleHousing

ALTER TABLE [Portfolio Project].dbo.NashvilleHousing
Add OwnerSplitAddress Nvarchar(255);

Update [Portfolio Project].dbo.NashvilleHousing
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3)

ALTER TABLE [Portfolio Project].dbo.NashvilleHousing
Add OwnerSplitCity Nvarchar(255);

Update [Portfolio Project].dbo.NashvilleHousing
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2)

ALTER TABLE [Portfolio Project].dbo.NashvilleHousing
Add OwnerSplitState Nvarchar(255);

Update [Portfolio Project].dbo.NashvilleHousing
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1)

------------------------------------------------------

-- Replacing equal but different formatted values

select Distinct(SoldAsVacant), COUNT(SoldAsVacant)
from [Portfolio Project].dbo.NashvilleHousing
Group by SoldAsVacant
order by 2

select SoldAsVacant
	, CASE when SoldAsVacant = 'Y' then 'Yes'
		   when SoldAsVacant = 'N' then 'No'
		   ELSE SoldAsVacant
		   end
from [Portfolio Project].dbo.NashvilleHousing

Update [Portfolio Project].dbo.NashvilleHousing
SET SoldAsVacant = CASE when SoldAsVacant = 'Y' then 'Yes'
		   when SoldAsVacant = 'N' then 'No'
		   ELSE SoldAsVacant
		   end

------------------------------------------------------

-- Remove Duplicates using CTE

With CTE_NashVilleTableDuplicates as
(
Select *,
	ROW_NUMBER() OVER (
	Partition by ParcelID, 
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER by UniqueID) row_num
from [Portfolio Project].dbo.NashvilleHousing
--order by ParcelID
)

select *
from CTE_NashVilleTableDuplicates
where row_num > 1
order by PropertyAddress


------------------------------------------------------

-- Delete Unused Columns

select * 
from [Portfolio Project].dbo.NashvilleHousing

Alter Table [Portfolio Project].dbo.NashvilleHousing
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress, SaleDate