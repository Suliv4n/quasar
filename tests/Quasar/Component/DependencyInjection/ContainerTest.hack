namespace Quasar\Component\DependencyInjection\Test;

use type Quasar\Component\DependencyInjection\ServicesContainer;
use type Quasar\Component\DependencyInjection\ServiceBuilder;
use type Quasar\Component\DependencyInjection\ServiceDefinition;
use type Fixture\Services\{ServiceA, ServiceB, ServiceC, AbstractService, ConcrateService};

use type Facebook\HackTest\HackTest;
use function Facebook\FBExpect\expect;

class ContainerTest extends HackTest {
    public function testProvide(): void {
        $container = new ServicesContainer(
            new ServiceBuilder()
        );

        $container->set('service_a', new ServiceDefinition('service_a', ServiceA::class));

        $service = $container->provide<ServiceA>('service_a');

        expect($service)->assertInstanceOf(
            ServiceA::class,
            $service
        );
    }
}