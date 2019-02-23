namespace Quasar\Component\Routing;

use Mock\Controller\MockController;

use function Facebook\FBExpect\expect;
use type Facebook\HackTest\HackTest;

class AttributeRouteLoaderTest extends HackTest
{

    public function testLoad() : void
    {
        $loader = new AttributeRouteLoader(vec[
            MockController::class
        ]);

        $routes = $loader->loadRoutes();

        expect($routes->count())->toBeSame(2);
        expect($routes[0]->getPattern())->toBeSame("/route/example/{id}");
        expect($routes[1]->getPattern())->toBeSame("/route/example2/{slug}");
    }
}