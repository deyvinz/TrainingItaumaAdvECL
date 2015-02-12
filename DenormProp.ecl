IMPORT $;
CombinedRec := RECORD
	$.Property.Layout;
	UNSIGNED1 ChildCount;
	DATASET($.Taxdata.Layout) TaxRecs{MAXCOUNT(20)};
END;
CombinedRec ParentMove($.Property.Layout L) := TRANSFORM
	SELF.ChildCount := 0;
	SELF.TaxRecs := [];
	SELF := L;
END;

ParentOnly := PROJECT($.Property.File, ParentMove(LEFT));

CombinedRec ChildMove(CombinedRec L, $.Taxdata.Layout R, INTEGER C) := TRANSFORM
	SELF.ChildCount := C;
	SELF.TaxRecs := L.TaxRecs + R;
	SELF := L;
END;

EXPORT DenormProp := DENORMALIZE(ParentOnly, $.Taxdata.File, LEFT.propertyid = RIGHT.propertyid, ChildMove(LEFT,RIGHT,COUNTER)) : PERSIST('~ONLINE::II::PERSIST::PropTax');