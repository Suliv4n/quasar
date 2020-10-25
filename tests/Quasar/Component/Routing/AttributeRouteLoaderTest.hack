namespace Quasar\Component\Routing;

use type Fixture\Controller\SimpleController;

use function Facebook\FBExpect\expect;
use type Facebook\HackTest\HackTest;

class AttributeRouteLoaderTest extends HackTest
{

    public function testLoad() : void
    {
        $loader = new AttributeRouteLoader(vec[
            SimpleController::class
        ]);

        $routes = $loader->loadRoutes();

        expect($routes->count())->toBeSame(2);
        expect($routes[0]->getPattern())->toBeSame("/route/example/{id}");
        expect($routes[1]->getPattern())->toBeSame("/route/example2/{slug}");

        expect($routes[0]->getControllerCallback())->toNotBeNull();
        $controllerCallback = $routes[0]->getControllerCallback();

        invariant($controllerCallback is nonnull, "Controller callback must be not null");

        expect($controllerCallback["class"])->toBeSame(SimpleController::class);
        expect($controllerCallback["method"])->toBeSame("getAction");
    }

}
