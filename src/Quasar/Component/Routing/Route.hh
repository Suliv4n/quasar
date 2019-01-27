<?hh //strict
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
     */
    public function __construct(
        private string $pattern,
        private Map<string, string> $requirements = Map{},
    )
    {}

    public function getPattern() : string
    {
        return $this->pattern;
    }

    public function getRequirements() : Map<string, string>
    {
        return $this->requirements;
    }
}