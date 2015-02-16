IMPORT $;

IsValidBathCount(UNSIGNED2 TotalBaths) := FUNCTION
	IsValidProperty := $.DN.Property.Full_baths + ROUND($.DN.Property.Half_baths/2) >= TotalBaths;
	IsValidTaxdata := EXISTS($.DN.Taxdata(Full_baths + (ROUND(Half_baths/2)) >= TotalBaths));
	RETURN IsValidProperty OR IsValidTaxdata;
END;

EXPORT PropBath_3 := COUNT($.DN.Property(isValidBathCount(3)));