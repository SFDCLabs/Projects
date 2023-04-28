import { LightningElement, api } from 'lwc';

export default class BPLMCombobox extends LightningElement {
    @api isMultiSelect = false;
    value = 'inProgress';
    options = []
    values = []
    requiredOptions = [];

    connectedCallback() {
        const items = [
            { label: 'New', value: 'new' },
            { label: 'In Progress', value: 'inProgress' },
            { label: 'Finished', value: 'finished' },
        ];
        this.options.push(...items);
        this.values.push(...[this.value]);
        this.requiredOptions.push(...[this.value]);
    }

    handleChange(event) {
        this.value = event.detail.value;
    }
}