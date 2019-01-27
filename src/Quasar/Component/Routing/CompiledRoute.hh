<?hh //strict
namespace Quasar\Component\Routing;

class CompiledRoute
{
    public function __construct(
        private string $regex
    )
    {}

    public function getRegex() : string
    {
        return $this->regex;
    }
}