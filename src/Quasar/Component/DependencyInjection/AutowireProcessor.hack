namespace Quasar\Component\DependencyInjection;

use HH\Lib\Str;

class AutowireProcessor implements AutowireProcessorInterface
{
    public function __construct(
        private ContainerInterface $container
    )
    {}

    public function process<T>(classname<T> $classname): T
    {
        $reflectionClass = new \ReflectionClass($classname);

        if (! $reflectionClass->isInstantiable())
        {
            throw new \LogicException(Str\format("The class %s is not instanciable.", $classname));
        }

        $constructor = $reflectionClass->getConstructor();
        $constructorParameters = $constructor?->getParameters() ?? vec[];

        $constructorArguments = vec[];
        foreach ($constructorParameters as $parameter) 
        {
            $parameterType = $parameter->getType();

            invariant($parameterType is nonnull, "The parameter type can't be null in hacklang.");
            
            if ($parameterType->isBuiltin())
            {
                $constructorArguments[] = $this->container->getParameter($parameter->getName());
            }
            else
            {
                $constructorArguments[] = $this->container->get($parameter->getTypehintText());
            }
        }

        $instance = $reflectionClass->newInstanceArgs($constructorArguments);

        return $instance;
    }
}