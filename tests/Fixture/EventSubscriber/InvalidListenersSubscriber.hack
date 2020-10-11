namespace Fixture\EventSubscriber;

use Fixture\Event\{RouteRequestEvent, ResponseEvent};
use Quasar\Component\EventDispatcher\Attribute\Subscribe;

class InvalidListenersSubscriber
{
    private vec<string> $methodsCalled = vec[];

    <<Subscribe(RouteRequestEvent::class)>>
    public function onRouteRequestEvent(RouteRequestEvent $event, int $tooMuchParameter): void
    {
        $this->methodsCalled[] = "onRouteRequestEvent";
    }

    <<Subscribe(ResponseEvent::class)>>
    public function onResponseEvent(RouteRequestEvent $wrongTypeHint): void
    {
        $this->methodsCalled[] = "onResponseEvent";
    }

}