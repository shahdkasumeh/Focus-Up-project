<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Spatie\Permission\Models\Permission;
use Spatie\Permission\Models\Role;
use Spatie\Permission\PermissionRegistrar;


class RolesAndPermissionsSeeder extends Seeder
{
    public function run(): void
    {
        app()[PermissionRegistrar::class]->forgetCachedPermissions();
        $admin = Role::create([
            'name' => 'admin'
        ]);

        $student = Role::create([
            'name' => 'student'
        ]);

        $receptionist = Role::create([
            'name' => 'receptionist'
        ]);

        $this->applyCRUDS('table');
        $this->applyCRUDS('room');
        $this->applyAdminPermissions($admin);
        // $this->applyStudentPermissions($student);
    }
    private function applyCRUDs(string $name)
    {
        $permissions = [];
        $crudList = [
            'index',
            'create',
            'update',
            'show',
            'delete'
        ];

        foreach ($crudList as $crud) {
            array_push($permissions, $name . '.' . $crud);
        }

        foreach ($permissions as $per) {
            Permission::create([
                'name' => $per,
                'guard_name' => 'web'
            ]);
        }
    }

    private function applyAdminPermissions(Role $admin)
    {
        $permissions = Permission::all();
        $admin->syncPermissions($permissions);
    }







}
