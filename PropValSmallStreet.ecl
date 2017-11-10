IMPORT $;
IsSmallStreet := $.DN.Property.StreetType IN ['CT','LN','WAY','CIR','PL','TRL'];
HighValue := IF($.IsValidAmount($.DN.Property.Total_Value) AND
																	$.IsValidAmount($.DN.Property.Assessed_Value),
																	IF($.DN.Property.Total_Value > $.DN.Property.Assessed_Value,
																				$.DN.Property.Total_Value,
																				$.DN.Property.Assessed_Value),
																	IF($.IsValidAmount($.DN.Property.Total_Value),
																				$.DN.Property.Total_Value,
																				$.DN.Property.Assessed_Value));
																				
																				
SmallProperties := $.DN.Property(IsSmallStreet,
																$.IsValidAmount(HighValue));

EXPORT PropValSmallStreet := IF(~EXISTS(SmallProperties),-9,SUM(SmallProperties,HighValue));
