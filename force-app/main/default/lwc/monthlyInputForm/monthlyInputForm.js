import { LightningElement, wire, track } from 'lwc';
import getInputFieldConfigJson from '@salesforce/apex/MonthlyInputFormCtrl.getInputFieldConfigJson';
import saveInputRows from '@salesforce/apex/MonthlyInputFormCtrl.saveInputRows';

export default class MonthlyInputForm extends LightningElement {
    @track groupedView = []; // 表示用構造
    @track inputValues = {};
    error;

    @wire(getInputFieldConfigJson)
    wiredFieldConfig({ error, data }) {
        if (data) {
            try {
                const parsed = JSON.parse(data);
                this.groupedView = this.buildGroupedView(parsed);
            } catch (e) {
                this.error = 'JSON Parse Error: ' + e.message;
            }
        } else if (error) {
            this.error = error.body.message || error.message;
        }
    }

    buildGroupedView(items) {
        const map = new Map();
        for (const { group, section, key, label } of items) {
            if (!map.has(group)) map.set(group, new Map());
            const sectionMap = map.get(group);
            if (!sectionMap.has(section)) sectionMap.set(section, []);
            sectionMap.get(section).push({ key, label });
        }

        const result = [];
        for (const [group, sectionMap] of map) {
            const sections = [];
            for (const [section, fields] of sectionMap) {
                sections.push({ section, fields });
            }
            result.push({ group, sections });
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
