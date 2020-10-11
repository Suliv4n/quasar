namespace Quasar\Component\DependencyInjection;

use type Quasar\Component\DependencyInjection\Exception\NoServiceFoundException;
use type LogicException;

use function get_class;

use namespace HH\Lib\Str;

class ServicesContainer implements ContainerInterface
{
    private darray<string, ServiceDefinition<mixed>> $definitions = darray[];

    public function __construct(
        private ServiceBuilderInterface $serviceBuilder
    ) {}

    public function provide<<<__Enforceable>> reify T>(string $id): T {
        if (!$this->has($id)) {
            throw new NoServiceFoundException($id);
        }

        $definition = $this->definitions[$id];

        $service = $this->serviceBuilder->build($definition);

        if (!($service is T)) {
            throw new LogicException(
                Str\format(
                    'Service with id %s is definied to be an instance of %s.
                    Maybe you should fix the generic type of "provide" method call.',
                    $id,
                    $definition->getClassname()
                )
            );
        }

        return $service;
    }

    public function set(string $id, ServiceDefinition<mixed> $definition): void {
        $this->definitions[$id] = $definition;
    }

    public function has(string $id): bool {
        return isset($this->definitions[$id]);
    }
}