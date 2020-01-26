namespace Quasar\Component\Controller;

use type Quasar\Component\Http\Request;
use type Quasar\Component\DependencyInjection\ContainerInterface;

/**
 * Controller resolver interface.
 */
interface ControllerResolverInterface
{
    /**
     * Resolve a controller from an http request.
     * 
     * @param Request $request The request from which the controller must be resolved.
     */
    public function resolveController(Request $request, ContainerInterface $container): mixed;
}
