IMPORT $;

EXPORT DN := MODULE
	CombindedPropRec := RECORD
		$.Property.Layout;
		UNSIGNED1 ChildCount;
		DATASET($.Taxdata.Layout) TaxRecs{MAXCOUNT(20)};
	END;
	PeopleRec := RECORD
		UNSIGNED1 childvcount;
		UNSIGNED1 childCount;
		DATASET($.Vehicle.Layout) VehicleRecs{MAXCOUNT(20)};
		DATASET(CombindedPropRec) PropRecs{MAXCOUNT(20)};
	END;
	EXPORT People := DATASET('~ONLINE::II::OUT::PeopleAll', PeopleRec, THOR);
	EXPORT Vehicle := People.VehicleRecs;
	EXPORT Property := People.PropRecs;
	EXPORT Taxdata := People.PropRecs.TaxRecs;
END;