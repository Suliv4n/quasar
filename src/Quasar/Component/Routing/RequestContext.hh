<?hh //strict
namespace Quasar\Component\Routing;

class RequestContext
{
    private function __construct(
        private string $url,
        private string $method
    )
    {}

    public function getMethod() : string
    {
        return $this->method;
    }

    public function getUrl() : string
    {
        return $this->url;
    }
}