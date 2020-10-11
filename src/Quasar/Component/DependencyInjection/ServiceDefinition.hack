namespace Quasar\Component\DependencyInjection;

use type Quasar\Component\DependencyInjection\Argument\ArgumentInterface;

class ServiceDefinition<T> {
    private darray<string, ArgumentInterface<mixed>> $arguments = darray[];

    public function __construct(
        private string $id,
        private classname<T> $serviceClassname
    ) {}

    public function setArguments(darray<string, ArgumentInterface<mixed>> $arguments): void {
        $this->arguments = $arguments;
    }

    public function getArguments(): darray<string, ArgumentInterface<mixed>> {
        return $this->arguments;
    }

    public function getClassname(): classname<T> {
        return $this->serviceClassname;
    }
}
