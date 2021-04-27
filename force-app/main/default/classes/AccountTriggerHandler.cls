public class AccountTriggerHandler extends TriggerHandler {
    private List<Account> listNew = (List<Account>) this.getTriggerNew();
    private List<Account> listOld = (List<Account>) this.getTriggerOld();
    private List<Account> listNewPf = (List<Account>) this.getTriggerNewByRecordTypeDeveloperName('PF');
    private List<Account> listOldPf = (List<Account>) this.getTriggerOldByRecordTypeDeveloperName('PF');
    private Map<Id, Account> mapNew = (Map<Id, Account>) this.getTriggerMapNew();
    private Map<Id, Account> mapOld = (Map<Id, Account>) this.getTriggerMapOld();
    private Map<Id, Account> mapNewPF = (Map<Id, Account>) this.getTriggerNewMapByRecordTypeDeveloperName('PF', new Map<Id, Account>());
    private Map<Id, Account> mapOldPF = (Map<Id, Account>) this.getTriggerOldMapByRecordTypeDeveloperName('PF');
    
    protected override void beforeInsert() {
        System.debug(LoggingLevel.DEBUG, 'AccountTriggerHandler, Before Insert Context');
    }
    
    protected override void beforeUpdate() {
        System.debug(LoggingLevel.DEBUG, 'AccountTriggerHandler, Before Update Context');
    }
    
    protected override void beforeDelete() {
        System.debug(LoggingLevel.DEBUG, 'AccountTriggerHandler, Before Delete Context');
    }
    
    protected override void afterInsert() {
        System.debug(LoggingLevel.DEBUG, 'AccountTriggerHandler, After Insert Context');
    } 
    
    protected override void afterUpdate() {
        System.debug(LoggingLevel.DEBUG, 'AccountTriggerHandler, After Update Context');
    }
    
    protected override void afterDelete() {
        System.debug(LoggingLevel.DEBUG, 'AccountTriggerHandler, After Delete Context');
    }
    
    protected override void afterUndelete() {
        System.debug(LoggingLevel.DEBUG, 'AccountTriggerHandler, After Undelete Context');
    } 
    
    
}