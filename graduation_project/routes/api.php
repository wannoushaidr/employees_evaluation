<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\BranchesController ;
// use App\Http\Controllers\ApiController ;
use App\Http\Controllers\CompaniesController ;
use App\Http\Controllers\EmployeesController ;
use App\Http\Controllers\AccessoriesController ;
use App\Http\Controllers\UserController ;
use App\Http\Controllers\PointsController ;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\ValidationException;
use App\Http\Controllers\PythonDataController;
use App\Models\User;
use App\Models\Points;
use App\Http\Controllers\NotificationController;
use App\Http\Controllers\NotificationFireBaseController;

use App\Http\Controllers\Api\Auth\PasswordResetController ;

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

// to get user information

//// Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
//     return $request->user();
//// });


Route::post('/sanctum/token',function (Request $request){
    $request->validate([
        'email'=>'required|email',
        'password'=>'required',
        'device_name'=>'required',
    ]);
    $user = User::where('email',$request->email)->first();
    if(!$user || ! \Hash::check($request->password,$user->password)){
        throw ValidationException::withMessages([
        'email'=>["this provider credientel are incorrect"],
        
        ]);
    }
    return $user->createToken($request->device_name)->plainTextToken;
});


// to get token
Route::middleware('auth:sanctum')->get('/user/revoke', function (Request $request) {
    $user = $request->user();
    $user->$tokens()->delete();
    return "token are deleted";
});


// Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
//     try {
//         // Attempt to return the authenticated user's information
//         return $request->user();
//     } catch (\Illuminate\Auth\AuthenticationException $e) {
//         // Return a custom error message if the token is invalid
//         return response()->json(['message' => 'Invalid token provided. Please log in again.'], 401);
//     } catch (Exception $e) {
//         // Log other exceptions and return a generic error message
//         \Log::error('Error fetching user: ' . $e->getMessage());
//         return response()->json(['message' => 'Error fetching user information.'], 500);
//     }
// });

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {  
    try {  
        \Log::info('User Authenticated: ', [$request->user()]);  
        
        return $request->user(); // This should return user data as JSON  
    } catch (\Illuminate\Auth\AuthenticationException $e) {  
        return response()->json(['message' => 'Invalid token provided. Please log in again.'], 401);  
    } catch (Exception $e) {  
        \Log::error('Error fetching user: ' . $e->getMessage());  
        return response()->json(['message' => 'Error fetching user information.'], 500);  
    }  
});

Route::get('/login', function () {
    return view('auth.login'); // Ensure you have a login view or a valid route
})->name('login');



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


// // get('/user', function (Request $request) {
// //     return $request->user();});

// // Route::post('/login', [App\Http\Controllers\Api\Auth\LoginController::class, '__invoke'])->name('login');


// // Route::middleware(['cors'])->group(function(){
// // for branch API 
// Route::get('admin/branches/get_all_branches', [BranchesController::class ,'get_all_branches']);
// Route::post('admin/branches/set_new_branches',[BranchesController::class ,'set_new_branches']);
// Route::put('admin/branches/update_branches',[BranchesController::class ,'update_branches']);
// Route::delete('admin/branches/delete_branches',[BranchesController::class ,'delete_branches']);

// // for company API 
// Route::get('admin/companies/get_all_companies', [CompaniesController::class ,'get_all_companies']);
// Route::post('admin/companies/set_new_companies',[CompaniesController::class ,'set_new_companies']);
// Route::put('admin/companies/update_companies',[CompaniesController::class ,'update_companies']);
// Route::delete('admin/companies/delete_companies',[CompaniesController::class ,'delete_companies']);

// // // for employee API 
// Route::get('admin/employees/get_all_employees', [EmployeesController::class ,'get_all_employees']);
// Route::post('admin/employees/set_new_employees',[EmployeesController::class ,'set_new_employees']);
// Route::put('admin/employees/update_employees',[EmployeesController::class ,'update_employees']);
// Route::delete('admin/employees/delete_employees',[EmployeesController::class ,'delete_employees']);

// // for accesories API 
// Route::get('admin/accesories/get_all_accesories', [AccessoriesController::class ,'get_all_accesories']);
// Route::post('admin/accesories/set_new_accesories',[AccessoriesController::class ,'set_new_accesories']);
// Route::put('admin/accesories/update_accesories',[AccessoriesController::class ,'update_accesories']);
// Route::delete('admin/accesories/delete_accesories',[AccessoriesController::class ,'delete_accesories']);


// // for points API 
// Route::get('admin/points/get_all_points', [PointsController::class ,'get_all_points']);
// Route::post('admin/points/set_new_points',[PointsController::class ,'set_new_points']);
// Route::put('admin/points/update_points',[PointsController::class ,'update_points']);
// Route::delete('admin/points/delete_points',[PointsController::class ,'delete_points']);

// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// /////////



