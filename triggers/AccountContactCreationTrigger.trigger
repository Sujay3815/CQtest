trigger AccountContactCreationTrigger on Account (after insert, after update) {
    AccountContactCreationHandler.createContacts(Trigger.new, Trigger.oldMap);
}