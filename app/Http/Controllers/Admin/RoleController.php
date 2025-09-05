<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Inertia\Inertia;
use Spatie\Permission\Models\Role;
use Spatie\Permission\Models\Permission;
use Illuminate\Http\Request;
use Illuminate\Foundation\Auth\Access\AuthorizesRequests;

class RoleController extends Controller
{
    use AuthorizesRequests;

    /**
     * Display a listing of the resource.
     */
    public function index(Request $request)
    {
        $perPage = $request->get('per_page', 10);

        $roles = Role::with('permissions')
            ->orderBy('created_at', 'desc')
            ->paginate($perPage)
            ->withQueryString();

        return Inertia::render('dashboard/Role/Index', [
            'roles' => $roles,
            'permissions' => Permission::count()
        ]);
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        $permissions = Permission::all()->map(function ($permission) {
            return [
                'id' => $permission->id,
                'name' => $permission->name,
                'module' => explode('.', $permission->name)[0] ?? 'autres',
            ];
        });

        return Inertia::render('dashboard/Role/Create', [
            'permissions' => $permissions,
        ]);
    }



    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $validated = $request->validate([
            'name' => 'required|string|unique:roles,name',
            'permissions' => 'array',
        ]);

        $role = Role::create(['name' => $validated['name']]);

        if (!empty($validated['permissions'])) {
            $role->syncPermissions($validated['permissions']);
        }

        return redirect()->route('role.index')->with('success', 'Rôle créé avec succès');
    }

    public function show(Role $role)
    {
        $role->load('permissions');

        // Permissions avec module
        $permissions = $role->permissions->map(function ($permission) {
            return [
                'id' => $permission->id,
                'name' => $permission->name,
                'module' => $permission->module ?? 'autres',
            ];
        });

        return Inertia::render('dashboard/Role/Show', [
            'role' => [
                'id' => $role->id,
                'name' => $role->name,
                'permissions' => $permissions,
            ],
        ]);
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(Role $role)
    {
        $role->load('permissions');

        $permissions = Permission::all()->map(function ($permission) {
            return [
                'id' => $permission->id,
                'name' => $permission->name,
                'module' => $permission->module ?? 'autres',
            ];
        });

        return Inertia::render('dashboard/Role/Edit', [
            'role' => [
                'id' => $role->id,
                'name' => $role->name,
                'permissions' => $role->permissions->pluck('id'), // juste les IDs
            ],
            'permissions' => $permissions, // maintenant c'est un tableau plat
        ]);
    }



    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Role $role)
    {
        $validated = $request->validate([
            'name' => 'required|string|unique:roles,name,' . $role->id,
            'permissions' => 'array',
        ]);

        $role->update(['name' => $validated['name']]);
        $role->syncPermissions($validated['permissions'] ?? []);

        return redirect()->route('role.index')->with('success', 'Rôle mis à jour');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Role $role)
    {
        $this->authorize('delete role');

        if (in_array($role->name, ['admin'])) {
            return redirect()->back()->with('error', 'Ce rôle système ne peut être supprimé');
        }

        $role->delete();

        return redirect()->back()->with('success', 'Rôle supprimé avec succès');
    }
}
