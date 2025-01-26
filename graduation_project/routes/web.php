<?php

use Illuminate\Support\Facades\Route;

use App\Http\Controllers\BranchesController ;
// we use insted: lesson 34
// use App\Http\Controllers\backend\BranchesController ;
use App\Http\Controllers\HomeController ;


use App\Http\Controllers\EmployeesController ;
use App\Http\Controllers\CompaniesController ;
use App\Http\Controllers\AccessoriesController ;
use App\Http\Controllers\PointsController ;
use App\Http\Controllers\PythonDataController;



// Route::get('/', function () {
//     return view('welcome');
// });

// Route::get('/test', function () {
//     return "view('welcome')";
// });

// Route::get('/haidar', function () {
//     return '<h1>hadiar</h1>';
// });

// // Route::view('/users','users');
// Route::view('/users','users',['name'=>"haidra"]);

// Route::get('/users/{id}',function (string  $id){
//     return 'users' . $id;
// });

// Route::get('/users/{id}/comments/{comment}',function (string  $comment,int $id){
//     return 'users' . $id . 'naem:'. $comment;
// });

// Route::get('/users/{id}/comments/{comment}/fam/{fam?}',function (string  $comment,int $id,string $fam=" wan"){
//     return 'users' . $id . 'naem:'. $comment . 'fam'. $fam;
// });

// Route::get('/ageent,function', function(){
//     return 'users' ;
// })->name('profile');

// Route::get('/id/{id}',function (string  $id){
//     return redirect()->route('profile');
// });

// // method 1
// // Route::get('/admin/user',function (){
// //     return view('admin.users_ad',['name'=>'this is haidar']);
// // });

// // method 2
// Route::view('/admin/user','admin.users_ad',['name'=>"this is haidar"]);

// // يعني اذا اول صفحة مانا موجودة رحلي لتاني صفحة
// Route::get('/post/panel',function (){
//     return View::first(['admin.users_ads','admin.users'],['name'=>'welcome admin']);
// });

// // method 2

// // if(View::exists('eamil.cutomer')){

// // }

// Route::get('/post/more_var',function (){
//     return view('admin.more_one_vari')
//                         ->with('name',"haidar")
//                         ->with('send_tag',"<h1>haidoor </h1>")
//                         ->with('fam',"wannous");

// });



// // ********************************************************************************************

// Route::get('/test', function(){
//     return 'users' ;
// })->name('profile');

// Route::view('/test_blade','test',['name'=>"haidra"]);


// #Route::get('/branch/index',[BranchesController::class ,'index']);
// #Route::get('/branch/show',[BranchesController::class ,'show']);
// #Route::get('/branch/edit',[BranchesController::class ,'edit']);
// #Route::get('/branch/create',[BranchesController::class ,'create']);

// *********************************************************************************************************************


// Route::get('/', [App\Http\Controllers\HomeController::class, 'ragister']);


// Auth::routes(['register'=>True]);

// // after succes login we go to this route directly
// Route::get('/home', [HomeController::class ,'index'])->name('home');

Route::get('/', function () {
    return view('welcome');
});


// Route::get('/admin/branches', [App\Http\Controllers\BranchesController::class, 'index']);

Route::group(['prefix'=>'admin'],function(){

Route::resource('branches', BranchesController::class);
Route::resource('employees', EmployeesController::class);
Route::resource('companies', CompaniesController::class);
Route::resource('accessories', AccessoriesController::class);
Route::resource('points', PointsController::class);


});




// Auth::routes();

// Route::get('/home', [App\Http\Controllers\HomeController::class, 'index'])->name('home');

// Auth::routes();

// Route::get('/home', [App\Http\Controllers\HomeController::class, 'index'])->name('home');

// Auth::routes();

// Route::get('/home', [App\Http\Controllers\HomeController::class, 'index'])->name('home');


// ************************************** for api  *******************

Route::get('/', function () {
    return view('welcome');
});

// In routes/api.php
// Route::post('/data_from_python', [App\Http\Controllers\PythonDataController::class, 'receiveData']);


// Route::group(['prefix'=>'admin'],function(){

// Route::get('/branch/get_all_branches',[BranchesController::class ,'get_all_branches']);
// Route::post('/branch/set_new_branches',[BranchesController::class ,'set_new_branch']);







// });