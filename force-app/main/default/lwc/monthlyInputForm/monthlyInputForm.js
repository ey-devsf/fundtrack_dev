import { LightningElement, wire, track } from 'lwc';
import init from '@salesforce/apex/MonthlyInputFormCtrl.init';
// import saveInputRows from '@salesforce/apex/MonthlyInputFormCtrl.saveInputRows';

export default class MonthlyInputForm extends LightningElement {
    isLoading = false;
    groupedView = []; // 表示用構造
    inputValues = {};
    error;

    connectedCallback() {
        this.isLoading = true;
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
            })
            .finally(() => {
                this.isLoading = false;
            });
    }

    buildGroupedView(items) {
        const map = new Map();
        for (const { groupLabel, sectionLabel, key, label } of items) {
            if (!map.has(groupLabel)) map.set(groupLabel, new Map());
            const sectionMap = map.get(groupLabel);
            if (!sectionMap.has(sectionLabel)) sectionMap.set(sectionLabel, []);
            sectionMap.get(sectionLabel).push({ key, label });
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

    handleInputChange(event) {
        const key = event.target.dataset.key;
        this.inputValues[key] = event.target.value;
    }

    handleSave() {
        saveInputRows({ inputMap: this.inputValues })
            .then(() => {
                this.inputValues = {};
            })
            .catch((error) => {
                this.error = error.body ? error.body.message : error.message;
            });
    }
}
