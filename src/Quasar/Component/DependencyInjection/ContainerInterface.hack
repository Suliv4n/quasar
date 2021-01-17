namespace Quasar\Component\DependencyInjection;

interface ContainerInterface
{
    public function set(string $id, ServiceDefinition<mixed> $definition): void;
    public function provide<T>(string $id): T;
    public function has(string $id): bool;
    public function getDefinitions(): darray<string, ServiceDefinition<mixed>>;
}
