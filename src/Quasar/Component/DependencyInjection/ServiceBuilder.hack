namespace Quasar\Component\DependencyInjection;

use type Quasar\Component\DependencyInjection\Argument\ArgumentInterface;
use type Quasar\Component\DependencyInjection\Exception\MissingArgumentException;
use type Quasar\Component\DependencyInjection\Exception\UnknownArgumentException;
use type ReflectionClass;
use type ReflectionMethod;
use type ReflectionParameter;

use namespace HH\Lib\C;

class ServiceBuilder implements ServiceBuilderInterface
{
    public function build(ServiceDefinition<mixed> $definition): mixed {
        $arguments = $definition->getArguments();

        $classname = $definition->getClassname();

        $instance = $this->newInstance($definition, $arguments);

        return $instance;
    }

    private function newInstance<T>(
        ServiceDefinition<T> $definition,
        darray<string, ArgumentInterface<mixed>>$arguments
    ): T {
        $classReflection = new ReflectionClass($definition->getClassname());

        $constructor = $classReflection->getConstructor();

        if ($constructor is null) {
            return $classReflection->newInstanceWithoutConstructor();
        }

        $constructorArguments = $this->getConstructorArgumentsValues($definition, $constructor);

        return $classReflection->newInstance(vec[]);
    }

    private function getConstructorArgumentsValues<T>(
        ServiceDefinition<T> $definition,
        ReflectionMethod $constructor
    ): vec<mixed> {
        $argumentsValues = vec[];
        $parametersNames = vec[];

        $arguments = $definition->getArguments();

        foreach ($constructor->getParameters() as $parameter) {
            $parametersNames[] = $parameter->getName();

            $argumentsValues[] = $this->getArgumentValue($arguments, $parameter);
        }

        foreach ($arguments as $name => $_) {
            if (!C\contains($parametersNames, $name)) {
                throw new UnknownArgumentException(
                    $definition->getClassname(),
                    $name
                );
            }
        }

        return $argumentsValues;
    }

    private function getArgumentValue(
        darray<string, ArgumentInterface<mixed>> $arguments,
        ReflectionParameter $parameter
    ): mixed {
            $parameterType = $parameter->getType();
            $parameterName = $parameter->getName();

            invariant($parameterType !== null, 'Parameter type can not be null in hack.');

            if (
                !isset($arguments[$parameterName])
                && $parameterType->allowsNull()
            ) {
                return null;
            }

            if (
                !isset($arguments[$parameterName])
                && $parameter->isDefaultValueAvailable()
            ) {
                return $parameter->getDefaultValue();
            }

            if (!isset($arguments[$parameterName])) {
                throw new MissingArgumentException(
                    $parameter->getDeclaringClass()->getName(),
                    $parameterName
                );
            }

            return $arguments[$parameterName]->getValue();
    }
}