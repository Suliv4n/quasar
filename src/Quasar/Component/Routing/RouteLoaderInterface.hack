namespace Quasar\Component\Routing;

/**
 * Route loader interface.
 */
interface RouteLoaderInterface
{
    /**
     * Load routes.
     *
     * @return  Vector<Route> Vector of loaded routes.
     */
    public function loadRoutes() : Vector<Route>;
}