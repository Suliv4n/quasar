<?hh //strict
namespace Quasar\Component\Routing;


class Router
{
    public function __construct(
        private RouteLoaderInterface $routeLoader,
        private UrlMatcherInterface $urlMatcher,
    )
    {}
}