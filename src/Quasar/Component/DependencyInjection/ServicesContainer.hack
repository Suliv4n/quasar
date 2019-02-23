namespace Quasar\Component\DependencyInjection;

use HH\Lib\Str;

class ServicesContainer
{
    private Vector<ServiceDescriptor> $services = Vector{};
    private Map<string, mixed> $loadedInstance = Map{};

    public function __construct(
        private bool $autowiring = true
    )
    {}

    public function set<T>(classname<T> $class, ?string $id = null, ?bool $autowiring = null) : void
    {
        $service = new ServiceDescriptor($class, $id);

        if ($autowiring ?? $this->autowiring)
        {
            $service->autowire();
        }

        $this->services[] = $service;
    }

    /**
     * Return services descriptor which have the id passed in parameter.
     *
     * @param int $id Id of the service descriptors to return.
     */
    private function getServiceDescriptorsById(string $id) : Vector<ServiceDescriptor>
    {
        return $this->services->filter($serviceDescriptor ==> $serviceDescriptor->getId() === $id);
    }

    private function resolved(string $classname, ?string $id = null) : mixed
    {
        $instance = null;

        $services = ($id === null ? $this->services : $this->getServiceDescriptorsById($id));
        
        $reflectionClass = new \ReflectionClass($classname);
        $candidates = Vector{};

        foreach ($services as $service) 
        {
            if (
                $service->getServiceClass() === $classname ||
                $reflectionClass->isSubclassOf($service->getServiceClass())
            )
            {
                $candidates[] = $service;
            }
        }

        if ($candidates->count() > 1)
        {
            throw new \Exception(Str\format("There are multiple services of type %s whith id %s", $classname, $id ?? "no id"));
        }
        else if ($candidates->count() === 0)
        {
            return null;
        }


        $service = $candidates[0];

        $serviceClass = new \ReflectionClass($service->getServiceClass());
        $serviceConstructorParameters = $service->getConstructorObjectParameters();

        $arguments = vec[];
        foreach ($serviceConstructorParameters as $position => $parameter)
        {
            $arguments[] = $this->get($parameter);
        }

        $instance = $serviceClass->newInstanceArgs($arguments);

        return $instance;
    }

    public function get<T>(classname<T> $classname, ?string $id = null) : T
    {
        $instance = $this->resolved($classname);

        if (! ($instance instanceof $classname))
        {
            throw new \Exception(Str\format("No service of class %s was not found in container.", $classname));
        }
    
        return $instance;
    }
}