<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class RoleMiddleware
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @param  mixed  ...$roles
     * @return \Illuminate\Http\Response|\Illuminate\Http\RedirectResponse
     */
    public function handle(Request $request, Closure $next, ...$roles)
    {
        $user = Auth::user();

        if ($user && in_array($user->role, $roles)) {
            return $next($request);
        }

        return response()->json(['message' => 'Unauthorized'], 403);
    }

    protected function unauthenticated($request, array $guards)
        {
            return response()->json(['message' => 'Unauthenticated.'], 401);
        }

        protected function redirectTo($request)
        {
            if (!$request->expectsJson()) {
                return null;
            }
        }


}
