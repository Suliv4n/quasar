namespace Quasar\Component\DependencyInjection;

interface ContainerInterface
{
    public function get<T>(classname<T> $classname, ?string $id = null): T;
    public function set<T>(classname<T> $class, ?string $id = null, ?bool $autowiring = null): void;

    public function getParameter(string $name): mixed;
    public function setParameter(string $name, mixed $value): void;
}
