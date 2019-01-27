<?hh //strict
namespace Quasar\Component\Routing;

use function Facebook\FBExpect\expect;
use type Facebook\HackTest\HackTest;

class RouteTest extends HackTest
{
    public function testSimpleRoute() : void
    {
        $route = new Route("/quasar");
        expect($route->getPattern())->toBeSame("/quasar");
    }
}