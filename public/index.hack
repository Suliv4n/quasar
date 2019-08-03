require_once(__DIR__  . "/../vendor/hh_autoload.hh");

use type Quasar\Component\Http\RequestFactory;
use type Quasar\Component\Kernel\HttpKernel;
use type Quasar\Component\DependencyInjection\ServicesContainer;

use type Quasar\Component\Routing\Router;
use type Quasar\Component\Routing\AttributeRouteLoader;
use type Quasar\Component\Routing\UrlMatcher;
use type Quasar\Component\Routing\RouteCompiler;

use type Quasar\Component\EventDispatcher\EventDispatcher;

function configureContainer(ServicesContainer $container): void
{
    $container->set(AttributeRouteLoader::class);
    $container->set(UrlMatcher::class);
    $container->set(RouteCompiler::class);
    $container->set(Router::class);
    $container->set(EventDispatcher::class);
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
