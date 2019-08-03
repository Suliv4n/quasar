namespace Quasar\Component\DependencyInjection;

class ServiceDefinition
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

            if ($parameter->getClass() !== null)
            {
                $parameterClass = $parameter->getClass()->getName();
                $this->constructorObjectParameters[$i] = $parameterClass;
            }
            else 
            {
                $this->constructorScalarParameters[$i] = $parameter->getName();
            }

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

    public function getConstructorScalarParameters(): Map<int, string>
    {
        return $this->constructorScalarParameters;
    }

    public function countConstructorParameters(): int
    {
        return 
            $this->constructorObjectParameters->count() + 
            $this->constructorScalarParameters->count();
    }
}