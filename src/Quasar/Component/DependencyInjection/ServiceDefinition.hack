namespace Quasar\Component\DependencyInjection;

use type Quasar\Component\DependencyInjection\Argument\ArgumentInterface;

class ServiceDefinition<T> {
    private darray<string, ArgumentInterface<mixed>> $arguments = darray[];

    public function __construct(
        private string $id,
        private classname<T> $serviceClassname,
        private bool $autowired = true,
    ) {}

    public function setAutowired(bool $autowired): void {
        $this->autowired = $autowired;
    }

    public function isAutowired(): bool {
        return $this->autowired;
    }

    public function setArguments(
        darray<string, ArgumentInterface<mixed>> $arguments,
    ): void {
        $this->arguments = $arguments;
    }

    public function addArgument(
        string $name,
        ArgumentInterface<mixed> $argument,
    ): void {
        $this->arguments[$name] = $argument;
    }

    public function getArguments(): darray<string, ArgumentInterface<mixed>> {
        return $this->arguments;
    }

    public function getClassname(): classname<T> {
        return $this->serviceClassname;
    }

    public function getId(): string {
        return $this->id;
    }
}
