namespace Quasar\Component\DependencyInjection\Compiler;

use type Quasar\Component\DependencyInjection\{
    Argument\UndefinedTypeServiceArgument,
    ContainerInterface,
    ServiceDefinition,
};
use type Quasar\Component\DependencyInjection\Exception\{
    NoServiceFoundForClassException,
};
use type ReflectionMethod;
use type ReflectionParameter;
use type ReflectionClass;

use namespace HH\Lib\C;

use function array_keys;

class AutowirePass extends AbstractRecursiveCompilerPass {

    <<__Override>>
    public function processDefinition(
        ContainerInterface $container,
        ServiceDefinition<mixed> $definition,
    ): void {
        if (!$definition->isAutowired()) {
            return;
        }

        $this->configureServiceArguments($container, $definition);
    }

    private function configureServiceArguments(
        ContainerInterface $container,
        ServiceDefinition<mixed> $definition,
    ): void {
        $arguments = $definition->getArguments();

        $definition->setArguments($arguments);

        $serviceClass = new ReflectionClass($definition->getClassname());
        $constructor = $serviceClass->getConstructor();

        if ($constructor === null) {
            return;
        }

        $parametersToAutowire = $this->filterConstructorParametersToAutowire(
            $constructor,
            array_keys($arguments),
        );

        foreach ($parametersToAutowire as $parameter) {
            $type = $parameter->getType();

            invariant($type !== null, 'In hack parameter type can not be null');

            $serviceId = $this->findServiceAliasByClass(
                $container,
                $parameter->getClass(),
            );

            if (
                $serviceId === null &&
                !$parameter->allowsNull() &&
                !$parameter->isDefaultValueAvailable()
            ) {
                throw new NoServiceFoundForClassException(
                    $definition->getId(),
                    $parameter->getName(),
                    $this->findPotentialSericeAliasesForClass(
                        $container,
                        $serviceClass,
                    ),
                );
            }

            if ($serviceId !== null) {
                $definition->addArgument(
                    $parameter->getName(),
                    new UndefinedTypeServiceArgument($container, $serviceId),
                );
            }
        }
    }

    private function filterConstructorParametersToAutowire(
        ReflectionMethod $constructor,
        varray<string> $argumentsAlreadySet,
    ): varray<ReflectionParameter> {
        $parametersToAutowire = varray<ReflectionParameter>[];

        foreach ($constructor->getParameters() as $parameter) {
            $name = $parameter->getName();
            $type = $parameter->getType();

            invariant($type !== null, 'In hack parameter type can not be null');

            if ($type->isBuiltin() || C\contains($argumentsAlreadySet, $name)) {
                continue;
            }

            $parametersToAutowire[] = $parameter;
        }

        return $parametersToAutowire;
    }

    private function findServiceAliasByClass(
        ContainerInterface $container,
        ReflectionClass $class,
    ): ?string {
        $aliases = $this->findPotentialSericeAliasesForClass(
            $container,
            $class,
        );

        if (C\count($aliases) === 0) {
            return null;
        }

        return $aliases[0];
    }

    private function findPotentialSericeAliasesForClass(
        ContainerInterface $container,
        ReflectionClass $class,
    ): varray<string> {
        $potentialIds = varray<string>[];
        if ($container->has($class->getName())) {
            $potentialIds[] = $class->getName();
        }

        $interfaces = $class->getInterfaceNames();

        foreach ($interfaces as $interface) {
            if ($container->has($interface)) {
                $potentialIds[] = $interface;
            }
        }

        $parentClass = $class->getParentClass();
        while ($parentClass !== false) {
            invariant(
                $parentClass is ReflectionClass,
                'Parent class is a ReflectionClass.',
            );

            if ($container->has($parentClass->getName())) {
                $potentialIds[] = $parentClass->getName();
            }

            $parentClass = $parentClass->getParentClass();
        }

        return $potentialIds;
    }
}