//// Authorization Middleware: 'role' => ['admin', 'manager', 'customer_service', 'supervisor']
// Route::middleware(['auth:sanctum', 'role:customer_service'])->group(function() {
// Route::middleware(['auth:sanctum'])->group(function() {
    // for branch API 
    Route::get('admin/branches/get_all_branches', [BranchesController::class, 'get_all_branches']);
    Route::post('admin/branches/set_new_branches', [BranchesController::class, 'set_new_branches']);
    Route::put('admin/branches/update_branches', [BranchesController::class, 'update_branches']);
    Route::delete('admin/branches/delete_branches', [BranchesController::class, 'delete_branches']);

    // for company API 
    Route::get('admin/companies/get_all_companies', [CompaniesController::class, 'get_all_companies']);
    Route::post('admin/companies/set_new_companies', [CompaniesController::class, 'set_new_companies']);
    Route::put('admin/companies/update_companies', [CompaniesController::class, 'update_companies']);
    Route::delete('admin/companies/delete_companies', [CompaniesController::class, 'delete_companies']);

    // for employee API 
    Route::get('admin/employees/get_all_employees', [EmployeesController::class, 'get_all_employees']);
    Route::post('admin/employees/set_new_employees', [EmployeesController::class, 'set_new_employees']);
    Route::post('admin/employees/update_employees', [EmployeesController::class, 'update_employees']);
    Route::delete('admin/employees/delete_employees', [EmployeesController::class, 'delete_employees']);
    

    // for accessories API 
    Route::get('admin/accesories/get_all_accesories', [AccessoriesController::class, 'get_all_accesories']);
    Route::post('admin/accesories/set_new_accesories', [AccessoriesController::class, 'set_new_accesories']);
    Route::post('admin/accesories/update_accesories', [AccessoriesController::class, 'update_accesories']);
    Route::delete('admin/accesories/delete_accesories', [AccessoriesController::class, 'delete_accesories']);

    // for points API 
    Route::get('admin/points/get_all_points', [PointsController::class, 'get_all_points']);
    Route::post('admin/points/set_new_points', [PointsController::class, 'set_new_points']);
    Route::put('admin/points/update_points', [PointsController::class, 'update_points']);
    Route::delete('admin/points/delete_points', [PointsController::class, 'delete_points']);

    // for admin API
    Route::get('admin/users/get_all_users', [UserController::class, 'get_all_users']);
    Route::post('admin/users/set_new_admins', [UserController::class, 'set_new_admins']);
    Route::put('admin/users/update_admins', [UserController::class, 'update_admins']);
    Route::delete('admin/users/delete_admins', [UserController::class, 'delete_admins']);
    

    // send employee id like a parameter
    Route::get('admin/employees/get_my_information', [EmployeesController::class, 'get_my_information']);
    // get number of employees in my company
    Route::get('admin/employees/get_employees_count', [EmployeesController::class, 'get_employees_count']);
    // get number of employees in my company
    Route::get('admin/branches/get_branches_count', [BranchesController::class, 'get_branches_count']);
    Route::get('admin/users/get_user', [BranchesController::class, 'get_branches_count']);
   

// });


// ********************** customer_service role
// for points API 
//  send employee id like a parameter
Route::get('points/get_employee_points', [PointsController::class, 'get_employee_points']);
// to update active value when customer_service start service new customer
Route::put('/employees/update_customer_service_active', [EmployeesController::class, 'update_customer_service_active']);
// to get customer_service statistic
Route::get('/employee/get_statistic/{id}', [EmployeesController::class, 'get_statistic']);




// **********************   for supervisior and manager role
// send employee id like parameter
Route::get('employees/get_my_employees_information/{id}', [EmployeesController::class, 'get_my_employees_information']);
// send employee id like parameter
Route::get('points/get_my_employee_points', [PointsController::class, 'get_my_employee_points']);

// for supervisior and manager and customer_service role
// send employee id like a parameter
Route::get('employees/get_my_information', [EmployeesController::class, 'get_my_information']);

Route::get('employees/get_my_activativate_employee/{id}', [EmployeesController::class, 'get_my_activativate_employee']);


// ********************** manager role
Route::get('employees/getSupervisorsAndCustomerServiceEmployees/{id}', [EmployeesController::class, 'getSupervisorsAndCustomerServiceEmployees']);

// ********************** supervisior role
Route::get('employees/getCustomerServiceEmployeesCount/{id}', [EmployeesController::class, 'getCustomerServiceEmployeesCount']);


// //////////////////////////////////////////////////////////////

// connect between laravel and python
// Add this to routes/web.php or routes/api.php  
// Route::get('/log-test', function () {  
//     \Log::info('Logging test message');  
//     return 'Logged!';  
// });


// ///****************************    connect betweeen laravel and python            */
// In routes/api.php
Route::post('/data_from_python', [PythonDataController::class, 'receiveData']);


// for notification 
// Route::post('employees/send_notification', [NotificationController::class, 'send']);


Route::get('/config-test', function () {
    return [
        'PUSHER_APP_ID' => env('PUSHER_APP_ID'),
        'PUSHER_APP_KEY' => env('PUSHER_APP_KEY'),
        'PUSHER_APP_SECRET' => env('PUSHER_APP_SECRET'),
        'PUSHER_APP_CLUSTER' => env('PUSHER_APP_CLUSTER'),
    ];
});



Route::post('password/reset', [PasswordResetController::class, 'sendResetLinkEmail'])->name('password.email');  
Route::post('password/reset/complete', [PasswordResetController::class, 'reset'])->name('password.reset');  

Route::post('password/reset', [PasswordResetController::class, 'resetWithOldPassword'])->name('password.reset.old');  



Route::post('employees/send_notification', [NotificationFireBaseController::class, 'sendPushNotification']);
