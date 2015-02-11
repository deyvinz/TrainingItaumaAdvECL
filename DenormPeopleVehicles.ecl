IMPORT $;
CombPeopleVehicles := RECORD
	$.People.Layout;
	UNSIGNED1 ChildVCount;
	DATASET($.Vehicle.Layout) VehicleRecs{MAXCOUNT(20)};
END;
CombPeopleVehicles ParentMove($.People.Layout L) := TRANSFORM
	SELF.ChildVCount := 0;
	SELF.VehicleRecs := [];
	SELF := L;
END;

ParentOnly := PROJECT($.People.File, ParentMove(LEFT));

CombPeopleVehicles ChildMove(CombPeopleVehicles L, $.Vehicle.Layout R, INTEGER C) := TRANSFORM
	SELF.ChildVCount := C;
	SELF.VehicleRecs := L.VehicleRecs + R;
	SELF := L;
END;

EXPORT DenormPeopleVehicles := DENORMALIZE(ParentOnly, $.Vehicle.File, LEFT.id = RIGHT.personid, ChildMove(LEFT,RIGHT,COUNTER)) : PERSIST('~ONLINE::II::PERSIST::PeopleVehicles');
