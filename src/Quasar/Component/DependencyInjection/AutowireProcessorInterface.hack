namespace Quasar\Component\DependencyInjection;

interface AutowireProcessorInterface
{
    public function process<T>(classname<T> $classname, ContainerInterface $container): vec<mixed>;
}
