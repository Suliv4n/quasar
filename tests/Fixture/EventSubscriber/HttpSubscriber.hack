namespace Fixture\EventSubscriber;

use type Quasar\Component\EventDispatcher\Attribute\Subscribe;

use type Fixture\Event\RouteRequestEvent;

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
