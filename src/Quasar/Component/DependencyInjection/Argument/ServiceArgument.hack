namespace Quasar\Component\DependencyInjection\Argument;

use type Quasar\Component\DependencyInjection\ContainerInterface;

class ServiceArgument<<<__Enforceable>> reify T> implements ArgumentInterface<T> {
    public function __construct(
        private ContainerInterface $container,
        private string $serviceId
    ) {}

    public function getValue(): T {
        return $this->container
            ->provide<T>($this->serviceId);
    }
}