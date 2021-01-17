namespace Quasar\Component\DependencyInjection\Compiler;

use type Quasar\Component\DependencyInjection\{
    ContainerInterface,
    ServiceDefinition,
};

abstract class AbstractRecursiveCompilerPass implements CompilerPassInterface {
    public function process(ContainerInterface $container): void {
        foreach ($container->getDefinitions() as $definition) {
            $this->processDefinition($container, $definition);
        }
    }

    abstract protected function processDefinition(
        ContainerInterface $container,
        ServiceDefinition<mixed> $definition,
    ): void;
}
