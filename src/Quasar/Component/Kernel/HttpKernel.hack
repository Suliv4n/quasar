namespace Quasar\Component\Kernel;

use type Quasar\Component\Http\Request;
use type Quasar\Component\Http\ResponseInterface;
use type Quasar\Component\DependencyInjection\ContainerInterface;
use type Quasar\Component\EventDispatcher\EventDispatcherInterface;
use type Quasar\Component\Kernel\Event\RequestEvent;

/**
 * Kernel handling http request.
 */
class HttpKernel
{

    /**
     * Constructor.
     * 
     * @param string $environment Kernel environment name.
     * @param ContainerInterface $container The depency injection container.
     */
    public function __construct(
        private string $environment,
        private ContainerInterface $container,
    )
    {}

    /**
     * Handle a raquest and return the response.
     * 
     * @param Request $request The request to handle.
     * 
     * @return ResponsInterface The request's response.
     */
    public function handle(Request $request): ResponseInterface
    {
        $eventDispatcher = $this->container->get(EventDispatcherInterface::class);

        $requestEvent = new RequestEvent($request);
        $eventDispatcher->dispatch($requestEvent);

        $response = $requestEvent->getResponse();

        return $response;
    }
}
