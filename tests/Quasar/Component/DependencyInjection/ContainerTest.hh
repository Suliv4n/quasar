<?hh //strict
namespace Quasar\Component\DependencyInjection;

use Mock\Services\ServiceA;
use type Facebook\HackTest\HackTest;
use function Facebook\FBExpect\expect;

class ContainerTest extends HackTest
{
    public function testSingleSimpleService() : void
    {
        $container = new ServicesContainer();
        $container->set(ServiceA::class);
        $service = $container->get(ServiceA::class);

        expect($service)->toBeInstanceOf(ServiceA::class);
    }
}