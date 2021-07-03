require_once(__DIR__  . "/../vendor/hh_autoload.hh");

use type Quasar\Component\Http\RequestFactory;
use type Quasar\Component\Kernel\HttpKernel;
use type Quasar\Component\DependencyInjection\ServiceContainer;

use type Quasar\Component\Routing\Router;
use type Quasar\Component\Routing\AttributeRouteLoader;
use type Quasar\Component\Routing\UrlMatcher;
use type Quasar\Component\Routing\RouteCompiler;

use type Quasar\Component\EventDispatcher\EventDispatcher;

use type App\Controller\HomeController;

function configureContainer(ServiceContainer $container): void
{

}

<<__EntryPoint>>
function main(): noreturn 
{
    /*
    $request = RequestFactory::createFromSuperGlobals();

    $container = new ServicesContainer();

    configureContainer($container);

    $kernel = new HttpKernel("dev", $container);

    $response = $kernel->handle($request);

    exit(0);
    */

    $controller = new HomeController();

    $response = $controller->index();

    $response->send();

    exit(0);
}
