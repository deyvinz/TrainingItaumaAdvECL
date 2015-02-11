EXPORT Z2JD(STRING8 Zdate) := FUNCTION
 // adapted from an algorithm described here:
 // http://quasar.as.utexas.edu/BillInfo/JulianDatesG.html
 A(Y)    := TRUNCATE(Y/100);
 B(Aval) := TRUNCATE(Aval/4);
 C(Y)    := 2-A(Y)+B(A(Y));
 E(Y)    := TRUNCATE(365.25 * (Y+4716));
 F(M)    := TRUNCATE(30.6001 * (M+1));
 Yval    := IF((INTEGER1)(Zdate[5..6]) < 3,
               (INTEGER2)(Zdate[1..4])-1,
							 (INTEGER2)(Zdate[1..4]));

 Mval    := IF((INTEGER1)(Zdate[5..6]) < 3,
               (INTEGER1)(Zdate[5..6])+12,
	 						 (INTEGER1)(Zdate[5..6]));
 Dval    := (INTEGER1)(Zdate[7..8]);
 RETURN IF(Zdate='',0,TRUNCATE(C(Yval) + Dval + E(Yval) + F(Mval)- 1524.5));
END;							 