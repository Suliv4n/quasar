<?hh
namespace Quasar\Component\Routing;

/**
 * Route parameter loaded from a route pattern.
 */
class RouteParameter
{

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
}