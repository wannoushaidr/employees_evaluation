<?php

namespace App\Http\Requests;
// use Illuminate\Http\Request;

use App\Models\User;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;


class LoginRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        return [
            'email'=>['required','email','max:255',Rule::exists(User::class,'email')],
            'password'=>'required|string|min:8'
            //
        ];
    }
}
