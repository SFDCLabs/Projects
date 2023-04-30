/**
 * This {@link BPLM_SchemaFactory} class provide useful factory methods for Schema namespace.
 * @author Rahul Chaudhary (rchaudhary@fiskerinc.com)
 * @version 0.0.1-Alpha
 * @since April 2023
 */
public class BPLM_SchemaFactory {
  // Schema Cache for BPLM
  private static final String CUSTOM_FIELD_SUFFIX='__c';
  private static final String CUSTOM_RELATIONSHIP_SUFFIX='__r';
  private static Map<Schema.SObjectType, Map<String, Schema.SObjectField>> bplmSchema = new Map<Schema.SObjectType, Map<String, Schema.SObjectField>>();
  private static List<Schema.SObjectType> bplmObjects = new List<Schema.SObjectType> {
    Business_Process__c.SObjectType,
    Business_Process_Stage__c.SObjectType,
    Business_Process_Step__c.SObjectType,
    Business_Process_Task__c.SObjectType,
    Business_Process_Step_Task_Mapping__c.SObjectType,
    Business_Process_Step_Task_Dependency__c.SObjectType,
    Business_Process_Workflow_Rule__c.SObjectType,
    Business_Process_Workflow_Action__c.SObjectType
  };
  
  /**
   * <p>
   *  This method generate bplmSchema (SObjectTypes used in BPLM and their respective fields)
   * </p>
   * @return void
   */
  private static void loadBPLMConfigurationSchema() {   
    if(bplmSchema == null) {
      bplmSchema = new Map<Schema.SObjectType, Map<String, Schema.SObjectField>>(); 
    }
    if(bplmSchema != null && !bplmSchema.isEmpty()) { //clean
      bplmSchema.clear();
    }
    for (Schema.SObjectType typ : bplmObjects) {
      bplmSchema.put(typ, typ.getDescribe().fields.getMap());
    }
  }

  /*
  * This method return BPLM schema (SObjectTypes used in BPLM and their respective fields)
  * @param useCache - return cached schema if available else regenerate and return
  */
  public static Map<Schema.SObjectType, Map<String, Schema.SObjectField>> getBPLMConfigurationSchema() {
      loadBPLMConfigurationSchema();
      return bplmSchema;
  }

  private static String generateSchemaSOQL() {
    loadBPLMConfigurationSchema();
    String query = 'SELECT ';

    return null;
  }
}