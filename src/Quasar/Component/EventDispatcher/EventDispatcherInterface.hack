namespace Quasar\Component\EventDispatcher;

interface EventDispatcherInterface
{
    public function dispatch(Event $event): void;
}