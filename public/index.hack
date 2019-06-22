require_once(__DIR__  . "/../vendor/hh_autoload.hh");

use Quasar\Component\Http\RequestFactory;
use Quasar\Component\Kernel\HttpKernel;
use Quasar\Component\DependencyInjection\ServicesContainer;

use Quasar\Component\Routing\Router;
use Quasar\Component\Routing\AttributeRouteLoader;
use Quasar\Component\Routing\UrlMatcher;
use Quasar\Component\Routing\RouteCompiler;


function configureContainer(ServicesContainer $container): void
{
    $container->set(AttributeRouteLoader::class);
    $container->set(UrlMatcher::class);
    $container->set(RouteCompiler::class);
    $container->set(Router::class);
}

<<__EntryPoint>>
function main(): noreturn 
{
    $request = RequestFactory::createFromSuperGlobals();

    $container = new ServicesContainer();

    configureContainer($container);

    $kernel = new HttpKernel("test", $container);

    $response = $kernel->handle($request);

    exit(0);
}
