trigger BatchApexErrorTrigger on BatchApexErrorEvent (after insert) {

// For each event record, capture the following fields and save them to the corresponding fields in a new BatchLeadConvertErrors__c record.
// 		○ AsyncApexJobId: AsyncApexJobId__c
// 		○ JobScope: Records__c
// 		○ StackTrace: StackTrace__c
    List<BatchLeadConvertErrors__c> errors = new List<BatchLeadConvertErrors__c>();

    for (BatchApexErrorEvent e : trigger.new) {
        errors.add(new BatchLeadConvertErrors__c(
            AsyncApexJobId__c = e.AsyncApexJobId,
            Records__c  = e.JobScope,
            StackTrace__c  = e.StackTrace
        ));
    }

    // To make the trigger bulk safe, use a single DML statement to insert a list of new records at the end.
    insert errors;

}