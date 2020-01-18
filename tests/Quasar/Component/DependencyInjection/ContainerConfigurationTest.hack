namespace Quasar\Component\DependencyInjection;
use type Mock\Services\{ServiceA, ServiceB, ServiceC, AbstractService, ConcrateService};

use type Facebook\HackTest\HackTest;
use function Facebook\FBExpect\expect;

class ContainerConfigurationTest extends HackTest
{
    public function testAddAndGetServiceDifinition(): void {
        $configuration = new ContainerConfiguration();

        $configuration
            ->addServiceDefinition(
                new ServiceDefinition(ServiceA::class)
            )
            ->addServiceDefinition(
                new ServiceDefinition(ConcrateService::class)
            );

        $serviceADefinition = $configuration->getServiceDefinition<ServiceA>();
        $abstractServiceDefinition = $configuration->getServiceDefinition<AbstractService>();

        expect($serviceADefinition->getServiceClass())
            ->toBeSame(ServiceA::class);

        expect($abstractServiceDefinition->getServiceClass())
            ->toBeSame(ConcrateService::class);
    }

    public function testGetNonExistingServiceDefinition(): void {
        $configuration = new ContainerConfiguration();

        expect(() ==> $configuration->getServiceDefinition<ServiceA>())->toThrow(\LogicException::class);
    }
}