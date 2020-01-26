namespace Quasar\Component\DependencyInjection;

use type Mock\Services\{ServiceA, ServiceB, ServiceC, AbstractService, ConcrateService};

use type Facebook\HackTest\HackTest;
use function Facebook\FBExpect\expect;

class ContainerTest extends HackTest {

    public function testSimpleService(): void {
        $containerConfiguration = new ContainerConfiguration();
        $autowireProcessor = new AutowireProcessor();
        
        $container = new ServicesContainer(
            $containerConfiguration,
            $autowireProcessor
        );

        $container->set<ServiceA>();

        $service = $container->get(ServiceA::class);

        expect($service)->toBeInstanceOf(ServiceA::class);
    }

}