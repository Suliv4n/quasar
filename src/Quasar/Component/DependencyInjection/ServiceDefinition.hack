namespace Quasar\Component\DependencyInjection;

type ServiceIdentification = shape(
    'classname' => classname<mixed>,
    'id' => ?string
);

class ServiceDefinition<+T>
{
    private vec<(function(T): void)> $runAfterInstanciation = vec[];
    private bool $autowired = true;
    private dict<string, ServiceIdentification> $serviceArguments = dict[];
    private dict<string, mixed> $scalarArguments = dict[];

    public function __construct(
        private classname<T> $serviceClass,
        private ?string $id = null
    )
    {}

    /**
     * Get the service class name.
     * 
     * @return classname<mixed> The service classname.
     */
    public function getServiceClass(): classname<T>
    {
        return $this->serviceClass;
    }

    /**
     * Get the service id or null if he has no id.
     * 
     * @return ?string The service id.
     */
    public function getId(): ?string
    {
        return $this->id;
    }

    /**
     * Set a constructor service argument by name.
     * 
     * @param $name The service argument name.
     */
    public function setServiceArgument(
        string $name,
        classname<mixed> $classname,
        ?string $id
    ): void {
        unset($this->scalarArguments[$name]);

        $this->serviceArguments[$name] = shape(
            'classname' => $classname,
            'id' => $id
        );
    }

    /**
     * Get the service argument by name.
     * 
     * @param string $name The argument name.
     * 
     * @return ?ServiceIdentification The service argument or null if it does not exist.
     */
    public function getServiceArgument(string $name): ?ServiceIdentification
    {
        return $this->serviceArguments[$name] ?? null;
    }

    /**
     * Set the scalar argument by name.
     * 
     * @param string $name The argument name.
     * @param mixed $value The argument value.
     * 
     * @return void
     */
    public function setScalarArgument(string $name, mixed $value): void
    {
        unset($this->serviceArguments[$name]);
        $this->scalarArguments[$name] = $value;
    }

    /**
     * Get scalar argument by name.
     * 
     * @param $name The argument name.
     * 
     * @return mixed The argument value or null if it does not exist.
     */
    public function getScalarArgument(string $name): mixed
    {
        return $this->scalarArguments[$name] ?? null;
    }

    /**
     * Test if the service class must be autowired.
     * 
     * @return bool True if the service is autowired, else false.
     */
    public function isAutowired(): bool {
        return $this->autowired;
    }

    /**
     * Add closure to call after service instanciation.
     *  
     * @param (function(T): void) $function The closure to call after service instanciation.
     * 
     * @return void
     */
    public function runAfterInstanciation((function(T): void) $closure): void {
        $this->runAfterInstanciation[] = $closure; 
    }
}
