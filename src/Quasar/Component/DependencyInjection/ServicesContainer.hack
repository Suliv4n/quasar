namespace Quasar\Component\DependencyInjection;

use type \ReflectionClass;

use namespace HH\Lib\Str;
use namespace HH\Lib\Vec;

type ServiceData = shape(
    'classname' => classname<mixed>,
    'id' => ?string,
    'serviceDefinition' => ServiceDefinition<nonnull>,
    'instance' => mixed
);

/**
 * Depency injection container.
 */
class ServicesContainer implements ContainerInterface
{

    private dict<string, mixed> $parameters = dict[];
    private vec<ServiceData> $services = vec[];

    /**
     * Constructor.
     * 
     * @param ContainerConfiguration $configuration The container configuration.
     * @param AutowireProcessorInterface Autowire processor for service autowiring.
     */
    public function __construct(
        private ContainerConfiguration $configuration,
        private AutowireProcessorInterface $autowireProcessor
    ) {
    }

    /**
     * Get a service instance by its type and id.
     * 
     * @param ?string $id The service id or null if no need id.
     * 
     * @return T The service instance.
     */
    public function get<T>(
        classname<T> $classname,
        ?string $id = null
    ): T {
        $serviceData = $this->getServiceData($classname, $id);

        $instance = $serviceData['instance'];
        $serviceDefinition = $serviceData['serviceDefinition'];

        // If instance is already loaded return it.
        if (\is_a($instance, $classname, true)) {
            /**
             * Return type is valid as $instance is a $classname here.
             */
            /* HH_FIXME[4110] Invalid return type */
            return $instance;
        }

        $constructorArguments = vec[];
        if ($serviceDefinition->isAutowired()) {
            $constructorArguments = $this->autowireProcessor
                ->process($serviceDefinition->getServiceClass(), $this);
        }

        $instance = $this->buildInstanceFromServiceDefinition<T>(
            $classname,
            $serviceDefinition,
            $constructorArguments
        );

        $serviceData['instance'] = $instance;

        return $instance;
    }

    public function set<<<__Enforceable>> reify T as nonnull>(
        ?string $id = null
    ): void {
        $serviceDefinition = new ServiceDefinition<T>(
                T::class,
                $id
            );

        $this->services[] = shape(
            'classname' => T::class,
            'id' => $id,
            'instance' => null,
            'serviceDefinition' => $serviceDefinition
        );

        $this->configuration->addServiceDefinition($serviceDefinition);
    }

    /**
     * Build a service instance from its definition.
     * 
     * @param ServiceDefinition<T> The service definition.
     * 
     * @return T The service instance.
     */
    private function buildInstanceFromServiceDefinition<T>(
        classname<T> $classname,
        ServiceDefinition<mixed> $serviceDefinition,
        vec<mixed> $constructorArguments
    ): T {
        $classReflection = new ReflectionClass($serviceDefinition->getServiceClass());
        
        $constructor = $classReflection->getConstructor();
        
        if ($constructor === null) {
            return $classReflection->newInstanceWithoutConstructor();
        }

        $constructorParameters = $constructor->getParameters();

        // Rewrite constructor arguments if service definition defined them.
        foreach ($constructorParameters as $index => $parameter) {
            if ($index >= \count($constructorArguments)) {
                $constructorArguments[] = null;
            }

            $serviceArgument = $serviceDefinition->getServiceArgument(
                $parameter->getName()
            );

            $scalarArgument = $serviceDefinition->getScalarArgument(
                $parameter->getName()
            );

            if ($serviceArgument !== null) {
                $classname = $serviceArgument['classname'];
                $id = $serviceArgument['id'];

                $constructorArguments[$index] = $this->get($classname, $id);
            } else if ($scalarArgument !== null) {
                $constructorArguments[$index] = $scalarArgument;
            }
        }

        return $classReflection->newInstanceArgs($constructorArguments);
    }

    public function getServiceData<T>(
        classname<T> $classname,
        ?string $id
    ): ServiceData {
        foreach ($this->services as $serviceData) {
            if (
                \is_a($serviceData['classname'], $classname, true)
                && $serviceData['id'] === $id
            ) {
                return $serviceData;
            }
        }

        throw new \LogicException(
            Str\format(
                'No service of class %s was found with %s.',
                $classname,
                $id === null ? 'no id' : 'id "' . $id . '"'
        ));
    }

    /**
     * Get a parameter value or null if it not exists.
     * 
     * @param string $name The parameter name.
     * 
     * @return mixed The parameter value.
     */
    public function getParameter(string $name): mixed
    {
        return $this->parameters[$name] ?? null;
    }

    /**
     * Set a parameter given by its name.
     * 
     * @param string $name The parameter name.
     * @param mixed $value The parameter value.
     */
    public function setParameter(string $name, mixed $value): void
    {
        $this->parameters[$name] = $value;
    }
}