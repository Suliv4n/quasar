namespace Quasar\Component\Routing;

class Router implements RouterInterface
{
    <<__LateInit>>
    private Vector<CompiledRoute> $routes;

    public function __construct(
        private RouteLoaderInterface $routeLoader,
        private UrlMatcherInterface $urlMatcher,
        private RouteCompiler $routeCompiler,
    )
    {}

    public function loadRoutes(): void
    {
        $this->routeLoader->loadRoutes()->map(
            ($route) ==> $this->routeCompiler->compile($route)
        );
    }

    public function route(string $uri, RequestContext $requestContext): ?CompiledRoute
    {
        return $this->urlMatcher->match($this->routes, $uri, $requestContext);
    }
}
