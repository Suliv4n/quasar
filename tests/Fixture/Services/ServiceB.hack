namespace Fixture\Services;

class ServiceB
{
    public function __construct(
        private ServiceA $serviceA
    )
    {

    }

    public function return42(): int
    {
        return $this->serviceA->return42();
    }
}