namespace Fixture\EventSubscriber;

use type Fixture\Event\{ResponseEvent, RouteRequestEvent};
use type Quasar\Component\EventDispatcher\Attribute\Subscribe;

class InvalidListenersSubscriber
{
    private vec<string> $methodsCalled = vec[];

    <<Subscribe(RouteRequestEvent::class)>>
    public function onRouteRequestEvent(RouteRequestEvent $_event, int $_tooMuchParameter): void
    {
        $this->methodsCalled[] = "onRouteRequestEvent";
    }

    <<Subscribe(ResponseEvent::class)>>
    public function onResponseEvent(RouteRequestEvent $_wrongTypeHint): void
    {
        $this->methodsCalled[] = "onResponseEvent";
    }

}
