/**
 * This {@link BPLM_SchemaRepository} class provide useful schema repository APIs for BPLM Schema by implementing method from {@link BPLM_SchemaRepository.BPLM_ISchemaRepository}. Refer to {@link BPLM_SchemaRepository.BPLM_ISchemaRepository} interface for APIs.
 * @author Rahul Chaudhary (rchaudhary@fiskerinc.com)
 * @version 0.0.1-Alpha
 * @since April 2023
 */
public with sharing class BPLM_SchemaRepository implements BPLM_ISchemaRepository {
  private Map<Schema.SObjectType, Map<String, Schema.SObjectField>> bplmSchema = BPLM_SchemaFactory.getBPLMConfigurationSchema();
  final String ACTIVE_FLAG = 'Is_Active__c = true';
  /**
   * <p> This method build a query string that is expected to generate a dynamic query expected to get entire schema</p>
   */
  public String getBPLMSchemaQuery() {
    String toReturn = 'SEELCT {0}, {1}, {2}, {3}, {4} FROM {5} where {6}';
    try {
      // Get all fields for Business_Process_Step_Task_Mapping__c except two relationships
      final String stepTaskMappingFieldsWithoutKeyRelationships = getBPLMstepTaskMappingQuery(); // {0}

      // Get all friends from Business_Process_Task__c as relationship such as Business_Process_Task__r.id etc
      final String bplmTaskFields = getBPLMTaskFields(); // {1}

      // Get all fields from Business_Process_Step__c as relationship such as Business_Process_Step__r.id etc, except relationfields such as Business_Process_Stage__c
      final String bplmStepFields = getBPLMStepFields(); // {2}

      /*Get all fields from stage and process as relationsip ranging from mapping object such as Business_Process_Step__r.Business_Process_Stage__r
      or
      Business_Process_Step__r.Business_Process_Stage__r.Business_Process__r 

      use step as entry point as mentioned in above examples
      */

      final String otherReferenceFields = getAllReferenceFields();

      // build child subquery first to get all depencies for a mapping
      final String CHILD_SUBQUERY_MAPPING2DEPENDENCY = getBPLMStepTaskDependencyQuery(); // {4}
    } catch (Exception ex) {
      throw new BPLM_SchemaRepository.BPLMSchemaException(ex);
    }

    return toReturn;
  }

  /*Get all fields from stage and process as relationsip ranging from mapping object such as Business_Process_Step__r.Business_Process_Stage__r
      or
      Business_Process_Step__r.Business_Process_Stage__r.Business_Process__r 

      use step as entry point as mentioned in above examples
      */
  private String getAllReferenceFields() {
    List<String> fields = new List<String>();

    return String.join(fields, ',');
  }

  /**
   * <p>Get child query using for Business_Process_Step_Task_Dependency__c using relationship Business_Process_Step_Task_Dependencies1__r</p>
   */
  private String getBPLMStepTaskDependencyQuery() {
    final String CHILD_MAPPING2DEPENDENCY_RELATIONSHIP_NAME = 'Business_Process_Step_Task_Dependencies1__r';
    final String CHILD_SUBQUERY_MAPPING2DEPENDENCY = '(select {0} from {1} WHERE {2})';
    //arrange all fields from Business_Process_Step_Task_Dependency__c where the depends on relationship is Business_Process_Step_Task_Dependencies1__r
    List<String> stepTaskDependencyFields = new List<String>();
    stepTaskDependencyFields.addAll(
      bplmSchema.get(Business_Process_Step_Task_Dependency__c.SObjectType)
        .keySet()
    );
    CHILD_SUBQUERY_MAPPING2DEPENDENCY = String.format(
      CHILD_SUBQUERY_MAPPING2DEPENDENCY,
      new List<String>{
        String.join(stepTaskDependencyFields, ','),
        CHILD_MAPPING2DEPENDENCY_RELATIONSHIP_NAME,
        ACTIVE_FLAG
      }
    );
    return CHILD_SUBQUERY_MAPPING2DEPENDENCY;
  }

  /**
   * <p>Get all fields from step task mapping except the two key relationship fields Business_Process_Task__c and Business_Process_Step__c
   *    idea is to get all their details separately in relationship manner such as Business_Process_Task__r.id etc.</p>
   */
  private String getBPLMstepTaskMappingQuery() {
    List<String> stepTaskMappingFields = new List<String>();
    for (
      String f : bplmSchema.get(
          Business_Process_Step_Task_Mapping__c.SObjectType
        )
        .keySet()
    ) {
      if (
        !f.equalsIgnoreCase('Business_Process_Task__c') ||
        !f.equalsIgnoreCase('Business_Process_Step__c')
      ) {
        stepTaskMappingFields.add(f); //Add Fields To List, avoid 2 relationships Business_Process_Task__c and Business_Process_Step__c
      }
    }
    return String.join(stepTaskMappingFields, ',');
  }

  public List<Business_Process_Step_Task_Mapping__c> getBPLMSchemaByProcessName(
    String processName
  ) {
    List<Business_Process_Step_Task_Mapping__c> toReturn = null;

    return toReturn;
  }
  public List<Business_Process_Step_Task_Mapping__c> getBPLMSchemaByProcessId(
    String processId
  ) {
    List<Business_Process_Step_Task_Mapping__c> toReturn = null;

    return toReturn;
  }

  /**
   * <p>
   * Get all fields from BPLM Step object Business_Process_Step__c in relationship mode
   * such as Business_Process_Step__r.id etc.
   * </p>
   */
  private String getBPLMStepFields() {
    final String objName = 'Business_Process_Step__r';
    List<String> fields = new List<String>();
    Set<String> bplmTaskFields = bplmSchema.get(
        Business_Process_Step__c.SObjectType
      )
      .keySet();
    for (String f : bplmTaskFields) {
      fields.add(objName + '.' + f);
    }
    return String.join(fields, ',');
  }

  /**
   * <p>
   * Get all fields from BPLM Task object Business_Process_Task__c in relationship mode
   * such as Business_Process_Task__r.id etc.
   * </p>
   */
  private String getBPLMTaskFields() {
    final String objName = 'Business_Process_Task__r';
    List<String> fields = new List<String>();
    Set<String> bplmTaskFields = bplmSchema.get(
        Business_Process_Task__c.SObjectType
      )
      .keySet();
    for (String f : bplmTaskFields) {
      fields.add(objName + '.' + f);
    }
    return String.join(fields, ',');
  }

  /**
   *  BPLM_ISchemaRepository interface declare APIs for BPLM Schema. these APIs methods are expected to provide describe schema usecases.
   */
  public interface BPLM_ISchemaRepository {
    String getBPLMSchemaQuery();
    List<Business_Process_Step_Task_Mapping__c> getBPLMSchemaByProcessName(
      String processName
    );
    List<Business_Process_Step_Task_Mapping__c> getBPLMSchemaByProcessId(
      String processId
    );
  }

  public class BPLMSchemaException extends Exception {
  }
}
