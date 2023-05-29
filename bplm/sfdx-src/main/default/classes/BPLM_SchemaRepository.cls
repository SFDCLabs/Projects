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
   * Master query looks like this
   * 
   * SELECT id,ownerid,isdeleted,name,createddate,createdbyid,lastmodifieddate,lastmodifiedbyid,systemmodstamp,lastvieweddate,lastreferenceddate,is_active__c,business_process_step__c,business_process_task__c,sequence__c, Business_Process_Task__r.id,Business_Process_Task__r.ownerid,Business_Process_Task__r.isdeleted,Business_Process_Task__r.name,Business_Process_Task__r.createddate,Business_Process_Task__r.createdbyid,Business_Process_Task__r.lastmodifieddate,Business_Process_Task__r.lastmodifiedbyid,Business_Process_Task__r.systemmodstamp,Business_Process_Task__r.lastvieweddate,Business_Process_Task__r.lastreferenceddate,Business_Process_Task__r.assign_to_type__c,Business_Process_Task__r.priority__c,Business_Process_Task__r.is_active__c,Business_Process_Task__r.assign_to__c,Business_Process_Task__r.buffer_days__c,Business_Process_Task__r.manual_start_enabled__c,Business_Process_Task__r.task_summary__c,Business_Process_Task__r.activity_type__c,Business_Process_Task__r.subject__c,Business_Process_Task__r.assign_by__c, Business_Process_Step__r.id,Business_Process_Step__r.ownerid,Business_Process_Step__r.isdeleted,Business_Process_Step__r.name,Business_Process_Step__r.createddate,Business_Process_Step__r.createdbyid,Business_Process_Step__r.lastmodifieddate,Business_Process_Step__r.lastmodifiedbyid,Business_Process_Step__r.systemmodstamp,Business_Process_Step__r.lastvieweddate,Business_Process_Step__r.lastreferenceddate,Business_Process_Step__r.sequence__c,Business_Process_Step__r.step_summary__c,Business_Process_Step__r.business_process_step_owner__c,Business_Process_Step__r.is_active__c,Business_Process_Step__r.business_days_to_complete__c,Business_Process_Step__r.buffer_days__c,Business_Process_Step__r.priority__c,Business_Process_Step__r.business_process_stage__c, Business_Process_Step__r.Business_Process_Stage__r.id,Business_Process_Step__r.Business_Process_Stage__r.ownerid,Business_Process_Step__r.Business_Process_Stage__r.isdeleted,Business_Process_Step__r.Business_Process_Stage__r.name,Business_Process_Step__r.Business_Process_Stage__r.createddate,Business_Process_Step__r.Business_Process_Stage__r.createdbyid,Business_Process_Step__r.Business_Process_Stage__r.lastmodifieddate,Business_Process_Step__r.Business_Process_Stage__r.lastmodifiedbyid,Business_Process_Step__r.Business_Process_Stage__r.systemmodstamp,Business_Process_Step__r.Business_Process_Stage__r.lastvieweddate,Business_Process_Step__r.Business_Process_Stage__r.lastreferenceddate,Business_Process_Step__r.Business_Process_Stage__r.business_process_stage_owner__c,Business_Process_Step__r.Business_Process_Stage__r.stage_summary__c,Business_Process_Step__r.Business_Process_Stage__r.sequence__c,Business_Process_Step__r.Business_Process_Stage__r.business_days_to_complete__c,Business_Process_Step__r.Business_Process_Stage__r.buffer_days__c,Business_Process_Step__r.Business_Process_Stage__r.is_active__c,Business_Process_Step__r.Business_Process_Stage__r.priority__c,Business_Process_Step__r.Business_Process_Stage__r.days_before_due_date_for_at_risk__c,Business_Process_Step__r.Business_Process_Stage__r.Business_Process__r.id,Business_Process_Step__r.Business_Process_Stage__r.Business_Process__r.ownerid,Business_Process_Step__r.Business_Process_Stage__r.Business_Process__r.isdeleted,Business_Process_Step__r.Business_Process_Stage__r.Business_Process__r.name,Business_Process_Step__r.Business_Process_Stage__r.Business_Process__r.createddate,Business_Process_Step__r.Business_Process_Stage__r.Business_Process__r.createdbyid,Business_Process_Step__r.Business_Process_Stage__r.Business_Process__r.lastmodifieddate,Business_Process_Step__r.Business_Process_Stage__r.Business_Process__r.lastmodifiedbyid,Business_Process_Step__r.Business_Process_Stage__r.Business_Process__r.systemmodstamp,Business_Process_Step__r.Business_Process_Stage__r.Business_Process__r.lastvieweddate,Business_Process_Step__r.Business_Process_Stage__r.Business_Process__r.lastreferenceddate,Business_Process_Step__r.Business_Process_Stage__r.Business_Process__r.business_process_owner__c,Business_Process_Step__r.Business_Process_Stage__r.Business_Process__r.process_summary__c,Business_Process_Step__r.Business_Process_Stage__r.Business_Process__r.business_sobject_type__c,Business_Process_Step__r.Business_Process_Stage__r.Business_Process__r.is_active__c,Business_Process_Step__r.Business_Process_Stage__r.Business_Process__r.business_org__c,Business_Process_Step__r.Business_Process_Stage__r.Business_Process__r.business_brand_name__c,Business_Process_Step__r.Business_Process_Stage__r.Business_Process__r.type__c,Business_Process_Step__r.Business_Process_Stage__r.Business_Process__r.developer_name__c, (select id,ownerid,isdeleted,name,createddate,createdbyid,lastmodifieddate,lastmodifiedbyid,systemmodstamp,lastvieweddate,lastreferenceddate,business_process_step_task_mapping__c,depend_upon__c,is_active__c,task_name__c,depend_on_task_name__c from Business_Process_Step_Task_Dependencies1__r WHERE Is_Active__c = true) FROM Business_Process_Step_Task_Mapping__c
   *
   */
  public String getBPLMSchemaQuery() {
    String toReturn = 'SELECT {0}, {1}, {2}, {3}, {4} FROM {5}';
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

      final String otherReferenceFields = getAllReferenceFields(); // {3}

      // build child subquery first to get all depencies for a mapping
      final String CHILD_SUBQUERY_MAPPING2DEPENDENCY = getBPLMStepTaskDependencyQuery(); // {4}

      // define master entry point in complex query
      final String mappingObjectName = 'Business_Process_Step_Task_Mapping__c'; // {5}

      toReturn = String.format(toReturn, new List<String> {
        stepTaskMappingFieldsWithoutKeyRelationships,
        bplmTaskFields,
        bplmStepFields,
        otherReferenceFields,
        CHILD_SUBQUERY_MAPPING2DEPENDENCY,
        mappingObjectName
      });

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
    String stageStartPoint = 'Business_Process_Step__r.Business_Process_Stage__r';
    String processStartPoint = 'Business_Process_Step__r.Business_Process_Stage__r.Business_Process__r';
    List<String> fields = new List<String>();
    // Iterate over stage fields
    for(String f: bplmSchema.get(Business_Process_Stage__c.SObjectType).keySet()) {
      if(!f.equalsIgnoreCase('Business_Process__c')) { // avoid process fields will populate separately
        fields.add(stageStartPoint+'.'+f);
      }
    }

    for(String f: bplmSchema.get(Business_Process__c.SObjectType).keySet()) {
        fields.add(processStartPoint+'.'+f);
    }
    return String.join(fields, ',');
  }

  /**
   * <p>Get child query using for Business_Process_Step_Task_Dependency__c using relationship Business_Process_Step_Task_Dependencies1__r</p>
   */
  private String getBPLMStepTaskDependencyQuery() {
    final String CHILD_MAPPING2DEPENDENCY_RELATIONSHIP_NAME = 'Business_Process_Step_Task_Dependencies1__r';
    String childDependencyQuery = '(select {0} from {1} WHERE {2})';
    //arrange all fields from Business_Process_Step_Task_Dependency__c where the depends on relationship is Business_Process_Step_Task_Dependencies1__r
    List<String> stepTaskDependencyFields = new List<String>();
    stepTaskDependencyFields.addAll(
      bplmSchema.get(Business_Process_Step_Task_Dependency__c.SObjectType)
        .keySet()
    );
    childDependencyQuery = String.format(
      childDependencyQuery,
      new List<String>{
        String.join(stepTaskDependencyFields, ','),
        CHILD_MAPPING2DEPENDENCY_RELATIONSHIP_NAME,
        ACTIVE_FLAG
      }
    );
    return childDependencyQuery;
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


  /**
   * <p> Return BPLM configuration for a given process by its developer_name__c field </p>
   */
  public List<Business_Process_Step_Task_Mapping__c> getBPLMSchemaByProcessName(
    String processDeveloperName
  ) {
    if(String.isBlank(processDeveloperName)) {
      throw new BPLMSchemaException('Reqired param processDeveloperName can not be null or blank');
    }
    String condition = ' WHERE Business_Process_Step__r.Business_Process_Stage__r.Business_Process__r.Developer_Name__c = :processDeveloperName';
    String query = getBPLMSchemaQuery() + condition;
    List<Business_Process_Step_Task_Mapping__c> toReturn = (List<Business_Process_Step_Task_Mapping__c>) Database.query(query);
    return toReturn;
  }

  /**
   * <p> Return BPLM configuration for a given process by its process id field </p>
   */
  public List<Business_Process_Step_Task_Mapping__c> getBPLMSchemaByProcessId(
    String processId
  ) {
    if(String.isBlank(processId)) {
      throw new BPLMSchemaException('Reqired param processId can not be null or blank');
    }
    String condition = ' WHERE Business_Process_Step__r.Business_Process_Stage__r.Business_Process__r.Id = :processId';
    String query = getBPLMSchemaQuery() + condition;
    List<Business_Process_Step_Task_Mapping__c> toReturn = (List<Business_Process_Step_Task_Mapping__c>) Database.query(query);
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
      String processDeveloperName
    );
    List<Business_Process_Step_Task_Mapping__c> getBPLMSchemaByProcessId(
      String processId
    );
  }

  public class BPLMSchemaException extends Exception {
  }
}
