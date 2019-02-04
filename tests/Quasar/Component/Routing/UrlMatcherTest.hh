<?hh //strict
namespace Quasar\Component\Routing;

use function Facebook\FBExpect\expect;
use type Facebook\HackTest\HackTest;
use type Facebook\HackTest\DataProvider;

class UrlMatcherTest extends HackTest
{

    public function provideRoutesAndContext() : Vector<(Vector<CompiledRoute>, string, RequestContext)>
    {
        return Vector{
            tuple(
                Vector{
                    
                    new CompiledRoute('`/quasar/admin/(\d+)/(.*)`', Vector{
                        new RouteParameter("id"),
                        new RouteParameter("slug"),
                    }),

                    new CompiledRoute('`/quasar/comment/(\d+)/`', Vector{
                        new RouteParameter("id"),
                    }),

                    new CompiledRoute('`/quasar/admin/`', Vector{}),
                    
                    new CompiledRoute('`/quasar/(\d+)/(.*)`', Vector{
                        new RouteParameter("id"),
                        new RouteParameter("slug"),
                    }),

                    new CompiledRoute("`/nope`", Vector{}),
                },
                "/quasar/2/hack-is-amazing",
                new RequestContext("get", "/quasar/2/hack-is-amazing")
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

        $parameters = $route->getParameters();
        expect($parameters->count())->toBeSame(2);
        expect($parameters[0]->getValue())->toBeSame("2");
        expect($parameters[1]->getValue())->toBeSame("hack-is-amazing");
    }
}