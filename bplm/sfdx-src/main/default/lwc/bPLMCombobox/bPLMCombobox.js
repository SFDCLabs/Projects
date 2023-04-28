import { LightningElement, api } from 'lwc';

export default class BPLMCombobox extends LightningElement {
    @api isMultiSelect = false;
    value = 'inProgress';

    get options() {
        return [
            { label: 'New', value: 'new' },
            { label: 'In Progress', value: 'inProgress' },
            { label: 'Finished', value: 'finished' },
        ];
    }

    handleChange(event) {
        this.value = event.detail.value;
    }
}