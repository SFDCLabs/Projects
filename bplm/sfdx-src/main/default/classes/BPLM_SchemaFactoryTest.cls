
@IsTest
private class BPLM_SchemaFactoryTest {

    @IsTest
    static void testSchemaPopulation() {
        Test.startTest();
        Map<Schema.SObjectType, Map<String, Schema.SObjectField>> bplmSchema = BPLM_SchemaFactory.getBPLMConfigurationSchema();
        Test.stopTest();
        System.assert(bplmSchema != null, 'Schema should not be null');
        System.assert(!bplmSchema.isEmpty(), 'Schema should not be empty');
        
    }
}