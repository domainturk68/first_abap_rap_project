@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Student Interface View'
@Metadata.ignorePropagatedAnnotations: true
@AbapCatalog.viewEnhancementCategory: [#NONE]
@ObjectModel.usageType: {
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
define root view entity ZMZA_DD_STUDENT
  as select from zmza_student 
  association[1..1] to ZMZA_DD_STUDENTSTATUS as _StudentStatus 
    on $projection.StudentStatus = _StudentStatus.Value 
{
  key id                                          as Id,
      firstname                                   as FirstName,
      lastname                                    as LastName,
      age                                         as Age,
      course                                      as Course,
      courseduration                              as CourseDuration,
      studentstatus                               as StudentStatus,
      gender                                      as Gender,
      dob                                         as DateOfBirth,

      @Semantics.imageUrl: true
      zimage                                      as zImage,

      CONCAT_WITH_SPACE( firstname, lastname, 1 ) as FullName,
      
      _StudentStatus,
      _StudentStatus.Description    as StatusDescription,
      
      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZMZA_DD_DD07T_CUST_TYPE', element: 'Domvalue' } }]
      statusf4 as StatusF4
}

//Create a custom table
//The custom table key should be auto incremented anddynamically generated.
//Key field are always not nullto keep the table with consistent records .
//Create an root interface entity viewon top of custom table
//The interface view is basic view which is later usedin EML statements
//to handle CRUD operations, allassociation,
//composition and calculation operationperformed at interface entity view.
