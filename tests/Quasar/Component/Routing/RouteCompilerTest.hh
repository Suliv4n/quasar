<?hh //strict
namespace Quasar\Component\Routing;

use function Facebook\FBExpect\expect;
use type Facebook\HackTest\HackTest;
use type Facebook\HackTest\DataProvider;

class RouteCompilerTest extends HackTest
{

    public function provideSimpleRoute() : vec<(Route)>
    {
        return vec[
            tuple(new Route("/quasar"))
        ];
    }

    public function provideParameteredRoute() : vec<(Route)>
    {
        return vec[
            tuple(new Route("/quasar/{slug}"))
        ];
    }

    public function provideRouteWithRequirements() : vec<(Route)>
    {
        return vec[
            tuple(new Route("/quasar/{id}", Map{
                "id" => "\d+",
            }))
        ];
    }

    public function provideRouteWithInvalidRequirements() : vec<(Route)>
    {
        return vec[
            tuple(new Route("/quasar/{slug}", Map{
                "slug" => "[a|b",
            }))
        ];
    }

    <<DataProvider("provideSimpleRoute")>>
    public function testCompileSimpleRoute(Route $route) : void
    {
        $routeCompiler = new RouteCompiler();
        $compiledRoute = $routeCompiler->compile($route);

        $regex = $compiledRoute->getRegex();

        expect($regex)->toBeSame("`/quasar`");
    }

    <<DataProvider("provideParameteredRoute")>>
    public function testCompileParameteredRoute(Route $route) : void
    {
        $routeCompiler = new RouteCompiler();
        $compiledRoute = $routeCompiler->compile($route);

        $regex = $compiledRoute->getRegex();

        expect($regex)->toBeSame("`/quasar/(.*)`");
    }

    <<DataProvider("provideRouteWithRequirements")>>
    public function testCompileRouteWithRequirements(Route $route) : void
    {
        $routeCompiler = new RouteCompiler();
        $compiledRoute = $routeCompiler->compile($route);

        $regex = $compiledRoute->getRegex();

        expect($regex)->toBeSame("`/quasar/(\d+)`");
    }

    <<DataProvider("provideRouteWithInvalidRequirements")>>
    public function testTryCompileRouteWithInvalidRequirements(Route $route) : void
    {
        $routeCompiler = new RouteCompiler();
        expect(() ==> $routeCompiler->compile($route))->toThrow(\LogicException::class);
    }
}