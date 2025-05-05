trigger LimitarPendientesSeguimiento on Seguimiento__c (before insert, before update) {
    Set<Id> contactoIds = new Set<Id>();

    for (Seguimiento__c s : Trigger.new) {
        if (
            (Trigger.isInsert && s.Etapa__c == 'Pendiente') ||
            (Trigger.isUpdate && s.Etapa__c == 'Pendiente' && 
             Trigger.oldMap.get(s.Id).Etapa__c != 'Pendiente')
        ) {
            if (s.Contacto__c != null) {
                contactoIds.add(s.Contacto__c);
            }
        }
    }

    if (!contactoIds.isEmpty()) {
        Map<Id, Integer> pendientesPorContacto = new Map<Id, Integer>();
// 
        for (AggregateResult ar : [
            SELECT Contacto__c, COUNT(Id) total
            FROM Seguimiento__c
            WHERE Contacto__c IN :contactoIds AND Etapa__c = 'Pendiente'
            GROUP BY Contacto__c
        ]) {
            pendientesPorContacto.put((Id)ar.get('Contacto__c'), (Integer)ar.get('total'));
        }

        for (Seguimiento__c s : Trigger.new) {
            if (
                s.Etapa__c == 'Pendiente' && 
                s.Contacto__c != null &&
                pendientesPorContacto.containsKey(s.Contacto__c) &&
                pendientesPorContacto.get(s.Contacto__c) >= 5
            ) {
                s.addError('No se pueden tener más de 5 seguimientos pendientes para este contacto.');
            }
        }
    }
}
