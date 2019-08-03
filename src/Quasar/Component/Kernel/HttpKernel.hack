namespace Quasar\Component\Kernel;

use type Quasar\Component\Http\{
    Request,
    Response
};
use type Quasar\Component\Routing\RouterInterface;
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

    public function handle(Request $request): Response
    {
        $response = new Response();

        $eventDispatcher = $this->container->get(EventDispatcherInterface::class);

        $requestEvent = new RequestEvent($request);
        $eventDispatcher->dispatch($requestEvent);

        return $response;
    }
}