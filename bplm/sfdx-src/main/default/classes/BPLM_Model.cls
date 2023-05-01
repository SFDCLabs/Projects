public class BPLM_Model {
    public static final String DATA_ERROR = 'Invalid data error';
    public class BPLM_SchemaModel {
        public String processName {get; set;}
        public String processId {get; set;}
        public String businessOrg {get;set;}
        public String businessBrand {get;set;}
        public String processOwner {get;set;}
        public String developerName {get;set;}
        public Boolean isActive {get;set;}
        public String processSummary {get;set;}
        public String processType {get;set;}
        public String businessObject {get;set;}
        public List<BPLM_StageModel> stages = new List<BPLM_StageModel>();
    }

    public class BPLM_StageModel implements Comparable {
        public Decimal bufferDays {get;set;}
        public Decimal businessDaysToComplete {get;set;}
        public String businessProcess {get;set;}
        public String stageName {get;set;}
        public String stageOwner {get;set;}
        public Decimal daysBeforeDueDateForAtRisk {get;set;}
        public Boolean isActive {get;set;}
        public String priority {get;set;}
        public Decimal sequence {get;set;}
        public String stageSummary {get;set;}
        public String stageId {get;set;}

        public Integer compareTo(Object objToCompare) {
            BPLM_StageModel obj = (BPLM_StageModel) objToCompare;
            if(sequence == obj.sequence) {
                return 0;
            }
            else if(sequence > obj.sequence) {
                return 1;
            }
            else {
                return -1;
            }
        }
    }

    public class BPLM_ModelException extends Exception {}
}