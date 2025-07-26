import { LightningElement, wire, track } from 'lwc';
import init from '@salesforce/apex/MonthlyInputFormCtrl.init';
import saveInputRows from '@salesforce/apex/MonthlyInputFormCtrl.saveInputRows';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class MonthlyInputForm extends LightningElement {
    isVisibleSpinner = false;
    isLoaded = false;
    groupedView = []; // 表示用構造
    inputValues = {};
    error;
    
    connectedCallback() {
        this.isVisibleSpinner = true;
        init()
            .then((data) => {
                try {
                    const parsed = JSON.parse(data);
                    this.groupedView = this.buildGroupedView(parsed);
                } catch (e) {
                    this.error = 'JSON Parse Error: ' + e.message;
                }
            })
            .catch((error) => {
                this.error = error.body?.message || error.message;
                this.showToast('Error', this.error, 'error');
            })
            .finally(() => {
                this.isVisibleSpinner = false;
                this.isLoaded = true;
            });
    }

    buildGroupedView(items) {
        const map = new Map();
        for (const { groupLabel, sectionLabel, key, label, value } of items) {
            if (!map.has(groupLabel)) map.set(groupLabel, new Map());
            const sectionMap = map.get(groupLabel);
            if (!sectionMap.has(sectionLabel)) sectionMap.set(sectionLabel, []);
            sectionMap.get(sectionLabel).push({ key, label, value });
        }

        const result = [];
        for (const [groupLabel, sectionMap] of map) {
            const sections = [];
            for (const [sectionLabel, fields] of sectionMap) {
                sections.push({ sectionLabel, fields });
            }
            result.push({ groupLabel, sections });
        }
        return result;
    }

    showToast(title, message, variant) {
        const toastEvent = new ShowToastEvent({
            title,
            message,
            variant,
        });
        this.dispatchEvent(toastEvent);
    }

    handleSave() {
        this.isVisibleSpinner = true;
        const inputs = this.template.querySelectorAll('lightning-input.amount-input');
        const inputMap = {};
        const targetMonth = '2025-07-01';
    
        inputs.forEach(input => {
            const key = input.dataset.key;
            const value = input.value;
            if (key) {
                inputMap[key] = value ? parseFloat(value) : null;
            }
        });
    
        saveInputRows({ inputMap, targetMonth })
            .then(() => {
                this.inputValues = {};
                this.showToast('Success', 'Input rows saved successfully.', 'success');
            })
            .catch((error) => {
                this.error = error.body ? error.body.message : error.message;
                this.showToast('Error', `Failed to save input rows: ${this.error}`, 'error');
            })
            .finally(() => {
                this.isVisibleSpinner = false;
            });
    }
}
