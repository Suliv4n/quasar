namespace Quasar\Component\DependencyInjection;

use Mock\Services\{
    ServiceA, 
    ServiceB, 
    ServiceC,
    AbstractService,
    ConcrateService
};

use type Facebook\HackTest\HackTest;

use function Facebook\FBExpect\expect;

class ContainerTest extends HackTest
{
    public function testSingleSimpleService(): void
    {
        $container = new ServicesContainer();
        $container->set(ServiceA::class);
        $service = $container->get(ServiceA::class);

        expect($service)->toBeInstanceOf(ServiceA::class);
    }

    public function testDependencyInjection(): void
    {
        $container = new ServicesContainer();
        $container->set(ServiceB::class);
        $container->set(ServiceA::class);

        $service = $container->get(ServiceB::class);

        expect($service)->toBeInstanceOf(ServiceB::class);
    }

    public function testParameters(): void
    {
        $container = new ServicesContainer();
        $container->set(ServiceC::class);
        $container->set(ServiceA::class);
        $container->setParameter("scalarParameter", 1337);

        $service = $container->get(ServiceC::class);

        expect($service)->toBeInstanceOf(ServiceC::class);
        expect($service->getParameter())->toBeSame(1337);
    }

    public function testWithAbstractService(): void
    {
        $container = new ServicesContainer();
        $container->set(ConcrateService::class);
        
        $service = $container->get(AbstractService::class);

        expect($service)->toBeInstanceOf(ConcrateService::class);
    }
}