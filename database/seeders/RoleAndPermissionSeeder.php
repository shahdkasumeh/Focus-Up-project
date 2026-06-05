<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Spatie\Permission\Models\Role;

class RoleAndPermissionSeeder extends Seeder
{
    public function run(): void
    {
        Role::firstOrCreate([
            'name' => 'admin',
            'guard_name' => 'web',
        ]);

        Role::firstOrCreate([
            'name' => 'receptionist',
            'guard_name' => 'web',
        ]);

        Role::firstOrCreate([
            'name' => 'client',
            'guard_name' => 'web',
        ]);
    }
}
