<?hh //strict
namespace Quasar\Component\Routing;

interface UrlMatcherInterface 
{
    public function match(string $path) : ?Route;
}