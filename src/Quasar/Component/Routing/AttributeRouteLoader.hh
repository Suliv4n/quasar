<?hh //strict
namespace Quasar\Component\Routing;

class AttributeRouteLoader implements RouteLoaderInterface
{

    public function __construct(
        private Vector<string> $classes
    )
    {
    }

    private function loadRoutesFromClass(string $class) : Vector<Route>
    {
        $routes = Vector{};

        $classReflection = new \ReflectionClass($class);
        $methods = $classReflection->getMethods();

        foreach ($methods as $method)
        {
            $route = $method->getAttributeClass(Route::class);

            if ($route !== null)
            {
                $routes[] = $route;
            }
        }

        return $routes;
    }

    public function loadRoutes() : Vector<Route>
    {
        $routes = Vector{};

        foreach ($this->classes as $class) 
        {
            $routes->addAll($this->loadRoutesFromClass($class));
        }

        return $routes;
    }
}