namespace Quasar\Component\DependencyInjection\Compiler;

use type Quasar\Component\DependencyInjection\ContainerInterface;

interface CompilerPassInterface
{
    public function process(ContainerInterface $container): void;
}
