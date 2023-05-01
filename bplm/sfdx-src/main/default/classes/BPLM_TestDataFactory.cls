public class BPLM_TestDataFactory {

    public static Contact createContact(Boolean isSave)
    {
        Contact c = new Contact(
            FirstName='Test',
            LastName='Contact'
        );
        if(isSave)
        {
            insert c;
        }
        return c;
    }

    public static BusinessBrand createBusinessBrand(Boolean isSave) {
        BusinessBrand bp = new BusinessBrand(name = 'Digital & Business');
        if(isSave)
        {
            Contact c = createContact(isSave);
            bp.Business_Brand_Leader__c = c.Id;
            insert bp;
        }
        return bp;
    }

    public static Business_Process__c createBusinessProcess() {
        return null;
    }
}