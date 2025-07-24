public with sharing class MonthlyInputFormConfig {
    public class FormField {
        public String key { get; set; }
        public String label { get; set; }
        public String groupLabel { get; set; }
        public String sectionLabel { get; set; }
        public Object value { get; set; }

        public FormField(String key, String label, String groupLabel, String sectionLabel, Object value) {
            this.key = key;
            this.label = label;
            this.groupLabel = groupLabel;
            this.sectionLabel = sectionLabel;
            this.value = value;
        }
    }

    public static List<FormField> getFormFieldDifinitions() {
        List<FormField> formFields = new List<FormField>{
            new FormField('rakuten_bank_balance', '残高', '現金', '楽天銀行', null),
            new FormField('gmo_aozora_main', '親口座', '現金', 'GMOあおぞら銀行', null),
            new FormField('gmo_aozora_insurance_tax', '社会保険・税金準備金', '現金', 'GMOあおぞら銀行', null),
            new FormField('gmo_aozora_emergency_fund', '生活防衛資金', '現金', 'GMOあおぞら銀行', null),
            new FormField('gmo_aozora_move_fund', '引越準備金', '現金', 'GMOあおぞら銀行', null),
            new FormField('gmo_aozora_pc_saving', 'パソコン貯金', '現金', 'GMOあおぞら銀行', null),
            new FormField('gmo_aozora_phone_saving', 'スマホ貯金', '現金', 'GMOあおぞら銀行', null),
            new FormField('sbi_bank_balance', '残高', '現金', 'SBI銀行', null),
            new FormField('sbi_securities_cash', '買付余力', '現金', 'SBI証券', null),
            new FormField('rakuten_card_amount_due', '楽天カード', 'クレカ', '楽天カード', null),
            new FormField('smbc_card_amount_due', '三井住友カード', 'クレカ', '三井住友カード', null),
            new FormField('prudential_life_refund', '解約返戻金', '投資', 'プルデンシャル生命', null),
            new FormField('rakuten_ideco', 'iDeCo', '投資', '楽天証券', null),
            new FormField('sbi_securities_sp500', 'S&P500', '投資', 'SBI証券-特定口座', null),
            new FormField('sbi_securities_all_country', 'オルカン', '投資', 'SBI証券-特定口座', null),
            new FormField('sbi_securities_india', 'iFreeインド', '投資', 'SBI証券-特定口座', null),
            new FormField('sbi_securities_sumitomo_world', '三井住友全世界インデックス', '投資', 'SBI証券-特定口座', null),
            new FormField('sbi_securities_vti', 'VTI', '投資', 'SBI証券-特定口座', null),
            new FormField('sbi_nisa_growth_sp500', 'S&P500', '投資', 'SBI証券-NISA-成長', null),
            new FormField('sbi_nisa_growth_all_country', 'オルカン', '投資', 'SBI証券-NISA-成長', null),
            new FormField('sbi_nisa_growth_india', 'iFreeインド', '投資', 'SBI証券-NISA-成長', null),
            new FormField('sbi_nisa_growth_stocks', '個別株合計', '投資', 'SBI証券-NISA-成長', null),
            new FormField('sbi_nisa_tsumitate_sp500', 'S&P500', '投資', 'SBI証券-NISA-積立', null),
            new FormField('sbi_nisa_tsumitate_all_country', 'オルカン', '投資', 'SBI証券-NISA-積立', null),
            new FormField('sbi_nisa_old_all_country', 'オルカン', '投資', 'SBI証券-旧NISA', null),
            new FormField('bitflyer_bitcoin', 'Bitcoin', '投資', 'bitFlyer', null),
            new FormField('bitflyer_ethereum', 'Ethereum', '投資', 'bitFlyer', null)
        };

        return formFields;
    }
}