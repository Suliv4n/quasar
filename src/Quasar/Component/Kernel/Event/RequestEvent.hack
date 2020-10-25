namespace Quasar\Component\Kernel\Event;

use type Quasar\Component\EventDispatcher\Event;
use type Quasar\Component\Http\{Request, ResponseInterface};

/**
 * Event triggered when the kernel receive a request.
 */
class RequestEvent extends Event
{

    /**
     * Generated response.
     */
    <<__LateInit>>
    private ResponseInterface $response;

    /**
     * Constructor.
     *
     * @param Request $request The received request.
     */
    public function __construct(
        private Request $request
    ){}

    /**
     * Get the request received.
     *
     * @return Request
     */
    public function getRequest(): Request
    {
        return $this->request;
    }

    /**
     * Set the response to send for the received request.
     *
     * @param ResponseInterface $response The response to set.
     */
    public function setResponse(ResponseInterface $response): void
    {
        $this->response = $response;
    }

    /**
     * Get the response to send for the received request.
     *
     * @return ResponseInterface
     */
    public function getResponse(): ResponseInterface
    {
        return $this->response;
    }

}
