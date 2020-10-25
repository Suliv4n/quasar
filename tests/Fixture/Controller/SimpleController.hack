namespace Fixture\Controller;

use type Quasar\Component\Routing\Route;
use type Quasar\Component\Http\Response;

class SimpleController
{
    <<Route("/route/example/{id}", vec["GET"], dict["id" => "\d+"])>>
    public function getAction() : Response
    {
        return new Response();
    }

    <<Route("/route/example2/{slug}", vec["GET", "POST"])>>
    public function getOtherAction() : void
    {
        echo "Hello friend";
    }
}
