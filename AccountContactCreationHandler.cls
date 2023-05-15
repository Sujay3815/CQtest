public class AccountContactCreationHandler {
    public static void createContacts(List<Account> newAccounts, Map<Id, Account> oldMap) {
        List<Contact> contactsToInsertOrUpdate = new List<Contact>();
        for (Account acc : newAccounts) {
            if (acc.Active__c && (Trigger.isInsert || (Trigger.isUpdate && !oldMap.get(acc.Id).Active__c))) {
                List<Contact> existingContacts = [SELECT Id FROM Contact WHERE AccountId = :acc.Id LIMIT 1];
                if (existingContacts.isEmpty()) {
                    Contact newContact = new Contact(
                        AccountId = acc.Id,
                        FirstName = acc.Name,
                        LastName = 'Customer Representative',
						Email = acc.Company_Email__c,
						Phone = acc.Phone
                    );
                    contactsToInsertOrUpdate.add(newContact);
                }
            }
        }
        if (!contactsToInsertOrUpdate.isEmpty()) {
            upsert contactsToInsertOrUpdate;
        }
    }
}