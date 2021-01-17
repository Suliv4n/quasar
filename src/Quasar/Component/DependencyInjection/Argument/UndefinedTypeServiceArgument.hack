namespace Quasar\Component\DependencyInjection\Argument;

use type Quasar\Component\DependencyInjection\ContainerInterface;

class UndefinedTypeServiceArgument implements ArgumentInterface<mixed> {
    public function __construct(
        private ContainerInterface $container,
        private string $serviceId
    ) {}

    public function getValue(): mixed {
        return $this->container
            ->provide<mixed>($this->serviceId);
    }
}
