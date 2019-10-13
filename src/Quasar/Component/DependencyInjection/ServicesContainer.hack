namespace Quasar\Component\DependencyInjection;

use HH\Lib\Str;
use HH\Lib\C;
use HH\Lib\Vec;

class ServicesContainer implements ContainerInterface
{
    private Vector<ServiceDefinition> $services = Vector{};
    private Map<string, mixed> $loadedInstance = Map{};
    private Map<string, mixed> $parameters = Map{};

    public function __construct(
        private bool $autowiring = true
    )
    {}

    public function set<T>(classname<T> $class, ?string $id = null, ?bool $autowiring = null): void
    {
        $service = new ServiceDefinition($class, $id);

        if ($autowiring ?? $this->autowiring)
        {
            $service->autowire();
        }

        $this->services[] = $service;
    }


    public function get<T>(classname<T> $classname, ?string $id = null): T
    {
        $instance = $this->resolved($classname);

        if ($instance is null)
        {
            throw new \Exception(Str\format("No service implementing %s was found in container.", $classname));
        }
    
        return $instance;
    }

    public function getParameter(string $name): mixed
    {
        if (!C\contains_key($this->parameters, $name))
        {
            throw new \Exception("Parameter '%s' not found.");
        }

        return $this->parameters[$name];
    }

    public function setParameter(string $name, mixed $value): void
    {
        $this->parameters[$name] = $value;
    }


    /**
     * Return services descriptor which have the id passed in parameter.
     *
     * @param int $id Id of the service descriptors to return.
     */
    private function getServiceDefinitionsById(string $id) : Vector<ServiceDefinition>
    {
        return $this->services->filter($ServiceDefinition ==> $ServiceDefinition->getId() === $id);
    }

    private function resolved<T>(classname<T> $classname, ?string $id = null) : ?T
    {
        $instance = null;

        $services = ($id === null ? $this->services : $this->getServiceDefinitionsById($id));
        
        $reflectionClass = new \ReflectionClass($classname);
        $candidates = Vector{};

        foreach ($services as $service) 
        {
            if (
                $service->getServiceClass() === $classname ||
                \is_a($service->getServiceClass(), $classname, true)
            )
            {
                $candidates[] = $service;
            }
        }

        if ($candidates->count() > 1)
        {
            throw new \LogicException(Str\format('There are multiple services of type %s whith id %s', $classname, $id ?? 'no id'));
        }
        else if ($candidates->count() === 0)
        {
            return null;
        }


        $service = $candidates[0];

        $serviceClass = new \ReflectionClass($service->getServiceClass());
        $arguments = Vec\fill<mixed>($service->countConstructorParameters(), null);

        $serviceConstructorParameters = $service->getConstructorObjectParameters();
        foreach ($serviceConstructorParameters as $position => $parameter)
        {
            $arguments[$position] = $this->get($parameter);
        }

        $serviceConstructorParameters = $service->getConstructorScalarParameters();
        foreach ($serviceConstructorParameters as $position => $parameter)
        {
            $arguments[$position] = $this->getParameter($parameter);
        }

        $instance = $serviceClass->newInstanceArgs($arguments);

        return $instance;
    }
}