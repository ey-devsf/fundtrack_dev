public with sharing class MonthlyInputFormCtrl {

    @AuraEnabled(cacheable=true)
    public static String init() {
        MonthlyInputFormQueryService queryService = new MonthlyInputFormQueryService();
        List<MonthlyInputFormConfig.FormField> formFields = MonthlyInputFormConfig.getFormFieldDifinitions();
        List<MonthlyInputRow__c> inputRows = queryService.getInputRows(Date.today());

        Map<String, Decimal> inputMap = new Map<String, Decimal>();
        for (MonthlyInputRow__c row : inputRows) {
            if (row.FormFieldKey__c != null && row.Amount__c != null) {
                inputMap.put(row.FormFieldKey__c, row.Amount__c);
            }
        }

        for (MonthlyInputFormConfig.FormField field : formFields) {
            if (inputMap.containsKey(field.key)) {
                field.value = inputMap.get(field.key);
            }
        }
        
        return formFields != null ? JSON.serialize(formFields) : '[]';
    }

    @AuraEnabled
    public static void saveInputRows(Map<String, Integer> inputMap, String targetMonth) {
        MonthlyInputFormQueryService queryService = new MonthlyInputFormQueryService();
        Map<String, MonthlyInputRow__c> savedInputRows = convertToInputRowMap(queryService.getInputRows(Date.today()));
        List<MonthlyInputRow__c> upsertInputRows = new List<MonthlyInputRow__c>();

        for (String key : inputMap.keySet()) {
            Integer value = inputMap.get(key);
            MonthlyInputRow__c row = savedInputRows.get(key);
            if (row == null) {
                row = new MonthlyInputRow__c();
                row.FormFieldKey__c = key;
            }
            row.Amount__c = value == null ? 0 : Decimal.valueOf(value);
            row.Month__c = Date.valueOf(targetMonth);
            upsertInputRows.add(row);
        }

        if (!upsertInputRows.isEmpty()) {
            upsert upsertInputRows;
        }
    }

    private static Map<String, MonthlyInputRow__c> convertToInputRowMap(List<MonthlyInputRow__c> inputRows) {
        Map<String, MonthlyInputRow__c> inputRowMap = new Map<String, MonthlyInputRow__c>();
        for (MonthlyInputRow__c row : inputRows) {
            if (row.FormFieldKey__c != null) {
                inputRowMap.put(row.FormFieldKey__c, row);
            }
        }
        return inputRowMap;
    }
}
