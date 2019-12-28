namespace Quasar\Component\Kernel;

use type Quasar\Component\Http\{
    Request,
    ResponseInterface
};
use type Quasar\Component\DependencyInjection\ContainerInterface;
use type Quasar\Component\EventDispatcher\EventDispatcherInterface;
use type Quasar\Component\Kernel\Event\RequestEvent;

class HttpKernel
{

    public function __construct(
        private string $environment,
        private ContainerInterface $container,
    )
    {}

    public function handle(Request $request): ResponseInterface
    {
        $eventDispatcher = $this->container->get(EventDispatcherInterface::class);

        $requestEvent = new RequestEvent($request);
        $eventDispatcher->dispatch($requestEvent);

        $response = $requestEvent->getResponse();

        return $response;
    }
}
