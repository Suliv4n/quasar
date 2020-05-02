namespace App\Configuration;

use type Quasar\Component\DependencyInjection\ContainerConfiguration;
use type Quasar\Component\Routing\RouterInterface;

class Routing
{
    public function __construct(
        private ContainerConfiguration $configuration
    ) {}

    public function configure(): void {
        $routing = $this->configuration->getServiceDefinition<RouterInterface>();
        $routing->runAfterInstanciation((RouterInterface $router) ==> $router->loadRoutes());
    }
}