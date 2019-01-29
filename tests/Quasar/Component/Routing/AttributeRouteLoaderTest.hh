<?hh //strict
namespace Quasar\Component\Routing;

use function Facebook\FBExpect\expect;
use type Facebook\HackTest\HackTest;

class AttributeRouteLoaderTest extends HackTest
{
    const string MOCK_CONTROLLERS_PATH = __DIR__ . "/../../../Mock/Controller";

    public function testLoad() : void
    {
        $loader = new AttributeRouteLoader(Vector{
            self::MOCK_CONTROLLERS_PATH,
        });

        $loader->loadRoutes();
    }
}