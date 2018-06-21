/**
 * Sourav Nandan
 */
App.controller('CustomerController', ['$scope','$log','$timeout','$parse','UserService', function($scope,$log,$timeout,$parse,UserService) {
	$scope.transactionDetailsWindow=false;
	$scope.addCustomerBtnTxt='Customer +';
	$scope.addCustomerVisibility=false;
	$scope.customer={id:null,fname:'',lname:'',location:'',phone:''};
	var fnameList;
	var lnameList2;
	var locationList;
	fetchAllUsers();
	function fetchAllUsers(){
		UserService.fetchAllUsers()
		   .then(
		   function(customers) {
			   $scope.customers = customers;
			   fetchAllUnicqName();
			   fetchAllUnicqLName();
			   fetchAllUnicqLocatione();
		   },
		   function(errResponse){
		       console.error('Error while fetching Users');
		   }
		);
	}
	
	function fetchAllUnicqName(){
		   UserService.fetchAllFname()
		   .then(
		   function(data) {
			   fnameList = data;		   
		   },
		   function(errResponse){
		       console.error('Error while fetching Names');
		   }
		);
	}
	
	function fetchAllUnicqLName(){
		   UserService.fetchAllLname()
		   .then(
		   function(data) {
			   lnameList2 = data;
			 },
		   function(errResponse){
		       console.error('Error while fetching Names');
		   }
		);
	}
	
	function fetchAllUnicqLocatione(){
		   UserService.fetchAllLocation()
		   .then(
		   function(data) {
			   locationList = data;			   
		   },
		   function(errResponse){
		       console.error('Error while fetching Names');
		   }
		);
	}
   
   $scope.accountTransaction=function(customer){
	   UserService.userAccount(customer)
	   .then(function(transactions){
		   $scope.transactionDetailsWindow=true;
		   $scope.trsnsactions=transactions;
	   });
	   
   };
   $scope.addCustomer=function(){
	   if($scope.addCustomerVisibility){
	   $scope.addCustomerBtnTxt='Customer +';
	   $scope.addCustomerVisibility=false;
	   }
      else{
		   $scope.addCustomerBtnTxt='Customer -';
		   $scope.addCustomerVisibility=true; 
	   }
	   
   }
   
   $scope.registerCustomer=function(customer){
	   if(customer.id===null){
           $log.log('Saving New User', customer);
           createUser(customer);
       }else{
           updateUser(customer, customer.id);
           console.log('User updated with id ', customer);
       }
	   
   };
   
   function createUser(customer){
       UserService.createUser(customer)
           .then(function(){
        	   fetchAllUsers();
        	   $scope.addCustomerBtnTxt='Customer +';
        	   $scope.addCustomerVisibility=false;
           }
           ,
           function(errResponse){
               console.error('Error while creating User');
               showErrorMessage(errResponse.data.errorMessage);
           }
       );
   }
   
   
   
   $scope.completeList = function(string,testbox){  
	   var showList=$parse('hidethis'+testbox);  
	   showList.assign($scope, false);
       var autoCompletelistName='filterdata'+testbox;
       var output = []; 
       var dataList=[];
       switch (testbox) {
       case 'searchQueryName':dataList=fnameList;
         break;
       case 'searchQueryLName':dataList=lnameList2;
    	 break;
       }
       angular.forEach(dataList, function(eachdata){  
            if(eachdata.toLowerCase().indexOf(string.toLowerCase()) >= 0)  
            {  
                 output.push(eachdata);  
            }  
       });  
       $scope[autoCompletelistName] = output;  
  }  
  $scope.fillTextbox = function(string,target){  
	  var showList=$parse('hidethis'+target); 
	   $parse(target).assign($scope, string);
       showList.assign($scope, true);
  }  
  
  function showErrorMessage(message){
	    
	    //reset
	    $scope.showError = false;
	    $scope.doFade = false;
	    
	    $scope.showError = true;
	    
	    $scope.errorMessage = message
	    
	    $timeout(function(){
	      $scope.doFade = true;
	    }, 2500);
	  };
	  
 //$scope.openEditAccount= function(customerId){
	// var modalInstance = $modal.open({
	//	 templateUrl: 'views/account-details.html',
	//	 });
 //}  
	  
    
}]);