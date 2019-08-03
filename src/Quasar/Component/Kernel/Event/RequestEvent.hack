namespace Quasar\Component\Kernel\Event;

use type Quasar\Component\EventDispatcher\Event;
use type Quasar\Component\Http\Request;

class RequestEvent extends Event
{

    public function __construct(
        private Request $request
    ){}

    public function getRequest(): Request
    {
        return $this->request;
    }

}