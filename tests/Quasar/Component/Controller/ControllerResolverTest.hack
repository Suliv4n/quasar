namespace Quasar\Component\Controller;

use type Facebook\HackTest\HackTest;
use type Quasar\Component\Controller\ControllerResolver;
use type Quasar\Component\DependencyInjection\AutowireProcessor;
use type Quasar\Component\DependencyInjection\ServicesContainer;

use type Quasar\Component\Http\Request;
use type Quasar\Component\Http\ParameterContainer;

use type Mock\Controller\MockController;

use function Facebook\FBExpect\expect;

class ControllerResolverTest extends HackTest
{
    public function testResolve(): void
    {
        /*$container = new ServicesContainer();
        $autowire = new AutowireProcessor($container);
        $controllerResolver = new ControllerResolver($autowire);

        $request = new Request(
            new ParameterContainer(dict[]),
            new ParameterContainer(dict[]),
            new ParameterContainer(dict[]),
            new ParameterContainer(dict[]),
            new ParameterContainer(dict[])
        );

        $request->setControllerCallback(shape(
            'class' => MockController::class,
            'method' => 'getAction'
        ));

        $controller = $controllerResolver->resolveController($request);

        expect($controller)->toBeInstanceOf(MockController::class);*/
    }
}