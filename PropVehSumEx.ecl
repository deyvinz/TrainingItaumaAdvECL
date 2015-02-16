IMPORT $;

SetPassengerCarCodes := ['ALPASS', 'CTPASS','DEPASS', 'FLAU', 'IDCAR', 'MDPASS', 'MN9',
												'MOP', 'MS1', 'MTPC', 'NEP', 'OHPC', 'OKPASS', 'ORPASS', 'SCPASS',
												'WIAUTO'];
												
CatCodes := $.DN.Vehicle.Orig_state + $.DN.Vehicle.Vehicle_type;
CarCount := COUNT($.DN.Vehicle(CatCodes IN SetPassengerCarCodes, $.IsValidAmount(Vina_price), Vina_price > 1500, $.IsValidYear(Year_make), $.YearsOld(Year_make)<=3));
PropCount := COUNT($.DN.Property(Apt = '', 
									$.IsValidAmount(Total_value), 
									Total_value > 150000, 
									$.IsValidYear(year_built), 
									$.YearsOld(Year_built) <= 10));
EXPORT PropVehSumEx := $.Limit_Value(CarCount + PropCount, 5);

