namespace Mock\EventSubscriber;

use Mock\Event\RouteRequestEvent;
use Quasar\Component\EventDispatcher\Attribute\Subscribe;

class MultipleListenersSubscriber
{
    private vec<string> $methodsCalled = vec[];

    <<Subscribe(RouteRequestEvent::class, -10)>>
    public function thirdListener(RouteRequestEvent $event): void
    {
        $this->methodsCalled[] = "thirdListener";
    }

    <<Subscribe(RouteRequestEvent::class, 40)>>
    public function firstListener(RouteRequestEvent $event): void
    {
        $this->methodsCalled[] = "firstListener";
    }

    <<Subscribe(RouteRequestEvent::class, 20)>>
    public function secondListener(RouteRequestEvent $event): void
    {
        $this->methodsCalled[] = "secondListener";
    }

    public function getMethodsCalled(): vec<string>
    {
        return $this->methodsCalled;
    }
}