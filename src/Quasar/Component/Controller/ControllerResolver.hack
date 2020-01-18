namespace Quasar\Component\Controller;

use type Quasar\Component\Http\{ControllerCallback, Request};
use type Quasar\Component\DependencyInjection\AutowireProcessorInterface;

use namespace HH\Lib\Str;

/**
 * Resolve controllers.
 */
class ControllerResolver implements ControllerResolverInterface
{
    /**
     * Constructor.
     * 
     * @param AutowireProcessorInterface $autowire Autowire to use for controller creation. 
     */
    public function __construct(
        private AutowireProcessorInterface $autowire
    )
    {}

    /**
     * Resolve the controller from the request.
     *
     * @param Request The request from which the controller callback is defined.
     *
     * @return mixed The controller instance associated to the request.
     */
    public function resolveController(Request $request): mixed
    {
        $controllerCallback = $request->getControllerCallback();

        if ($controllerCallback is null)
        {
            return null;
        }

        $controller = $this->createController($controllerCallback);

        return $controller;
    }

    /**
     * Create a crontroller instance from a controller callback.
     *
     * @param ControllerCallback The controller callback definition.
     *
     * @return nonnull Controller instance defined in the controller callback.
     */
    private function createController(ControllerCallback $controllerCallback): nonnull
    {
        $controllerClass = $controllerCallback["class"];
        $controllerMethod = $controllerCallback["method"];

        $controllerReflection = new \ReflectionClass($controllerClass);

        if (!$controllerReflection->hasMethod($controllerMethod))
        {
            throw new \LogicException(Str\format("The controller class %s has no method %s.", $controllerClass, $controllerMethod));
        }

        $controllerInstance = $this->autowire->process($controllerClass);
        invariant($controllerInstance is nonnull, "Controller instance should not ne null.");

        return $controllerInstance;
    }
}
