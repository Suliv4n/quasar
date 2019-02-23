namespace Quasar\Component\DependencyInjection;

class ServiceDescriptor
{
    private Map<int, classname<mixed>> $constructorObjectParameters = Map{}; 
    private Map<int, string> $constructorScalarParameters = Map{};

    public function __construct(
        private classname<mixed> $serviceClass,
        private ?string $id
    )
    {}

    public function autowire(): void
    {
        $this->constructorObjectParameters = Map{};

        $serviceReflection = new \ReflectionClass($this->serviceClass);
        $contructorParameters = $serviceReflection->getConstructor()?->getParameters() ?? varray[];


        foreach ($contructorParameters as $i => $parameter) 
        {
            $parameterClass = $parameter->getClass()->getName();
            $this->constructorObjectParameters[$i] = $parameterClass;
        }
    }

    public function getServiceClass(): classname<mixed>
    {
        return $this->serviceClass;
    }

    public function getId(): ?string
    {
        return $this->id;
    }

    public function getConstructorObjectParameters(): Map<int, classname<mixed>>
    {
        return $this->constructorObjectParameters;
    }
}