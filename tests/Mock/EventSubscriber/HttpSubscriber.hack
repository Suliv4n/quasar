namespace Mock\EventSubscriber;

use Quasar\Component\EventDispatcher\EventSubscriberInterface;
use Quasar\Component\EventDispatcher\Event;
use Quasar\Component\EventDispatcher\Attribute\Subscribe;

use Mock\Event\RouteRequestEvent;

class HttpSubscriber
{
    <<__LateInit>>
    private string $route;

    <<Subscribe(RouteRequestEvent::class)>>
    public function onRouteRequest(RouteRequestEvent $event): void
    {
        $this->route = $event->getRoute();
    }

    public function getRoute(): string
    {
        return $this->route;
    }
}