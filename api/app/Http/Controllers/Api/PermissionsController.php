<?php

namespace App\Http\Controllers\Api;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Spatie\Permission\Models\Permission;
use App\Models\Admin;

class PermissionsController extends Controller
{
    public function allPermissions()
    {
        return Permission::all();
    }

    public function givePermissionToUser(Request $request)
    {
        $this->validate($request, [
            "user_id" => "required|exists:admins,id",
            "permission_id" => "required|exists:permissions,id"
        ]);

        $user = Admin::find($request->user_id);
        $user->givePermissionTo(Permission::find($request->permission_id)->name);
        return response()->json($user);
    }

    public function removePermissionToUser(Request $request)
    {
        $this->validate($request, [
            "user_id" => "required|exists:admins,id",
            "permission_id" => "required|exists:permissions,id"
        ]);

        $user = Admin::find($request->user_id);
        $user->revokePermissionTo(Permission::find($request->permission_id)->name);
        return response()->json($user);
    }

    public function syncPermissionsToUser(Request $request)
    {
        $this->validate($request, [
            "user_id" => "required|exists:admins,id",
            "permissions" => "required|array"
        ]);

        $user = Admin::find($request->user_id);
        $user->syncPermissions($request->permissions);
        return response()->json($user);
    }
}
