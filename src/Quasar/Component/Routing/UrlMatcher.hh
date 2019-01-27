<?hh //strict
namespace Quasar\Component\Routing;

class UrlMatcher implements UrlMatcherInterface
{
    public function __construct(
        private Vector<Route> $routes
    )
    {}

    public function match(string $path) : ?Route
    {
        $routedRoute = null;

        foreach ($this->routes as $route) 
        {
            if ($this->matchRoute($path, $route))
            {
                $routedRoute = $route;
            }
        }
        
        return null;
    }

    private function matchRoute(string $path, Route $route): bool
    {
        $pattern = $route->getPattern();

        return true;
    }

    //@todo plutôt dans Route ? Ou dans une classe à part ?
    private function getPatternRegex(string $pattern) : string
    {
        $matches = Vector{};
        $pattern = \preg_match_all(re"/\{[A-Za-z_]+\}/", $pattern, &$matches);
        
        foreach($matches as $parameter)
        {
            $position = \strpos($parameter, $pattern);
            $pattern = \substr_replace($pattern, $parameter, $position, \strlen($pattern));
        }

        return "";
    }
}