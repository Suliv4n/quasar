namespace Fixture\Event;

use type Quasar\Component\EventDispatcher\Event;

class RouteRequestEvent extends Event
{
    public function __construct(
        private string $route,
        private string $url
    )
    {}

    public function getRoute(): string
    {
        return $this->route;
    }

    public function getUrl(): string
    {
        return $this->url;
    }
}
