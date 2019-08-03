namespace Quasar\Component\Kernel\EventListener;

use type Quasar\Component\Kernel\Event\RequestEvent;
use type Quasar\Component\EventDispatcher\Attribute\Subscribe;

class RouterListener
{
    <<Subscribe(RequestEvent::class)>>
    public function onHttpKernelRequest(RequestEvent $event): void
    {
        //routage et tout
    }
}