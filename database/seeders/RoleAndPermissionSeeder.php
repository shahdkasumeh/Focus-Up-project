<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Spatie\Permission\Models\Permission;
use Spatie\Permission\Models\Role;
use Spatie\Permission\PermissionRegistrar;


class RoleAndPermissionSeeder extends Seeder
{
    public function run(): void
    {
        app()[PermissionRegistrar::class]->forgetCachedPermissions();
        $admin = Role::create([
            'name' => 'admin'
        ]);

        $client = Role::create([
            'name' => 'client'
        ]);

        $receptionist=Role::create([
            'name'=> 'receptionist'
        ]);

        $this->applyCRUDs('table');
        $this->applyCRUDs('room');
        $this->applyCRUDs('Package');
        $this->applyAdminPermissions($admin);
    }
        private function applyCRUDs(string $name){
        $permissions = [];
        $crudList = [
            'index',
            'create',
            'update',
            'show',
            'delete'
        ];

        foreach($crudList as $crud){
            array_push($permissions,$name.'.'.$crud);
        }

        foreach($permissions as $per){
            Permission::create([
                'name' => $per,
                'guard_name'=>'web'
            ]);
        }
    }

        private function applyAdminPermissions(Role $admin){
        $permissions = Permission::all();
        $admin->syncPermissions($permissions);
    }







}


