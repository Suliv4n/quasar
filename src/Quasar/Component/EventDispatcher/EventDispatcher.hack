namespace Quasar\Component\EventDispatcher;

use Quasar\Component\EventDispatcher\Attribute\Subscribe;

use namespace HH\Lib\Vec;
use namespace HH\Lib\C;
use namespace HH\Lib\Str;

type EventCallback = shape(
    "method" => \ReflectionMethod,
    "class" => nonnull,
    "priority" => int
);

class EventDispatcher implements EventDispatcherInterface
{
    public function __construct(
        private vec<nonnull> $eventSubscribers,
    )
    {}

    public function dispatch(Event $event): void
    {
        $callbacks = $this->compileSubscribers($event);
        
        foreach($callbacks as $callback)
        {
            $callback["method"]->invoke($callback["class"], $event);
        }
    }

    private function compileSubscribers(Event $event): vec<EventCallback>
    {
        $callbacks = vec[];

        foreach ($this->eventSubscribers as $subscriber) 
        {
            $reflectionClass = new \ReflectionClass($subscriber);
            $methods = $reflectionClass->getMethods();

            foreach ($methods as $method)
            {
                $callbackAttribute = $method->getAttributeClass(Subscribe::class);

                if ($callbackAttribute is null)
                {
                    continue;
                }

                if (\is_a($event, $callbackAttribute->getSubscribedEvent()))
                {
                    $this->checkMethodValidListener($method, $event);

                    $callbacks[] = shape(
                        "class" => $subscriber,
                        "method" => $method,
                        "priority" => $callbackAttribute->getPriority()
                    );
                }
            }
        }

        $callbacks = Vec\sort_by(
            $callbacks,
            ($callback) ==> $callback["priority"],
            ($previous, $next) ==> ($next <=> $previous),
        );

        return $callbacks;
    }

    private function checkMethodValidListener(\ReflectionMethod $method, Event $event): void
    {
        $parameters = $method->getParameters();

        if (
            C\count($parameters) === 1 &&
            \is_a($event, $parameters[0]->getTypeText())
        )
        {
            return;
        }
        
        throw new \LogicException(
            Str\format(
                "%s is not a valid listener for event of type %s. The method must have only one argument of type %s",
                $method->getNamespaceName(),
                \get_class($event),
                \get_class($event)
            )
        );
    }

}