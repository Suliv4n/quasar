<?hh //strict
namespace Mock\Controller;

use Quasar\Component\Routing\Route;

class MockController
{
    <<Route("/route/example/{id}", vec["GET"], dict["id" => "\d+"])>>
    public function getAction() : void
    {
        echo "Hello world";
    }

    <<Route("/route/example2/{slug}", vec["GET", "POST"])>>
    public function getOtherAction() : void
    {
        echo "Hello friend";
    }
}