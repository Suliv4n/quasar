namespace Fixture\Services;

class ServiceC
{
    public function __construct(
        private ServiceA $serviceA,
        private int $scalarParameter
    )
    {}

    public function returnParameter(): int
    {
        return $this->serviceA->return42();
    }

    public function getParameter(): int
    {
        return $this->scalarParameter;
    }
}