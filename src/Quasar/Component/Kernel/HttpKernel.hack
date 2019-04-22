namespace Quasar\Component\Kernel;

use Quasar\Component\Http\{
    Request,
    Response
};

use Quasar\Component\DependencyInjection\ContainerInterface;


class HttpKernel
{

    public function __construct(
        private string $environment,
        private ContainerInterface $container,
    )
    {}

    public function handle(Request $request): Response
    {
        $response = new Response();

        return $response;
    }
}