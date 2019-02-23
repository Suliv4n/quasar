namespace Quasar\Component\Routing;

/**
 * Load routes from classes methods attribute <<Route>>
 */
class AttributeRouteLoader implements RouteLoaderInterface
{

    /**
     * Constructor.
     *
     * @param Vector<string> $classes Classes where routes will be loaded.
     */
    public function __construct(
        private vec<string> $classes
    )
    {}

    /**
     * Laod routes from a class methods.
     *
     * @param string $class The class name from which routes are loaded.
     *
     * @return Vector<Route> Vector of route loaded. 
     */
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

    /**
     * Load routes.
     *
     * @return Vector<Route> Vector of route loaded.
     */
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