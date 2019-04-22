require_once(__DIR__  . "/../vendor/hh_autoload.hh");

use Quasar\Component\Http\RequestFactory;
use Quasar\Component\Kernel\HttpKernel;
use Quasar\Component\DependencyInjection\ServicesContainer;

<<__EntryPoint>>
function main(): noreturn 
{
    $request = RequestFactory::createFromSuperGlobals();

    $container = new ServicesContainer();

    $kernel = new HttpKernel("test", $container);

    $response = $kernel->handle($request);

    exit(0);
}
