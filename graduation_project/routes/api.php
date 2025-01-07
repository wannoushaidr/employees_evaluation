<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\BranchesController ;
use App\Http\Controllers\CompaniesController ;
use App\Http\Controllers\EmployeesController ;
use App\Http\Controllers\AccessoriesController ;
use Illuminate\Validation\ValidationException;

use App\Models\User;



/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

// // to get user information
// Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
//     return $request->user();
// });

// Route::post('/sanctum/token',function (Request $request){
//     $request->validate([
//         'email'=>'required|email',
//         'password'=>'required',
//         'device_name'=>'required',
//     ]);
//     $user = User::where('email',$request->email)->first();
//     if(!$user || ! \Hash::check($request->password,$user->password)){
//         throw ValidationException::withMessages([
//         'email'=>["this provider credientel are incorrect"],
        
//         ]);
//     }
//     return $user->createToken($request->device_name)->plainTextToken;
// });


// // to get token
// Route::middleware('auth:sanctum')->get('/user/revoke', function (Request $request) {
//     $user = $request->user();
//     $user->$tokens()->delete();

//     return "token are deleted";
// });

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    // return $request->user();
    try { return $request->user(); 
    } catch (Exception $e) { 
        \Log::error('Error fetching user: ' . $e->getMessage()); 
        return response()->json(['message' => 'Error fetching user information.'], 500); 
    }
});

Route::post('/sanctum/token', function (Request $request) {
    $request->validate([
        'email' => 'required|email',
        'password' => 'required',
        'device_name' => 'required',
    ]);
    
    $user = User::where('email', $request->email)->first();
    
    if (!$user || !\Hash::check($request->password, $user->password)) {
        throw ValidationException::withMessages([
            'email' => ["The provided credentials are incorrect."],
        ]);
    }
    
    return $user->createToken($request->device_name)->plainTextToken;
});

// To revoke tokens
Route::middleware('auth:sanctum')->get('/user/revoke', function (Request $request) {
    $user = $request->user();
    $user->tokens()->delete();

    return "Tokens are deleted";
});


// ***********************************************************************************************
// ***********************************************************************************************
// ***********************************************************************************************
// ***********************************************************************************************
// ***********************************************************************************************
// ***********************************************************************************************
// ***********************************************************************************************
// ***********************************************************************************************
// ***********************************************************************************************
// ***********************************************************************************************
// ***********************************************************************************************
// ***********************************************************************************************
// ***********************************************************************************************
// ***********************************************************************************************
// ***********************************************************************************************
// ***********************************************************************************************
// ***********************************************************************************************
// ***********************************************************************************************


// get('/user', function (Request $request) {
//     return $request->user();});

Route::post('/login', [App\Http\Controllers\Api\Auth\LoginController::class, '__invoke'])->name('login');


// Route::middleware(['cors'])->group(function(){
// for branch API 
Route::get('admin/branches/get_all_branches', [BranchesController::class ,'get_all_branches']);
Route::post('admin/branches/set_new_branches',[BranchesController::class ,'set_new_branches']);
Route::put('admin/branches/update_branches',[BranchesController::class ,'update_branches']);
Route::delete('admin/branches/delete_branches',[BranchesController::class ,'delete_branches']);

// for company API 
Route::get('admin/companies/get_all_companies', [CompaniesController::class ,'get_all_companies']);
Route::post('admin/companies/set_new_companies',[CompaniesController::class ,'set_new_companies']);
Route::put('admin/companies/update_companies',[CompaniesController::class ,'update_companies']);
Route::delete('admin/companies/delete_companies',[CompaniesController::class ,'delete_companies']);

// // for employee API 
Route::get('admin/employees/get_all_employees', [EmployeesController::class ,'get_all_employees']);
Route::post('admin/employees/set_new_employees',[EmployeesController::class ,'set_new_employees']);
Route::put('admin/employees/update_employees',[EmployeesController::class ,'update_employees']);
Route::delete('admin/employees/delete_employees',[EmployeesController::class ,'delete_employees']);

// for accesories API 
Route::get('admin/accesories/get_all_accesories', [AccessoriesController::class ,'get_all_accesories']);
Route::post('admin/accesories/set_new_accesories',[AccessoriesController::class ,'set_new_accesories']);
Route::put('admin/accesories/update_accesories',[AccessoriesController::class ,'update_accesories']);
Route::delete('admin/accesories/delete_accesories',[AccessoriesController::class ,'delete_accesories']);



// }
// );
