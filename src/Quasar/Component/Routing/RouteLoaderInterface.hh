<?hh //strict
namespace Quasar\Component\Routing;

interface RouteLoaderInterface
{
    public function loadRoutes() : Vector<Route>;
}