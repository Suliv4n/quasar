<?hh //strict
namespace Mock\Services;

class ServiceA
{
    public function __construct()
    {}

    public function return42() : int
    {
        return 42;
    }
}
