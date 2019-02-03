<?hh //strict
namespace Quasar\Component\Routing;

class CompiledRoute
{
    public function __construct(
        private string $regex,
        private Vector<RouteParameter> $parameters
    )
    {}

    public function getRegex() : string
    {
        return $this->regex;
    }

    public function getParameters() : Vector<RouteParameter>
    {
        return $this->parameters;
    }
}