<?php

namespace App\Console\Commands;

use App\Http\Controllers\Admin\EtudiantController;
use App\Http\Controllers\Admin\FormationController;
use App\Http\Controllers\Admin\RoleController as AdminRoleController;
use App\Http\Controllers\Admin\UserController as AdminUserController;
use Spatie\Permission\Models\Permission;
use Illuminate\Console\Command;
use Illuminate\Support\Str;
use ReflectionClass;
use ReflectionMethod;

class GenerateResourcePermissions extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'permission:generate';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Generer permissions pour tout les controllers';

    /**
     * Execute the console command.
     */
    public function handle()
    {
        //
        $controllers = [
            AdminRoleController::class,
            AdminUserController::class,
            FormationController::class,
            EtudiantController::class,
        ];

        // Actions de base CRUD (peuvent être étendues)
        $crudActions = ['index', 'create', 'store', 'show', 'edit', 'update', 'destroy'];

        foreach ($controllers as $controller) {
            $reflection = new ReflectionClass($controller);
            $methods = $reflection->getMethods(ReflectionMethod::IS_PUBLIC);

            // Nom du modèle (ex: UserController -> user)
            $modelName = Str::snake(str_replace('Controller', '', class_basename($controller)));

            foreach ($methods as $method) {
                $methodName = $method->getName();

                // On ignore les méthodes spéciales et celles qui ne sont pas des actions CRUD
                if (
                    in_array($methodName, ['__construct']) ||
                    str_starts_with($methodName, '__')
                ) {
                    continue;
                }

                // Si c'est une méthode CRUD standard ou une méthode personnalisée
                if (in_array($methodName, $crudActions) || !in_array($methodName, get_class_methods(\App\Http\Controllers\Controller::class))) {
                    $permissionName = $this->mapActionToPermission($methodName, $modelName);

                    Permission::firstOrCreate([
                        'name' => $permissionName,
                        'guard_name' => 'web',
                    ]);

                    $this->info("Created permission: {$permissionName}");
                }
            }
        }

        $this->info('All controller-based permissions generated successfully!');
    }

    /**
     * Map controller action to permission name
     */
    protected function mapActionToPermission(string $action, string $modelName): string
    {
        $mapping = [
            'index' => 'viewAny',
            'show' => 'view',
            'create' => 'create',
            'store' => 'create',
            'edit' => 'update',
            'update' => 'update',
            'destroy' => 'delete',
        ];

        return ($mapping[$action] ?? $action) . ' ' . $modelName;
    }
}
