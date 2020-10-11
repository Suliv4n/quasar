namespace Quasar\Component\DependencyInjection;

interface ServiceBuilderInterface
{
    public function build(ServiceDefinition<mixed> $definition): mixed;
}