@isTest
public with sharing class AccountTriggerHandlerTest {
    @isTest
    public static void mainTest() {
        Account a = new Account();
        a.Name = 'test';
        insert a;
        update a;
        delete a;
        undelete a;
    }
}