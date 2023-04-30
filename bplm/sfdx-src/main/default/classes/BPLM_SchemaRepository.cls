/**
 * This {@link BPLM_SchemaRepository} class provide useful schema repository APIs for BPLM Schema by implementing method from {@link BPLM_SchemaRepository.BPLM_ISchemaRepository}. Refer to {@link BPLM_SchemaRepository.BPLM_ISchemaRepository} interface for APIs.
 * @author Rahul Chaudhary (rchaudhary@fiskerinc.com)
 * @version 0.0.1-Alpha
 * @since April 2023
 */
public with sharing class BPLM_SchemaRepository implements BPLM_ISchemaRepository {
    
    /**
     * <p> This method build a query string that is expected to generate a dynamic query expected to get entire schema</p>
     */
    public String getBPLMSchemaQuery() {
        final String ACTIVE_FLAG='Is_Active__c = true';
        String toReturn = 'SEELCT {0}, {1}, {2}, {3}, {4} FROM {5} where {6}';
        
        try {
            Map<Schema.SObjectType, Map<String, Schema.SObjectField>> bplmSchema = BPLM_SchemaFactory.getBPLMConfigurationSchema();

            // Start with child subquery first to get all depencies for a mapping
            final String CHILD_MAPPING2DEPENDENCY_RELATIONSHIP_NAME = 'Business_Process_Step_Task_Dependencies1__r';
            String CHILD_SUBQUERY_MAPPING2DEPENDENCY = '(select {0} from {1} WHERE {2})';
            //arrange all fields from Business_Process_Step_Task_Dependency__c where the depends on relationship is Business_Process_Step_Task_Dependencies1__r
            List<String> stepTaskDependencyFields = new List<String>();
            stepTaskDependencyFields.addAll(bplmSchema.get(Business_Process_Step_Task_Dependency__c.SObjectType).keySet());
            CHILD_SUBQUERY_MAPPING2DEPENDENCY = String.format(CHILD_SUBQUERY_MAPPING2DEPENDENCY, new List<String> {
                String.join(stepTaskDependencyFields, ','),
                CHILD_MAPPING2DEPENDENCY_RELATIONSHIP_NAME,
                ACTIVE_FLAG
            });

        } catch (Exception ex) {
            throw new BPLM_SchemaRepository.BPLMSchemaException(ex);
        }
        
        return toReturn;
    }

    private String get

    
    /**
     *  BPLM_ISchemaRepository interface declare APIs for BPLM Schema. these APIs methods are expected to provide describe schema usecases. 
     */
    public interface BPLM_ISchemaRepository {
        String getBPLMSchemaQuery();
    }

    public class BPLMSchemaException extends Exception {}
}