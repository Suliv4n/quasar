<?hh //strict
namespace Quasar\Component\DependencyInjection;

use Mock\Services\{ServiceA, ServiceB};
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
}