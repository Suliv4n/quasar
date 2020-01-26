namespace Quasar\Component\Controller;

use type Facebook\HackTest\HackTest;
use type Quasar\Component\Controller\ControllerResolver;
use type Quasar\Component\DependencyInjection\AutowireProcessor;
use type Quasar\Component\DependencyInjection\ServicesContainer;
use type Quasar\Component\DependencyInjection\ContainerConfiguration;

use type Quasar\Component\Http\Request;
use type Quasar\Component\Http\ParameterContainer;

use type Mock\Controller\MockController;

use function Facebook\FBExpect\expect;

class ControllerResolverTest extends HackTest
{
    public function testResolve(): void
    {
        $autowire = new AutowireProcessor();
        $containerConfiguration = new ContainerConfiguration();
        $container = new ServicesContainer($containerConfiguration, $autowire);
        
        $controllerResolver = new ControllerResolver(
            $autowire
        );

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

        $controller = $controllerResolver->resolveController($request, $container);

        expect($controller)->toBeInstanceOf(MockController::class);
    }
}