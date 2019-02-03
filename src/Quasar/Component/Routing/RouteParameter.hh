<?hh
namespace Quasar\Component\Routing;

class RouteParameter
{

    public function __construct(
        private string $name
    )
    {}

    public function getName() : string
    {
        return $this->name;
    }
}