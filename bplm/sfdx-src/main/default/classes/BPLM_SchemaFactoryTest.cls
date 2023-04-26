
@IsTest
private class BPLM_SchemaFactoryTest {
    private static Map<Schema.SObjectType, Map<String, Schema.SObjectField>> bplmSchema;
    
        
    @IsTest
    static void testSchemaPopulationWithoutCache() {
        Boolean useCache = false;
        bplmSchema = BPLM_SchemaFactory.getBPLMConfigurationSchema(useCache);
        System.debug('size = '+bplmSchema.size());
        System.assert(bplmSchema != null, 'Schema should not be null');
        System.assert(!bplmSchema.isEmpty(), 'Schema should not be empty');
    }


    @IsTest
    static void testSchemaPopulationWithCache() {
        Boolean useCache = true;
        bplmSchema = BPLM_SchemaFactory.getBPLMConfigurationSchema(useCache);
        System.debug('size = '+bplmSchema.size());
        System.assert(bplmSchema != null, 'Schema should not be null');
        System.assert(!bplmSchema.isEmpty(), 'Schema should not be empty');
    }
}