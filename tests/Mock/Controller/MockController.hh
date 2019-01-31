<?hh //strict
namespace Mock\Controller;

use Quasar\Component\Routing\Route;

class MockController
{
    <<Route("/route/example/{id}")>>
    public function getAction() : void
    {
        echo "Hello world";
    }

    <<Route("/route/example2/{slug}")>>
    public function getOtherAction() : void
    {
        echo "Hello friend";
    }
}