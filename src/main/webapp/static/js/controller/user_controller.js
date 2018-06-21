'use strict';

angular.module('myApp').controller('UserController', ['$scope', 'UserService','$location', function($scope, UserService ,$location) {
    var self = this;
    self.userdetail={id:null,fname:'',lname:'',location:'',phone:''};
    self.transactiondetail={id:null,transAmount:'',transDate:'',transDescription:'',transWeight:''};
    self.userdetails=[];
    self.fnames=[];
    self.error;
    $scope.selectuser;
    $scope.errormessage;
    self.submit = submit;
    self.edit = edit;
    self.account = account;
    self.reset = reset;
    fetchAllFName();
    fetchAllUsers();

    function fetchAllUsers(){
        UserService.fetchAllUsers()
            .then(
            function(d) {
                self.userdetails = d;
            },
            function(errResponse){
                console.error('Error while fetching Users');
            }
        );
    }
    
    function fetchAllFName(){
        UserService.fetchAllFname()
            .then(
            function(d) {
                self.fnames = d;
            },
            function(errResponse){
                console.error('Error while fetching Users');
            }
        );
    }

    function createUser(userdetail){
        UserService.createUser(userdetail)
            .then(
            fetchAllUsers,
            function(errResponse){
                console.error('Error while creating User');
                self.error=true;
                $scope.errormessage=errResponse.data.errorMessage;
                console.log($scope.errormessage);
            }
        );
    }

    function updateUser(userdetail, id){
        UserService.updateUser(userdetail, id)
            .then(
            fetchAllUsers,
            function(errResponse){
                console.error('Error while updating User');
            }
        );
    }

    function deleteUser(id){
        UserService.deleteUser(id)
            .then(
            fetchAllUsers,
            function(errResponse){
                console.error('Error while deleting User');
            }
        );
    }

    function submit() {
        if(self.userdetail.id===null){
            console.log('Saving New User', self.userdetail);
            createUser(self.userdetail);
        }else{
            updateUser(self.userdetail, self.userdetail.id);
            console.log('User updated with id ', self.userdetail.id);
        }
        reset();
    }

    function edit(id){
        console.log('id to be edited', id);
        for(var i = 0; i < self.userdetails.length; i++){
            if(self.userdetails[i].id === id) {
                self.userdetail = angular.copy(self.userdetails[i]);
                break;
            }
        }
    }

    function account(id){
        console.log('load account details of user', id);
        UserService.userAccount(id)
        .then(
        function(d) {
        	
        	for(var i = 0; i < self.userdetails.length; i++){
                if(self.userdetails[i].id === id) {
                	$scope.selectuser = angular.copy(self.userdetails[i]);
                    break;
                }
        	}
            self.transactiondetails = d;
            
        },
        function(errResponse){
            console.error('Error while fetching Users');
        }
    );
       
    }


    function reset(){
        self.user={id:null,fname:'',lname:'',location:'',phone:''};
        $scope.myForm.$setPristine(); //reset Form
    }
    $scope.nameList = ["Afghanistan", "Albania", "Algeria", "American Samoa", "Andorra", "Angola", "Anguilla", "Antarctica", "Antigua and Barbuda", "Argentina", "Armenia", "Aruba", "Australia", "Austria", "Azerbaijan", "Bahamas", "Bahrain", "Bangladesh", "Barbados", "Belarus", "Belgium", "Belize", "Benin", "Bermuda", "Bhutan", "Bolivia", "Bosnia and Herzegowina", "Botswana", "Bouvet Island", "Brazil", "British Indian Ocean Territory", "Brunei Darussalam", "Bulgaria", "Burkina Faso", "Burundi", "Cambodia", "Cameroon", "Canada", "Cape Verde", "Cayman Islands", "Central African Republic", "Chad", "Chile", "China"];
    
    $scope.completeName = function(string){  
        $scope.hidethis = false;  
        var output = [];  
        angular.forEach($scope.nameList, function(name){  
             if(name.toLowerCase().indexOf(string.toLowerCase()) >= 0)  
             {  
                  output.push(name);  
             }  
        });  
        $scope.filterName = output;  
   }  
   $scope.fillTextbox = function(string){  
        $scope.name = string;  
        $scope.hidethis = true;  
   }  

   
    
    
   

}]);

