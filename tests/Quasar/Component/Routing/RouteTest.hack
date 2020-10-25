namespace Quasar\Component\Routing;

use function Facebook\FBExpect\expect;
use type Facebook\HackTest\HackTest;

class RouteTest extends HackTest
{
    public function testSimpleRoute() : void
    {
        $route = new Route("/quasar", vec["GET", "POST", "DELETE"]);
        expect($route->getPattern())->toBeSame("/quasar");

        expect(\count($route->getAllowedMethods()))->toBeSame(3);
        expect($route->getAllowedMethods())->toContain("GET");
        expect($route->getAllowedMethods())->toContain("POST");
        expect($route->getAllowedMethods())->toContain("DELETE");
    }
}
