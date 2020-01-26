namespace Quasar\Component\DependencyInjection;

use type \LogicException;

use namespace HH\Lib\Str;

class AutowireProcessor implements AutowireProcessorInterface
{

    public function process<T>(classname<T> $classname, ContainerInterface $container): vec<mixed>
    {
        $reflectionClass = new \ReflectionClass($classname);

        if (! $reflectionClass->isInstantiable())
        {
            throw new LogicException(Str\format('The class %s is not instanciable.', $classname));
        }

        $constructor = $reflectionClass->getConstructor();
        $constructorParameters = $constructor?->getParameters() ?? vec[];

        $constructorArguments = vec[];
        foreach ($constructorParameters as $parameter) {
            $parameterType = $parameter->getType();

            invariant($parameterType is nonnull, 'The parameter type can\'t be null in hack.');

            if ($parameterType->isBuiltin()) {
                $constructorArguments[] = $container->getParameter($parameter->getName());
            }
            else {
                $constructorArguments[] = $container->get($classname);
            }
        }

        return $constructorArguments;
    }
}
