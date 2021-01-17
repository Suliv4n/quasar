namespace Quasar\Component\DependencyInjection\Compiler\Test;

use type Quasar\Component\DependencyInjection\Compiler\AutowirePass;
use type Quasar\Component\DependencyInjection\{
    ServiceContainer,
    ServiceBuilder,
    ServiceDefinition,
};

use type Fixture\Services\{ServiceA, ServiceB};

use type Facebook\HackTest\HackTest;
use function Facebook\FBExpect\expect;

class AutowirePassTest extends HackTest {
    public function testProcessAutowire(): void {
        $autowirePass = new AutowirePass();
        $serviceBuilder = new ServiceBuilder();
        $container = new ServiceContainer($serviceBuilder);

        $container->set(
            ServiceA::class,
            new ServiceDefinition(ServiceA::class, ServiceA::class),
        );
        $container->set(
            ServiceB::class,
            new ServiceDefinition(ServiceB::class, ServiceB::class),
        );

        $autowirePass->process($container);

        $serviceB = $container->provide<ServiceB>(ServiceB::class);

        expect($serviceB)->toBeInstanceOf(ServiceB::class);
    }
}
