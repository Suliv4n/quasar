<?hh
namespace Quasar\Component\Routing;

/**
 * Route parameter loaded from a route pattern.
 */
class RouteParameter
{
    <<__LateInit>>
    private string $value;

    /**
     * Constructor.
     *
     * @param string $name The route parameter name.
     */
    public function __construct(
        private string $name
    )
    {}

    /**
     * Return the route parameter name.
     *
     * @param string The route parameter name.
     */
    public function getName() : string
    {
        return $this->name;
    }

    /**
     * Set the value of the route parameter.
     *
     * @param string $value The value of the parameter.
     */
    public function setValue(string $value) : void
    {
        $this->value = $value;
    }

    /**
     * Get the value of the route parameter.
     * The method setValue must be called at least once before.
     *
     * @return string The route parameter value.
     */
    public function getValue() : string
    {
        return $this->value;
    }
}