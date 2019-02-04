<?hh //strict
namespace Quasar\Component\Routing;

/**
 * Url matcher interface.
 */
interface UrlMatcherInterface 
{
    /**
     * Return a route matches the uri.
     * If no routes match the uri, return null.
     *
     * @param Vector<CompiledRoute> $routes Vector of routes to test.
     * @param string $uri The uri to test.
     * @param RequestContext The http request context. 
     *
     * @return ?CompiledRoute A route matches the uri, or null if no route match the uri.
     */
    public function match(Vector<CompiledRoute> $routes, string $uri, RequestContext $requestContext) : ?CompiledRoute;
}