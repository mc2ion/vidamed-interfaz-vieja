package domain;

import java.io.Serializable;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

public class PermissionsList implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
	/* Permisos para ingresar a los modulos */
	public static long estimation          = 1;
	public static long emergency     	   = 2;
	public static long admission     	   = 3;
	public static long hospitalization     = 4;
    public static long users     		   = 5;
    public static long protocols     	   = 6;
    public static long rayX     		   = 7;
    public static long pharmacyAdmin       = 8;
    public static long pharmacyPatients    = 9;
    public static long billsH     		   = 10;
    public static long billsRP    		   = 11;
    public static long billsGN    		   = 12;
    public static long billsPP     		   = 13;
    public static long units     		   = 14;
    public static long specialists     	   = 15;
    public static long paymentResponsible  = 16;
    public static long cashBoxes     	   = 17;
    public static long pendingAccounts     = 18;
    public static long bloodBank     	   = 19;
    public static long eco     		       = 20;
    public static long lab     		       = 21;
    public static long interc     		   = 22;
    public static long reports     		   = 23;
    public static long admissionDischarge  = 24;
    public static long creditNotes     	   = 25;
    public static long creditNotesReview   = 26;
    public static long invoices            = 27;
    public static long discounts     	   = 28;
    public static long pharmacyDischarges  = 29;
    public static long pendingPayments     = 30;
    public static long medicalTAdmin       = 31;
    public static long medicalTPacient     = 32;
    public static long patient			   = 33;
    public static long additionalServices  = 34;
    public static long admissionCashBoxes  = 35;
    public static long pharmacyAdminRestricted = 36;
    
   	
	/*public static long createEstimation  = 2;
	public static long seeEstimation 	 = 3;
	public static long editEstimation    = 4;
	public static long printEstimation	 = 5;
	public static long updateEstimation  = 6;
	public static long deleteEstimation  = 7;
	public static long discountEstimation  = 7;
	
	 
	public static long listEmergency    	= 8;
	public static long seeEmergency     	= 9;
	public static long editEmergency 		= 10;
	public static long dischargeEmergency  	= 11;
	public static long hospEmergency	  	= 12;
	public static long deleteEmergency  	= 13;
	public static long cutEmergency			= 14;
	
	
	public static long listAdmission    = 15;
	public static long createAdmission  = 16;
	public static long seeAdmission     = 17;
	public static long printAdmission   = 18;
	public static long editAdmission	= 19;
	public static long updateAdmission  = 20;
	public static long deleteAdmission  = 21;
	
	public static long listProtocol    = 1;
	public static long createProtocol  = 2;
	public static long seeProtocol 	   = 3;
	public static long printProtocol   = 4;
	public static long editProtocol	   = 5;
	public static long updateProtocol  = 6;
	public static long deleteProtocol  = 7;
	
	
	public static long listHospitalization    = 15;
	
	
	public static long listUser       = 29;
	public static long seeUser        = 30;
	public static long editUser       = 31;
	public static long printUser      = 32;
	public static long createUser     = 29;
	public static long changePassword = 21;
	public static long deleteUser	  = 21;
	
	
	public static long listUnit       = 29;
	public static long createUnit     = 30;
	public static long editUnit       = 31;
	public static long deleteUnit	  = 21;
	
	public static long listCashB       = 29;
	public static long seeCashB        = 30;
	public static long createCashB     = 30;
	public static long printCashB      = 31;
	public static long closeCashB	   = 21;
	public static long openCashB       = 29;
	public static long editCashB       = 30;
	public static long deleteCashB     = 31;
	public static long payCashB	       = 21;
	
	
	public static long listRayX    	      = 15;
	
	public static long listPharmacyAdmin  = 15;
	
	public static long listSpecialists  = 15;
	public static long createSpecialist  = 15;
	public static long editSpecialist  = 15;
	public static long deleteSpecialist  = 15;
	
	public static long listPaymentR  = 15;
	public static long createPaymentR  = 15;
	public static long editPaymentR  = 15;
	public static long deletePaymentR  = 15;
	
	
	*/
	
	
	
	public static boolean hasPermission(HttpServletRequest request, long value){
		HttpSession session = request.getSession();
		@SuppressWarnings("unchecked")
		ArrayList<UserPermission> userPermissions = (ArrayList<UserPermission>) session.getAttribute("userPermissions");
		if (userPermissions != null){
			for (int  i = 0; i < userPermissions.size(); i++){
				if (userPermissions.get(i).getPermissionID() == value)
					return true;
			}
		}
		return false;
	}
	
	
}
