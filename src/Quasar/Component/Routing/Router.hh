<?hh //strict
namespace Quasar\Component\Routing;

class Router
{
    private Vector<Route> $routes = Vector{};

    public function __construct(
        private UrlMatcherInterface $urlMatcher
    )
    {

    }
}