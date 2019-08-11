namespace Quasar\Component\DependencyInjection;

use Mock\Services\{ServiceA, ServiceB, ServiceC, AbstractService};

use type Facebook\HackTest\HackTest;

use function Facebook\FBExpect\expect;

class AutowireProcessorTest extends HackTest
{
    public function testSimpleClassAutowire(): void
    {
        $container = new ServicesContainer();
        $autowire = new AutowireProcessor($container);

        $instance = $autowire->process(ServiceA::class);

        expect($instance)->toBeInstanceOf(ServiceA::class);
    }

    public function testAutowireDependencies(): void
    {
        $container = new ServicesContainer();
        $container->set(ServiceB::class);
        $container->set(ServiceA::class);

        $autowire = new AutowireProcessor($container);

        $instance = $autowire->process(ServiceB::class);

        expect($instance)->toBeInstanceOf(ServiceB::class);
    }


    public function testAutowireParameters(): void
    {
        $container = new ServicesContainer();
        $container->set(ServiceC::class);
        $container->set(ServiceA::class);
        $container->setParameter("scalarParameter", 1337);

        $autowire = new AutowireProcessor($container);
        $instance = $autowire->process(ServiceC::class);
        

        expect($instance)->toBeInstanceOf(ServiceC::class);
        expect($instance->getParameter())->toBeSame(1337);
    }

    public function testNotInstaciableAutowireError(): void
    {
        $container = new ServicesContainer();
        $autowire = new AutowireProcessor($container);
        
        expect(() ==> $autowire->process(AbstractService::class))->toThrow(\LogicException::class);
    }

}