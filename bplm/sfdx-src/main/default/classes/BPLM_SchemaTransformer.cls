public class BPLM_SchemaTransformer {
  // Business Process Fields
  private static Map<String, String> businessProcessFields = new Map<String, String>{
    'Business_Process_Step__r.Business_Process_Stage__r.Business_Process__r.id' => 'processId',
    'Business_Process_Step__r.Business_Process_Stage__r.Business_Process__r.name' => 'processName',
    'Business_Process_Step__r.Business_Process_Stage__r.Business_Process__r.business_process_owner__c' => 'processOwner',
    'Business_Process_Step__r.Business_Process_Stage__r.Business_Process__r.process_summary__c' => 'processSummary',
    'Business_Process_Step__r.Business_Process_Stage__r.Business_Process__r.business_sobject_type__c' => 'businessObject',
    'Business_Process_Step__r.Business_Process_Stage__r.Business_Process__r.is_active__c' => 'isActive',
    'Business_Process_Step__r.Business_Process_Stage__r.Business_Process__r.business_org__c' => 'businessOrg',
    'Business_Process_Step__r.Business_Process_Stage__r.Business_Process__r.business_brand_name__c' => 'businessBrand',
    'Business_Process_Step__r.Business_Process_Stage__r.Business_Process__r.type__c' => 'processType',
    'Business_Process_Step__r.Business_Process_Stage__r.Business_Process__r.developer_name__c' => 'developerName'
  };

  private static List<String> businessProcessStageFields = new List<String>{
    'Business_Process_Step__r.Business_Process_Stage__r.Buffer_Days__c',
    'Business_Process_Step__r.Business_Process_Stage__r.Business_Days_To_Complete__c',
    'Business_Process_Step__r.Business_Process_Stage__r.Business_Process__c',
    'Business_Process_Step__r.Business_Process_Stage__r.Name',
    'Business_Process_Step__r.Business_Process_Stage__r.Business_Process_Stage_Owner__c',
    'Business_Process_Step__r.Business_Process_Stage__r.Days_Before_Due_Date_For_At_Risk__c',
    'Business_Process_Step__r.Business_Process_Stage__r.Is_Active__c',
    'Business_Process_Step__r.Business_Process_Stage__r.Priority__c',
    'Business_Process_Step__r.Business_Process_Stage__r.Sequence__c',
    'Business_Process_Step__r.Business_Process_Stage__r.Stage_Summary__c',
    'Business_Process_Step__r.Business_Process_Stage__r.Id'
  };

  private static BPLM_Model.BPLM_SchemaModel getSchemaModel(
    List<Business_Process_Step_Task_Mapping__c> schema
  ) {
    BPLM_Model.BPLM_SchemaModel model = new BPLM_Model.BPLM_SchemaModel();
    if (schema == null && schema.size() == 0) {
      throw new BPLM_Model.BPLM_ModelException(BPLM_Model.DATA_ERROR);
    }

    // Arrange business process fields
    Business_Process_Step_Task_Mapping__c mapping = schema.get(0);
    model.businessBrand = mapping.Business_Process_Step__r.Business_Process_Stage__r.Business_Process__r.business_brand_name__c;

    model.businessObject = mapping.Business_Process_Step__r.Business_Process_Stage__r.Business_Process__r.business_sobject_type__c;

    model.businessOrg = mapping.Business_Process_Step__r.Business_Process_Stage__r.Business_Process__r.business_org__c;

    model.developerName = mapping.Business_Process_Step__r.Business_Process_Stage__r.Business_Process__r.developer_name__c;

    model.processName = mapping.Business_Process_Step__r.Business_Process_Stage__r.Business_Process__r.name;

    model.processId = mapping.Business_Process_Step__r.Business_Process_Stage__r.Business_Process__r.id;

    model.isActive = mapping.Business_Process_Step__r.Business_Process_Stage__r.Business_Process__r.is_active__c;

    model.processOwner = mapping.Business_Process_Step__r.Business_Process_Stage__r.Business_Process__r.business_process_owner__c;

    model.processSummary = mapping.Business_Process_Step__r.Business_Process_Stage__r.Business_Process__r.process_summary__c;

    model.processType = mapping.Business_Process_Step__r.Business_Process_Stage__r.Business_Process__r.type__c;

    // Arrange stages
    Map<Id, BPLM_Model.BPLM_StageModel> stagesMap = new Map<Id, BPLM_Model.BPLM_StageModel>();
    for (Business_Process_Step_Task_Mapping__c m : schema) {
        if(stagesMap.get(m.Business_Process_Step__r.Business_Process_Stage__r.Id) == null) {
            BPLM_Model.BPLM_StageModel sm = new BPLM_Model.BPLM_StageModel();
            sm.bufferDays = m.Business_Process_Step__r.Business_Process_Stage__r.Buffer_Days__c;
            sm.businessDaysToComplete = m.Business_Process_Step__r.Business_Process_Stage__r.Business_Days_To_Complete__c;
            sm.businessProcess = m.Business_Process_Step__r.Business_Process_Stage__r.Business_Process__c;
            sm.stageName = m.Business_Process_Step__r.Business_Process_Stage__r.Name;
            sm.stageOwner = m.Business_Process_Step__r.Business_Process_Stage__r.Business_Process_Stage_Owner__c;
            sm.daysBeforeDueDateForAtRisk = m.Business_Process_Step__r.Business_Process_Stage__r.Days_Before_Due_Date_For_At_Risk__c;
            sm.isActive = m.Business_Process_Step__r.Business_Process_Stage__r.Is_Active__c;
            sm.priority = m.Business_Process_Step__r.Business_Process_Stage__r.Priority__c;
            sm.sequence = m.Business_Process_Step__r.Business_Process_Stage__r.Sequence__c;
            sm.stageSummary = m.Business_Process_Step__r.Business_Process_Stage__r.Stage_Summary__c;
            sm.stageId = m.Business_Process_Step__r.Business_Process_Stage__r.Id;
            stagesMap.put(m.Business_Process_Step__r.Business_Process_Stage__r.Id, sm);
        }
    }

    if(!stagesMap.isEmpty())
    {
      List<BPLM_Model.BPLM_StageModel> stages = stagesMap.values();
      stages.sort();
      model.stages.addAll(stages);
    }
    return model;
  }

  public static BPLM_Model.BPLM_SchemaModel getBPLMProcessByName(String name) {
    BPLM_SchemaRepository.BPLM_ISchemaRepository repository = new BPLM_SchemaRepository();
    try {
      List<Business_Process_Step_Task_Mapping__c> schema = repository.getBPLMSchemaByProcessName(
        name
      );
      return getSchemaModel(schema);
    } catch (Exception e) {
      throw new BPLM_Model.BPLM_ModelException(e);
    }
  }
}
