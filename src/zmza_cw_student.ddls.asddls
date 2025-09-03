@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Student Consumption View'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true

@ObjectModel.semanticKey: [ 'Duration' ]

define root view entity ZMZA_CW_STUDENT 
as projection on ZMZA_DD_STUDENT
{
    @EndUserText.label: 'Student ID'
    key Id,
    @EndUserText.label: 'First Name'
    FirstName,
    @EndUserText.label: 'Last Name'
    LastName,
    @EndUserText.label: 'Age'
    Age,
    @EndUserText.label: 'Course'
    Course,
    @EndUserText.label: 'Courseduration'
    CourseDuration,
    
    @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_MZA_VIRT_ELE_CAL'
    @ObjectModel.virtualElement: true
    virtual Duration: abap.int2,
    
    @EndUserText.label: 'Status'
    StudentStatus,
    @EndUserText.label: 'Status Description'
    StatusDescription,
    
    @EndUserText.label: 'Gender'
    Gender,
    @EndUserText.label: 'Date of Birth'
    DateOfBirth,
    @EndUserText.label: 'İmage'    
    zImage, 
    @EndUserText.label: 'Full Name'   
    FullName
}
//Create an root projection / Consumptionview on top of root interface view
//The projection/Consumption view will provide all list of display fields 
//from interface and it’s association.
//The element level annotations can be usedin consumption view and 
//based on operations you can distinguish your projection view
//from interface view.
