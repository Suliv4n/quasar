<?hh //strict
namespace Quasar\Component\Routing;

class AttributeRouteLoader implements RouteLoaderInterface
{

    public function __construct(
        private Vector<string> $folders
    )
    {
    }

    private function getClassesFromFolders() : void
    {
        foreach ($this->folders as $folder)
        {
            \var_dump(\file_exists($folder));
        }
    }

    public function loadRoutes() : Vector<Route>
    {
        $routes = Vector{};

        $this->getClassesFromFolders();

        return $routes;
    }
}