<?hh //strict
namespace Quasar\Component\Routing;

/**
 * Represent an http request context.
 */
class RequestContext
{

    /**
     * Constructor.
     *
     * @param string $url The request url.
     * @param string $method The request method.
     */
    private function __construct(
        private string $url,
        private string $method
    )
    {}

    /**
     * Return the request method.
     *
     * @return string The request method.
     */
    public function getMethod() : string
    {
        return $this->method;
    }

    /**
     * Return the request url.
     *
     * @return The request url.
     */
    public function getUrl() : string
    {
        return $this->url;
    }
}