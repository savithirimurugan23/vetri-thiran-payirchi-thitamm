trigger EnrollmentTrigger on Enrollment__c (before insert, before update) {
    for(Enrollment__c enroll : Trigger.new){
        if(enroll.Course__c != null){
            // Course details edukkrom pa
            Course__c courseData = [SELECT Fees__c, Seats_Available__c FROM Course__c WHERE Id = :enroll.Course__c LIMIT 1];
            
            // Auto Fees fill pannum pa
            if(courseData.Fees__c != null){
                enroll.Fees_Paid__c = courseData.Fees__c;
            }
            
            // Date & Status auto set
            enroll.Enrollment_Date__c = System.today();
            enroll.Status__c = 'Enrolled';
            
            // Seat full check
            if(courseData.Seats_Available__c <= 0){
                enroll.addError('Pa seat full aagiduchu pa! Vera course try pannu pa!');
            }
        }
    }
}
