namespace Quasar\Component\EventDispatcher\Attribute;

use Quasar\Component\EventDispatcher\Event;

class Subscribe implements \HH\MethodAttribute
{
    public function __construct(
        private classname<Event> $eventClass,
        private int $priority = 0
    )
    {}

    public function getSubscribedEvent(): classname<Event>
    {
        return $this->eventClass;
    }

    public function getPriority(): int
    {
        return $this->priority;
    }
}