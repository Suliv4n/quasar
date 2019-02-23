namespace Quasar\Component\Routing;

/**
 * Compiled route.
 * The route pattern is a PCRE.
 */
class CompiledRoute
{
    /**
     * Constructor.
     *
     * @param string $regex The route regex.
     * @param Vector<RouteParameter> $parameters The route parameters.
     */
    public function __construct(
        private string $regex,
        private vec<string> $methods,
        private vec<RouteParameter> $parameters
    )
    {}

    /**
     * Return the route regex.
     *
     * @return string The route regex. 
     */
    public function getRegex() : string
    {
        return $this->regex;
    }

    /**
     * Return the route parameters.
     *
     * @return Vector<RouteParameter> The route parameters.
     */
    public function getParameters() : vec<RouteParameter>
    {
        return $this->parameters;
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
     * Set a route parameter value.
     *
     * @param int $index the parameter index.
     * @param string $value The new value of parameter.
     */
    public function setParameterValue(int $index, string $value) : void
    {
        $this->parameters[$index]->setValue($value);
    }
}