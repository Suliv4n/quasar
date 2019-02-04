<?hh //strict
namespace Quasar\Component\Routing;


class UrlMatcher implements UrlMatcherInterface
{
    public function match(Vector<CompiledRoute> $routes, string $path, RequestContext $requestContext) : ?CompiledRoute
    {
        $matchedRoute = null;

        $i = 0;
        while ($matchedRoute === null && $i++ < $routes->count())
        {
            $route = $routes[$i];
            $matches = Vector{};
            if (\preg_match($route->getRegex(), $path, &$matches))
            {
                $matchedRoute = $route;
                
                foreach ($matches as $index => $match) 
                {
                    if ($index > 0)
                    {
                        $route->setParameterValue($index - 1, $match);
                    }
                }
            }
        }

        return $matchedRoute;
    }
}