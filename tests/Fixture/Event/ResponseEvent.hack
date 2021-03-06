namespace Fixture\Event;

use type Quasar\Component\EventDispatcher\Event;

class ResponseEvent extends Event
{
    public function __construct(
        private string $content,
    )
    {}

    public function getContent(): string
    {
        return $this->content;
    }
}
