public with sharing class SeguimientoController {
    
    @AuraEnabled(cacheable=true)
    public static Integer obtenerPorcentajeCompletado(Id contactoId) {
        // si no se tiene el Id del registro que en ete caso pertenece a Contacto
        if (contactoId == null) return 0;

        List<Seguimiento__c> tareas = [
            SELECT Id, Etapa__c
            FROM Seguimiento__c
            WHERE Contacto__c = :contactoId
        ];
        
        // Total de tareas encontradas
        Integer total = tareas.size();
        if (total == 0) return 0;

        Integer completadas = 0;
        for (Seguimiento__c t : tareas) {
            if (t.Etapa__c == 'Completado') {
                completadas++;
            }
        }
        // retornar el pocerntaje de tareas completadas
        return (completadas * 100) / total;
    }
}
