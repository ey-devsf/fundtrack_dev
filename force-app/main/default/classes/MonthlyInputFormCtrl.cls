public with sharing class MonthlyInputFormCtrl {

    @AuraEnabled(cacheable=true)
    public static String getInputFieldConfigJson() {
        return '[ ' +
            '{"key":"rakuten_bank_balance","label":"残高","group":"現金","section":"楽天銀行"},' +
            '{"key":"gmo_aozora_main","label":"親口座","group":"現金","section":"GMOあおぞら銀行"},' +
            '{"key":"gmo_aozora_insurance_tax","label":"社会保険・税金準備金","group":"現金","section":"GMOあおぞら銀行"},' +
            '{"key":"gmo_aozora_emergency_fund","label":"生活防衛資金","group":"現金","section":"GMOあおぞら銀行"},' +
            '{"key":"gmo_aozora_move_fund","label":"引越準備金","group":"現金","section":"GMOあおぞら銀行"},' +
            '{"key":"gmo_aozora_pc_saving","label":"パソコン貯金","group":"現金","section":"GMOあおぞら銀行"},' +
            '{"key":"gmo_aozora_phone_saving","label":"スマホ貯金","group":"現金","section":"GMOあおぞら銀行"},' +
            '{"key":"sbi_bank_balance","label":"残高","group":"現金","section":"SBI銀行"},' +
            '{"key":"sbi_securities_cash","label":"買付余力","group":"現金","section":"SBI証券"},' +
            '{"key":"rakuten_card_amount_due","label":"楽天カード","group":"クレカ","section":"楽天カード"},' +
            '{"key":"smbc_card_amount_due","label":"三井住友カード","group":"クレカ","section":"三井住友カード"},' +
            '{"key":"prudential_life_refund","label":"解約返戻金","group":"投資","section":"プルデンシャル生命"},' +
            '{"key":"rakuten_ideco","label":"iDeCo","group":"投資","section":"楽天証券"},' +
            '{"key":"sbi_securities_sp500","label":"S&P500","group":"投資","section":"SBI証券-特定口座"},' +
            '{"key":"sbi_securities_all_country","label":"オルカン","group":"投資","section":"SBI証券-特定口座"},' +
            '{"key":"sbi_securities_india","label":"iFreeインド","group":"投資","section":"SBI証券-特定口座"},' +
            '{"key":"sbi_securities_sumitomo_world","label":"三井住友全世界インデックス","group":"投資","section":"SBI証券-特定口座"},' +
            '{"key":"sbi_securities_vti","label":"VTI","group":"投資","section":"SBI証券-特定口座"},' +
            '{"key":"sbi_nisa_growth_sp500","label":"S&P500","group":"投資","section":"SBI証券-NISA-成長"},' +
            '{"key":"sbi_nisa_growth_all_country","label":"オルカン","group":"投資","section":"SBI証券-NISA-成長"},' +
            '{"key":"sbi_nisa_growth_india","label":"iFreeインド","group":"投資","section":"SBI証券-NISA-成長"},' +
            '{"key":"sbi_nisa_growth_stocks","label":"個別株合計","group":"投資","section":"SBI証券-NISA-成長"},' +
            '{"key":"sbi_nisa_tsumitate_sp500","label":"S&P500","group":"投資","section":"SBI証券-NISA-積立"},' +
            '{"key":"sbi_nisa_tsumitate_all_country","label":"オルカン","group":"投資","section":"SBI証券-NISA-積立"},' +
            '{"key":"sbi_nisa_old_all_country","label":"オルカン","group":"投資","section":"SBI証券-旧NISA"},' +
            '{"key":"bitflyer_bitcoin","label":"Bitcoin","group":"投資","section":"bitFlyer"},' +
            '{"key":"bitflyer_ethereum","label":"Ethereum","group":"投資","section":"bitFlyer"}' +
        ' ]';
    }
}
