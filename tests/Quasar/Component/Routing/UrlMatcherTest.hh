<?hh //strict
namespace Quasar\Component\Routing;

use function Facebook\FBExpect\expect;
use type Facebook\HackTest\HackTest;
use type Facebook\HackTest\DataProvider;

use namespace HH\Lib\C;

class UrlMatcherTest extends HackTest
{

    public function provideRoutesAndContext() : Vector<(Vector<CompiledRoute>, string, RequestContext)>
    {
        return Vector{
            tuple(
                Vector{
                    
                    new CompiledRoute('`/quasar/admin/(\d+)/(.*)`', vec["post"], vec[
                        new RouteParameter("id"),
                        new RouteParameter("slug"),
                    ]),

                    new CompiledRoute('`/quasar/comment/(\d+)/`', vec["get"], vec[
                        new RouteParameter("id"),
                    ]),

                    new CompiledRoute('`/quasar/admin/`', vec["post"], vec[]),
                    
                    new CompiledRoute('`/quasar/(\d+)/(.*)`', vec["update"], vec[
                        new RouteParameter("id"),
                        new RouteParameter("slug"),
                    ]),

                    new CompiledRoute('`/quasar/(\d+)/(.*)`', vec["get"], vec[
                        new RouteParameter("id"),
                        new RouteParameter("slug"),
                    ]),

                    new CompiledRoute("`/nope`", vec["get"], vec[]),
                },
                "/quasar/2/hack-is-amazing",
                new RequestContext("GET", "/quasar/2/hack-is-amazing")
            )
        };
    }

    <<DataProvider("provideRoutesAndContext")>>
    public function testMatcher(Vector<CompiledRoute> $routes, string $path, RequestContext $requestContext) : void
    {
        $urlMatcher = new UrlMatcher();

        $route = $urlMatcher->match($routes, $path, $requestContext);

        expect($route)->toNotBeNull();

        if ($route === null)
        {
            return;
        }

        expect($route->getRegex())->toBeSame("`/quasar/(\d+)/(.*)`");
        expect(\count($route->getAllowedMethods()))->toBeSame(1);
        expect($route->getAllowedMethods()[0])->toBeSame("get");

        $parameters = $route->getParameters();
        expect(C\count($parameters))->toBeSame(2);
        expect($parameters[0]->getValue())->toBeSame("2");
        expect($parameters[1]->getValue())->toBeSame("hack-is-amazing");
    }
}