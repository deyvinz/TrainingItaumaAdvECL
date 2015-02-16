IMPORT $;

EXPORT DN := MODULE
	CombindedPropRec := RECORD
		$.Property.Layout;
		UNSIGNED1 ChildCount;
		DATASET($.Taxdata.Layout) TaxRecs{MAXCOUNT(20)};
	END;

	PeopleRec := RECORD
		$.People.Layout;
		UNSIGNED1 childvcount;
		UNSIGNED1 ChildCount;
		DATASET($.Vehicle.Layout) VehicleRecs{MAXCOUNT(20)};
		DATASET(CombindedPropRec) PropRecs{MAXCOUNT(20)};
	END;
	EXPORT People := DATASET('~ONLINE::II::OUT::PeopleAll', PeopleRec, THOR);
	EXPORT Vehicle := People.Vehiclerecs;
	EXPORT Property := People.PropRecs;
	EXPORT Taxdata := People.PropRecs.TaxRecs;
END;