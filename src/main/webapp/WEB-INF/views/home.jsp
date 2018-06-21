<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
  <head>  
    <title>Shop User Manage</title>  
    <style>
      .name.ng-valid {
          background-color: lightgreen;
      }
      .name.ng-dirty.ng-invalid-required {
          background-color: red;
      }
      .name.ng-dirty.ng-invalid-minlength {
          background-color: yellow;
      }

      .phone.ng-valid {
          background-color: lightgreen;
      }
      .phone.ng-dirty.ng-invalid-required {
          background-color: red;
      }
      .phone.ng-dirty.ng-invalid-email {
          background-color: yellow;
      }

    </style>
      <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
     <link href="<c:url value='/static/css/app.css' />" rel="stylesheet"></link>
  </head>
  <body ng-app="myApp" class="ng-cloak">
      <div class="generic-container" ng-controller=CustomerController>
          <div class="panel panel-default">
              <div class="panel-heading"><span class="lead">Customer Registration Form </span>
              <div class="floatRight">
                              <button type="button"  ng-model="addCustomerBtnTxt" ng-click="addCustomer()" class="btn btn-warning btn-sm" >{{addCustomerBtnTxt}}</button>
               </div>
              </div>
              
          </div>
          
          <!-- customer form -->
          <div class="panel panel-default" ng-show="addCustomerVisibility" ng-include="'views/customer.html'">
          </div>
           
           <div class="formcontainer">
            <div class="row">
                          <div class="form-group col-md-12">
                              <label class="col-md-2 control-lable" for="file">Search By First Name</label>
                              <div class="col-md-7">
                                  <input type="text" name="name" id="name" placeholder="Enter first name to filter" ng-model="searchQueryName" ng-keyup="completeList(searchQueryName,'searchQueryName')" class="name form-control input-sm" /> 
 								  <ul class="list-group" ng-model="hidethissearchQueryName" ng-hide="hidethissearchQueryName">  
                          				<li class="list-group-item" ng-repeat="namedata in filterdatasearchQueryName" ng-click="fillTextbox(namedata,'searchQueryName')">{{namedata}}</li>  
                    			 </ul> 	                             
                              </div>
                          </div>
                      </div>
                      
              <div class="row">
                          <div class="form-group col-md-12">
                              <label class="col-md-2 control-lable" for="file">Search By Last Name</label>
                              <div class="col-md-7">
                                  <input type="text" name="name" id="name" placeholder="Enter Last name to filter" ng-model="searchQueryLName" ng-keyup="completeList(searchQueryLName,'searchQueryLName')" class="name form-control input-sm" /> 
 								  <ul class="list-group" ng-model="hidethissearchQueryLName" ng-hide="hidethissearchQueryLName">  
                          				<li class="list-group-item" ng-repeat="lnamedata in filterdatasearchQueryLName" ng-click="fillTextbox(lnamedata,'searchQueryLName')">{{lnamedata}}</li>  
                    			 </ul> 	                             
                              </div>
                          </div>
                      </div>
           </div>
           
          <div class="panel panel-default">
                <!-- Default panel contents -->
              <div class="panel-heading"><span class="lead">List of Users </span></div>
              <div class="tablecontainer">
                  <table class="table table-hover" style="height: 200px;display: block;overflow-y: scroll">
                      <thead>
                          <tr>
                              <th>ID.</th>
                              <th>Name</th>
                              <th>Location</th>
                              <th>Phone</th>
                              <th width="20%"></th>
                          </tr>
                      </thead>
                      <tbody>
                          <tr ng-repeat="customer in customers| filter:{ fname:searchQueryName,lname:searchQueryLName}" ng-click="accountTransaction(customer.id)">
                              <td><span ng-bind="customer.id"></span></td>
                              <td><span ng-bind="customer.fname"></span> <span ng-bind="customer.lname"></span></td>
                              <td><span ng-bind="customer.location"></span></td>
                              <td><span ng-bind="customer.phone"></span></td>
                              <td>
                             <!--  <button type="button"  class="btn btn-success custom-width">Edit</button>  <button  type="button" class="btn btn-danger custom-width" ng-show="customer.transactionAvailable" ng-click="accountTransaction(customer.id)">Account</button> -->
                              </td>
                          </tr>
                      </tbody>
                  </table>
                  
              </div>
              
          </div>
          
          <!-- For account details -->
          <div class="panel panel-default" ng-show="transactionDetailsWindow">
                <!-- Default panel contents -->
              <div class="panel-heading"><span class="lead">Customer Transaction </span></div>
              <div class="tablecontainer" style="padding-right:20px">
              
                <div style="float: left;width: 49%" class="listcontainer">
               
	               <div>
	               <div style="float: left;width: 33%" class="listcontainerheader">Credit Date </div>
	               <div style="float: left;width: 33%" class="listcontainerheader">Details </div>
	               <div style="float:right;width:34%" class="listcontainerheader"> Amount</div>
	               </div>
	               
	                <div ng-repeat="transaction in trsnsactions|filter:{ transMode:'Credit'}">
	              		 <div style="float: left;width: 33%" class="listcontainerdata">{{transaction.transDate}} </div>
	                </div>
              
               </div>
                <div style="float:right;width:49%" class="listcontainer">
                
               <div >
               
				<div style="float: left;width: 33%" class="listcontainerheader">Debit Date </div>
                <div style="float: left;width: 33%" class="listcontainerheader">Details </div>
                <div style="float:right;width:34%" class="listcontainerheader"> Amount</div>
				</div>
               
                <div ng-repeat="transaction in trsnsactions|filter:{ transMode:'Debit'}">
              		 <div style="float: left;width: 33%" class="listcontainerdata">{{transaction.transDate}} </div>
               		 <div style="float: left;width: 33%" class="listcontainerdata"> {{transaction.transDescription}}</div>
               		 <div style="float:right;width:34%" class="listcontainerdata"> {{transaction.transAmount}}	</div>
               </div>
               </div>
               
               </div>
               
                  <table class="table table-hover">
                      <thead>
                          <tr>
                              <th>ID.</th>
                              <th>Date</th>
                              <th>Amount</th>
                              <th>Type</th>
                              <th width="20%"></th>
                          </tr>
                      </thead>
                      <tbody>
                          <tr ng-repeat="transaction in trsnsactions">
                              <td><span ng-bind="transaction.id"></span></td>
                              <td><span ng-bind="transaction.transDate"></span></td>
                              <td><span ng-bind="transaction.transAmount"></span></td>
                              <td><span ng-bind="transaction.transMode"></span>|<span ng-bind="transaction.transMetal"></span>|<span ng-bind="transaction.transDescription"></span></td>
                              <td>
                              </td>
                          </tr>
                      </tbody>
                  </table>
                  
              </div>
              <!-- added -->
              <div class="panel panel-default" ng-show="transactionDetailsWindow">
                <!-- Default panel contents -->
              <div class="panel-heading"><span class="lead">Customer Transaction </span></div>
              <div class="container">
                <div class="row">
              	<div class="col-sm-6 transactionContainer" >
              		<div class="panel-heading"><span class="lead">Debit Transaction </span></div>
              		<div class="row">
              			<div class="col-sm-4" >
              				<div class="panel-heading"><span class="lead">data1 </span></div>
              			</div>
              			<div class="col-sm-4">
              				<div class="panel-heading"><span class="lead">data2 </span></div>
              			</div>
              			<div class="col-sm-4">
              				<div class="panel-heading"><span class="lead">data3 </span></div>
              			</div>
              	
             		</div>
              		
              	</div>
              	<div class="col-sm-6 transactionContainer">
              		<div class="panel-heading"><span class="lead">Credit Transaction </span></div>
              		<div class="row">
              			<div class="col-sm-4" >
              				<div class="panel-heading"><span class="lead">data1 </span></div>
              			</div>
              			<div class="col-sm-4">
              				<div class="panel-heading"><span class="lead">data2 </span></div>
              			</div>
              			<div class="col-sm-4">
              				<div class="panel-heading"><span class="lead">data3 </span></div>
              			</div>
              	
             		</div>
              	</div>
              	</div>
              </div>
              </div>
          
          <!-- added -->
      </div>
      
      <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.4.4/angular.js"></script>
      <script src="<c:url value='/static/js/app.js' />"></script>
      <script src="<c:url value='/static/js/service/user_service.js' />"></script>
      <script src="<c:url value='/static/js/controller/customer-controller.js' />"></script>
  </body>
</html>