namespace Quasar\Component\Routing;

/**
 * This class represents an application Route.
 */
class Route implements \HH\MethodAttribute
{
    /**
     * Route constructor.
     * 
     * @param string $pattern The route pattern. The route parameters must be in brackets "{parameter}".
     * @param Map<string, string> $requirements A map where keys are route parameter names and values
     * are regex the parameter must match. 
     */
    public function __construct(
        private string $pattern,
        private vec<string> $methods,
        private dict<string, string> $requirements = dict[],
    )
    {}

    /**
     * Return the route pattern.
     * Parameters route are between brakets {}.
     * 
     * @return string The route pattern.
     */
    public function getPattern() : string
    {
        return $this->pattern;
    }

    /**
     * Return the allowed http methods of the route.
     * 
     * @return Vector<string> The allowed http methods of the route. 
     */
    public function getAllowedMethods() : vec<string>
    {
        return $this->methods;
    }

    /**
     * Return the parameters regex requirements.
     * Keys are parameter name (without brackets), value is the regex value.
     *
     * @return Map<string, string> The parameters requirements.
     */
    public function getRequirements() : dict<string, string>
    {
        return $this->requirements;
    }
}