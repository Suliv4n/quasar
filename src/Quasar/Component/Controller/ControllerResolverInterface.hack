namespace Quasar\Component\Controller;

use type Quasar\Component\Http\Request;

interface ControllerResolverInterface
{
    public function resolveController(Request $request): mixed;
}