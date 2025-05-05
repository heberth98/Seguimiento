import { LightningElement, api, wire } from 'lwc';
import obtenerPorcentajeCompletado from '@salesforce/apex/SeguimientoProgresoController.obtenerPorcentajeCompletado';

export default class SeguimientoProgress extends LightningElement {
    @api recordId; // recibe el ID del Contacto

    porcentaje = 0;
    error;

    @wire(obtenerPorcentajeCompletado, { contactoId: '$recordId' })
    wiredPorcentaje({ data, error }) {
        if (data !== undefined) {
            this.porcentaje = data;
        } else if (error) {
            this.error = error;
            this.porcentaje = 0;
        }
    }
    // ver la consola del navegador en el Dev Tools.
    // connectedCallback() {
    //     console.log('RecordId recibido:', this.recordId);
    // }
}


