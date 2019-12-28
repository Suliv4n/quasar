namespace Quasar\Component\EventDispatcher;

interface EventListenerInterface <T as Event>
{
    public function handle(T $event): void;
}
