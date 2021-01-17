namespace Quasar\Component\DependencyInjection\Test;

use type Quasar\Component\DependencyInjection\{
    ServiceBuilder,
    ServiceDefinition,
    ServiceContainer,
};
use type Quasar\Component\DependencyInjection\Argument\ServiceArgument;
use type Fixture\Services\{ServiceA, ServiceB};
use type Quasar\Component\DependencyInjection\Exception\{
    MissingArgumentException,
    NoServiceFoundException,
    UnknownArgumentException,
};

use type Facebook\HackTest\HackTest;
use function Facebook\FBExpect\expect;

class ContainerTest extends HackTest {

    public function testProvide(): void {
        $container = new ServiceContainer(new ServiceBuilder());

        $container->set(
            'service_a',
            new ServiceDefinition('service_a', ServiceA::class),
        );

        $service = $container->provide<ServiceA>('service_a');

        expect($container->has('service_a'))->toBeTrue();
        expect($service)->assertInstanceOf(ServiceA::class, $service);
    }

    public function testProvideServiceWithArguments(): void {
        $container = new ServiceContainer(new ServiceBuilder());

        $serviceADefinition = new ServiceDefinition(
            'service_a',
            ServiceA::class,
        );
        $serviceBDefinition = new ServiceDefinition(
            'service_b',
            ServiceB::class,
        );
        $serviceBDefinition->setArguments(darray[
            'serviceA' =>
                new ServiceArgument<ServiceA>($container, 'service_a'),
        ]);

        $container->set('service_a', $serviceADefinition);
        $container->set('service_b', $serviceBDefinition);

        $serviceB = $container->provide<ServiceB>('service_b');

        expect($container->has('service_a'))->toBeTrue();
        expect($container->has('service_b'))->toBeTrue();
        expect($serviceB)->assertInstanceOf(ServiceB::class, $serviceB);
    }

    public function testServiceNotFound(): void {
        $container = new ServiceContainer(new ServiceBuilder());

        expect($container->has('not-existing'))->toBeFalse();
        expect(() ==> $container->provide<ServiceA>('not-existing'))->toThrow(
            NoServiceFoundException::class,
        );
    }

    public function testMissingArgument(): void {
        $container = new ServiceContainer(new ServiceBuilder());

        $serviceBDefinition = new ServiceDefinition(
            'service_b',
            ServiceB::class,
        );
        $container->set('service_b', $serviceBDefinition);

        expect(() ==> $container->provide<ServiceB>('service_b'))->toThrow(
            MissingArgumentException::class,
        );
    }

    public function testUnkownArgmuent(): void {
        $container = new ServiceContainer(new ServiceBuilder());

        $serviceADefinition = new ServiceDefinition(
            'service_a',
            ServiceA::class,
        );
        $serviceBDefinition = new ServiceDefinition(
            'service_b',
            ServiceB::class,
        );

        $serviceBDefinition->setArguments(darray[
            'serviceA' =>
                new ServiceArgument<ServiceA>($container, 'service_a'),
            'invalidArg' =>
                new ServiceArgument<ServiceA>($container, 'service_a'),
        ]);

        $container->set('service_a', $serviceADefinition);
        $container->set('service_b', $serviceBDefinition);

        expect(() ==> $container->provide<ServiceB>('service_b'))->toThrow(
            UnknownArgumentException::class,
        );
    }
}
