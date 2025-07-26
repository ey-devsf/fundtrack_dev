@isTest
private class MonthlyInputRowTriggerTest {
    @isTest static void testNameGeneration() {
        MonthlyReport__c report = new MonthlyReport__c(Name = '202405');
        insert report;

        MonthlyInputRow__c row = new MonthlyInputRow__c(
            MonthlyReport__c = report.Id,
            Category3__c = 'sample_key',
            Amount__c = 10
        );
        insert row;

        row = [SELECT Name FROM MonthlyInputRow__c WHERE Id = :row.Id];
        System.assertEquals('2405-sample_key', row.Name);

        row.Category3__c = 'changed_key';
        update row;

        row = [SELECT Name FROM MonthlyInputRow__c WHERE Id = :row.Id];
        System.assertEquals('2405-changed_key', row.Name);
    }
}
