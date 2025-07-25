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
    // @AuraEnabled
    // public static void saveInputRows(Map<String, Integer> inputMap) {
    //     // if (inputMap == null || inputMap.isEmpty()) {
    //     //     return;
    //     // }

    //     // Map<String, Map<String, Object>> configByKey = new Map<String, Map<String, Object>>();
    //     // List<Object> configs = (List<Object>)JSON.deserializeUntyped(getInputFieldConfigJson());
    //     // for (Object obj : configs) {
    //     //     Map<String, Object> cfg = (Map<String, Object>)obj;
    //     //     configByKey.put((String)cfg.get('key'), cfg);
    //     // }

    //     // List<MonthlyInputRow__c> rows = new List<MonthlyInputRow__c>();
    //     // for (String keyVal : inputMap.keySet()) {
    //     //     Integer amount = inputMap.get(keyVal);
    //     //     if (amount == null) continue;

    //     //     Map<String, Object> cfg = configByKey.get(keyVal);
    //     //     String label = cfg != null ? (String)cfg.get('label') : keyVal;
    //     //     String groupName = cfg != null ? (String)cfg.get('group') : null;
    //     //     String sectionName = cfg != null ? (String)cfg.get('section') : null;

    //     //     MonthlyInputRow__c row = new MonthlyInputRow__c(
    //     //         Name = label,
    //     //         Category1__c = groupName,
    //     //         Category2__c = sectionName,
    //     //         Category3__c = keyVal,
    //     //         Amount__c = Decimal.valueOf(amount)
    //     //     );
    //     //     rows.add(row);
    //     }

    //     // if (!rows.isEmpty()) {
    //     //     insert rows;
    //     // }
    // }
}
