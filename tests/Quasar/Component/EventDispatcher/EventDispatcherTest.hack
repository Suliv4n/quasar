namespace Quasar\Component\EventDispatcher;

use Mock\Event\{RouteRequestEvent, ResponseEvent};
use Mock\EventSubscriber\HttpSubscriber;
use Mock\EventSubscriber\MultipleListenersSubscriber;
use Mock\EventSubscriber\InvalidListenersSubscriber;


use type Facebook\HackTest\HackTest;
use function Facebook\FBExpect\expect;


use namespace HH\Lib\C;

class EventDispatcherTest extends HackTest
{
    public function testSimpleEventDispatch(): void
    {
        $subscriber = new HttpSubscriber();
        $eventDispatcher = new EventDispatcher(
            vec[
                $subscriber,
            ]
        );

        $event = new RouteRequestEvent(
            "article_detail",
            "/article/1"
        );

        $eventDispatcher->dispatch($event);

        expect($subscriber->getRoute())->toBeSame("article_detail");
    }

    public function testOneSubscriberSeveralListeners(): void
    {
        $subscriber = new MultipleListenersSubscriber();
        $eventDispatcher = new EventDispatcher(
            vec[
                $subscriber,
            ]
        );

        $event = new RouteRequestEvent(
            "article_detail",
            "/article/1"
        );

        $eventDispatcher->dispatch($event);
        $methodsCalled = $subscriber->getMethodsCalled();

        expect(C\count($methodsCalled))->toBeSame(3);
        expect($methodsCalled[0])->toBeSame("firstListener");
        expect($methodsCalled[1])->toBeSame("secondListener");
        expect($methodsCalled[2])->toBeSame("thirdListener");
    }

    public function testInvalidlistener(): void
    {
        $subscriber = new InvalidListenersSubscriber();
        $eventDispatcher = new EventDispatcher(
            vec[
                $subscriber,
            ]
        );

        $event = new RouteRequestEvent(
            "article_detail",
            "/article/1"
        );

        expect(() ==> $eventDispatcher->dispatch($event))->toThrow(\LogicException::class);
    }
}