trigger MonthlyInputRowTrigger on MonthlyInputRow__c (before insert, before update) {
    Set<Id> reportIds = new Set<Id>();
    for (MonthlyInputRow__c row : Trigger.new) {
        if (row.MonthlyReport__c != null) {
            reportIds.add(row.MonthlyReport__c);
        }
    }
    Map<Id, MonthlyReport__c> reports = reportIds.isEmpty() ?
        new Map<Id, MonthlyReport__c>() :
        new Map<Id, MonthlyReport__c>([
            SELECT Name FROM MonthlyReport__c WHERE Id IN :reportIds
        ]);

    for (MonthlyInputRow__c row : Trigger.new) {
        if (row.MonthlyReport__c == null || row.Category3__c == null) {
            continue;
        }
        MonthlyReport__c parentReport = reports.get(row.MonthlyReport__c);
        if (parentReport == null) {
            continue;
        }
        String digits = parentReport.Name != null ? parentReport.Name.replaceAll('[^0-9]', '') : '';
        String yymm;
        if (digits.length() >= 4) {
            yymm = digits.substring(digits.length() - 4);
        } else {
            yymm = digits;
        }
        row.Name = yymm + '-' + row.Category3__c;
    }
}
