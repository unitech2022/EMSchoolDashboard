class RequestBodyRegister {


  final String userName;
  final String fullName;
  final int stageId;
  final String password;
  final String role ,code;
  final int typeEducationId;
  final int classRoomId;  final int subjectId;

  RequestBodyRegister({required this.subjectId,required this.code,required this.userName, required this.fullName, required this.stageId, required this.password, required this.role, required this.typeEducationId, required this.classRoomId});



}


class RequestBodyRegisterParent {

  final String userName;
  final String fullName;

  final String password;
  final String role ,code;
  final String codeStudent;
  

  RequestBodyRegisterParent({required this.codeStudent,required this.code,required this.userName, required this.fullName,  required this.password, required this.role});



}