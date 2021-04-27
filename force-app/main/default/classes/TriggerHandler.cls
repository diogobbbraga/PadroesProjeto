public abstract class TriggerHandler {
    private TriggerContext context;
    
    public TriggerHandler() {
        this.setTriggerContext();
    }
    
    private void setTriggerContext() {
        if(Trigger.isBefore && Trigger.isInsert) {
            this.context = TriggerContext.BEFORE_INSERT;
        } else if(Trigger.isBefore && Trigger.isUpdate) {
            this.context = TriggerContext.BEFORE_UPDATE;
        } else if(Trigger.isBefore && Trigger.isDelete) {
            this.context = TriggerContext.BEFORE_DELETE;
        } else if(Trigger.isAfter && Trigger.isInsert) {
            this.context = TriggerContext.AFTER_INSERT;
        } else if(Trigger.isAfter && Trigger.isUpdate) {
            this.context = TriggerContext.AFTER_UPDATE;
        } else if(Trigger.isAfter && Trigger.isDelete) {
            this.context = TriggerContext.AFTER_DELETE;
        } else if(Trigger.isAfter && Trigger.isUndelete) {
            this.context = TriggerContext.AFTER_UNDELETE;
        } 
    }
    
    public void run() {
        if(this.context == TriggerContext.BEFORE_INSERT) {
            this.beforeInsert();
        } else if(this.context == TriggerContext.BEFORE_UPDATE) {
            this.beforeUpdate();
        } else if(this.context == TriggerContext.BEFORE_DELETE) {
            this.beforeDelete();
        } else if(this.context == TriggerContext.AFTER_INSERT) {
            this.afterInsert();
        } else if(this.context == TriggerContext.AFTER_UPDATE) {
            this.afterUpdate();
        } else if(this.context == TriggerContext.AFTER_DELETE) {
            this.afterDelete();
        } else if(this.context == TriggerContext.AFTER_UNDELETE) {
            this.afterUndelete();
        }
    }
        
    protected virtual void beforeInsert() {
        System.debug(LoggingLevel.FINEST, 'Abstract Trigger Handler, Before Insert Context');
    }
    
    protected virtual void beforeUpdate() {
        System.debug(LoggingLevel.FINEST, 'Abstract Trigger Handler, Before Update Context');
    }
    
    protected virtual void beforeDelete() {
        System.debug(LoggingLevel.FINEST, 'Abstract Trigger Handler, Before Delete Context');
    }
    
    protected virtual void afterInsert() {
        System.debug(LoggingLevel.FINEST, 'Abstract Trigger Handler, After Insert Context');
    }
    
    protected virtual void afterUpdate() {
        System.debug(LoggingLevel.FINEST, 'Abstract Trigger Handler, After Update Context');
    }
    
    protected virtual void afterDelete() {
        System.debug(LoggingLevel.FINEST, 'Abstract Trigger Handler, After Delete Context');
    }
    
    protected virtual void afterUndelete() {
        System.debug(LoggingLevel.FINEST, 'Abstract Trigger Handler, After Undelete Context');
    } 
        
    protected List<SObject> getTriggerNew() {
        if(Trigger.new == null) {
            return new List<SObject>();
        } else {
            return Trigger.new;
        }
    }
        
    protected List<SObject> getTriggerOld() {
        if(Trigger.old == null) {
            return new List<SObject>();
        } else {
            return Trigger.old;
        }
    }
    
    protected Map<Id, SObject> getTriggerMapNew() {
        return Trigger.newMap;
    }
    
    protected Map<Id, SObject> getTriggerMapOld() {
        return Trigger.oldMap;
    }
        
    protected List<SObject> getTriggerNewByRecordTypeDeveloperName(String recordTypeDeveloperName) {
        return getListByRecordTypeDeveloperName(getTriggerNew(), recordTypeDeveloperName);
    }
    
    protected List<SObject> getTriggerOldByRecordTypeDeveloperName(String recordTypeDeveloperName) {
        return getListByRecordTypeDeveloperName(getTriggerOld(), recordTypeDeveloperName);
    }
    
    protected Map<Id, SObject> buildMapByRecordTypeDeveloperName(String recordTypeDeveloperName, Map<Id, SObject> mapObjects, List<SObject> listObjects) {
        if(listObjects.isEmpty()) {
            return mapObjects;
        }
        
        for(SObject varSObject : listObjects) {
            if(!String.isBlank(varSObject.Id)) {
                mapObjects.put(varSObject.Id, varSObject);
            }
        }
        
        return mapObjects;
    }
    
    protected Map<Id, SObject> getTriggerNewMapByRecordTypeDeveloperName(String recordTypeDeveloperName, Map<Id, SObject> mapObjects) {
        List<SObject> listObjects = getListByRecordTypeDeveloperName(getTriggerNew(), recordTypeDeveloperName);
        return buildMapByRecordTypeDeveloperName(recordTypeDeveloperName, mapObjects, listObjects);
    }
    
    protected Map<Id, SObject> getTriggerOldMapByRecordTypeDeveloperName(String recordTypeDeveloperName, Map<Id, SObject> mapObjects) {
        List<SObject> listObjects = getListByRecordTypeDeveloperName(getTriggerOld(), recordTypeDeveloperName);
        return buildMapByRecordTypeDeveloperName(recordTypeDeveloperName, mapObjects, listObjects);
    }
          
    private List<SObject> getListByRecordTypeDeveloperName(List<SObject> listObjects, String recordTypeDeveloperName) {
        Id recordTypeId = getRecordTypeIdByDeveloperName(recordTypeDeveloperName);
        
        List<SObject> listSeparetedObjects = new List<SObject>();
        for(SObject varSobject : listObjects) {
            if(recordTypeId.equals((Id) varSobject.get('RecordTypeId'))) {
                listSeparetedObjects.add(varSobject);
            }
        }
        
        return listSeparetedObjects;
    }
    
    private Id getRecordTypeIdByDeveloperName(String recordTypeDeveloperName) {
        SObject varSobject;
        if(Trigger.new != null) {
            varSobject = Trigger.new.get(0);
        } else if(Trigger.old != null){
            varSobject = Trigger.old.get(0);
        } else {
            throw new TriggerHandlerException('Trigger.new and Trigger.old is null');
        }
        
        if(!varSobject.getSObjectType().getDescribe().getRecordTypeInfosByDeveloperName().containsKey(recordTypeDeveloperName)) {
            throw new TriggerHandlerException('record type [' +recordTypeDeveloperName+ '] not found on sobject [' + varSobject.getSObjectType().getDescribe().getName() + ']');
        }
        
        return varSobject.getSObjectType().getDescribe().getRecordTypeInfosByDeveloperName().get(recordTypeDeveloperName).getRecordTypeId();
    }
    
    private enum TriggerContext {
        BEFORE_INSERT, 
        BEFORE_UPDATE, 
        BEFORE_DELETE,
        AFTER_INSERT, 
        AFTER_UPDATE, 
        AFTER_DELETE, 
        AFTER_UNDELETE
    }
    
    public class TriggerHandlerException extends Exception {
    
    }
}