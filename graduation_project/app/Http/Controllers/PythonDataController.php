<?php

namespace App\Http\Controllers;
use Illuminate\Support\Facades\Log;
use Illuminate\Http\Request;


// **** this class to connect between laravel and python "


class PythonDataController extends Controller
{

        public function receiveData(Request $request)
        {
            try {
                $data = $request->input('data');
                Log::info("Data from Python: " . json_encode($data));

                return response()->json([
                    'message' => 'Data received successfully',
                    'data' => $data
                ]);
            } catch (Exception $e) {
                Log::error("Error receiving data: " . $e->getMessage());
                return response()->json([
                    'message' => 'Failed to receive data',
                    'error' => $e->getMessage()
                ]);
            }
        }

}