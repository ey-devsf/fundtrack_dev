public with sharing class MonthlyInputFormQueryService {
    public List<MonthlyInputRow__c> getInputRows(Date month) {
        month = month.toStartOfMonth();
        return [
            SELECT Id, Name, Month__c, FormFieldKey__c, Amount__c 
            FROM MonthlyInputRow__c 
            WHERE Month__c = :month
            ORDER BY Id
        ];
    }
}