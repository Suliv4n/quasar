<?hh //strict
namespace Quasar\Component\Routing;

//@todo
class Router
{
    private Vector<Route> $routes = Vector{};

    public function __construct(
        private UrlMatcherInterface $urlMatcher
    )
    {

    }
}