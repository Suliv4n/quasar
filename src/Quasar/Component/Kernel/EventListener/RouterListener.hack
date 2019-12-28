namespace Quasar\Component\Kernel\EventListener;

use type Quasar\Component\Kernel\Event\RequestEvent;
use type Quasar\Component\EventDispatcher\Attribute\Subscribe;
use type Quasar\Component\Routing\RouterInterface;

/**
 * Event listener for request.
 */
class RequestListener
{
    /**
     * Constructor.
     * 
     * @param RouterInterface $router The router to use for requests.
     */
    public function __construct(
        private RouterInterface $router
    )
    {}

    /**
     * Handle a request received by the kernel.
     * 
     * @param RequestEvent $event The request event to handle.
     */
    <<Subscribe(RequestEvent::class)>>
    public function onHttpKernelRequest(RequestEvent $event): void
    {
        $event->getRequest();
    }
}
