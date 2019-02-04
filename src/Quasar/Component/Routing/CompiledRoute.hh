<?hh //strict
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
        private Vector<RouteParameter> $parameters
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
    public function getParameters() : Vector<RouteParameter>
    {
        return $this->parameters;
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