IMPORT $;
CombPropTaxRec := RECORD
	$.Property.Layout;
	UNSIGNED1 ChildCount;
	DATASET($.Taxdata.Layout) TaxRecs{MAXCOUNT(20)};
END;

CombPeopleVeh := RECORD //Input to Project transform
	$.People.Layout;
	UNSIGNED1 ChildvCount;
	DATASET($.Vehicle.Layout) VehicleRecs{MAXCOUNT(20)};
END;

CombPeopleAll := RECORD //output to project transform
	$.People.Layout;
	UNSIGNED1 ChildvCount;
	UNSIGNED1 ChildCount;
	DATASET($.Vehicle.Layout) VehicleRecs{MAXCOUNT(20)};
	DATASET(CombPropTaxRec) PropRecs{MAXCOUNT(20)};
END;

CombPeopleAll ParentMove(CombPeopleVeh L) := TRANSFORM
	SELF.ChildCount := 0;
	SELF.PropRecs := [];
	SELF := L;
END;

ParentOnly := PROJECT($.DenormPeopleVehicles, ParentMove(LEFT));

CombPeopleAll ChildMove(CombPeopleAll L, CombPropTaxRec R, INTEGER C) := TRANSFORM
	SELF.ChildCount := C;
	SELF.PropRecs := L.PropRecs + R;
	SELF := L;
END;

EXPORT Denorm_PeopleAll := DENORMALIZE(ParentOnly, $.DenormProp, LEFT.id = RIGHT.propertyid, ChildMove(LEFT,RIGHT,COUNTER));
