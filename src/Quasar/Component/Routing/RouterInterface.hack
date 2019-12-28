namespace Quasar\Component\Routing;

/**
 * Route loader interface.
 */
interface RouterInterface
{
    public function loadRoutes(): void;
    public function route(string $uri, RequestContext $requestContext): ?CompiledRoute;
}
