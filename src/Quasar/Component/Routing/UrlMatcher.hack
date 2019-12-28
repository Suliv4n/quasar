namespace Quasar\Component\Routing;

use namespace HH\Lib\Str;

class UrlMatcher implements UrlMatcherInterface
{
    public function match(Vector<CompiledRoute> $routes, string $path, RequestContext $requestContext) : ?CompiledRoute
    {
        $matchedRoute = null;

        $i = 0;
        while ($matchedRoute === null && $i < $routes->count())
        {
            $route = $routes[$i];
            $matches = Vector{};
            if (
                \preg_match_with_matches($route->getRegex(), $path, inout $matches) &&
                $this->testMethod($route->getAllowedMethods(), $requestContext->getMethod())
            )
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

            $i++;
        }

        return $matchedRoute;
    }

    private function testMethod(vec<string> $allowedMethods, string $requestMethod) : bool
    {
        $allowedMethods = new Vector($allowedMethods);
        $allowedMethods = $allowedMethods->map(($method) ==> Str\uppercase($method));
        return $allowedMethods->linearSearch($requestMethod) > -1;
    }
}
