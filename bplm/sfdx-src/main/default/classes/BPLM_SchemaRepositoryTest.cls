/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an org are executed whenever Apex code is deployed
 * to a production org to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production org. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the org size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class BPLM_SchemaRepositoryTest {
    private static BPLM_SchemaRepository.BPLM_ISchemaRepository repository = new BPLM_SchemaRepository();

    @isTest
    static void testGetBPLMSchemaQuery() {
        
        Test.startTest();
        String query = repository.getBPLMSchemaQuery();
        //System.debug(query);
        Test.stopTest();
        System.assert(!String.isBlank(query), 'Query must not be null or empty');
    }

    @isTest(SeeAllData=true)
    static void testGetBPLMSchemaByProcessName() {
        List<Business_Process_Step_Task_Mapping__c> records = repository.getBPLMSchemaByProcessName('Intake_Process');
        System.assert(records!= null && records.size() > 0, 'Must not be null or empty');
    }

    @isTest(SeeAllData=true)
    static void testGetBPLMSchemaByProcessId() {
        Business_Process__c bp = [select id,Process_Summary__c from business_process__c limit 1];
        List<Business_Process_Step_Task_Mapping__c> records = repository.getBPLMSchemaByProcessId(bp.id);
        System.assert(records!= null && records.size() > 0, 'Must not be null or empty');
    }
}