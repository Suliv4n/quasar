namespace Quasar\Component\Http;

/**
 * Http response interface.
 */
interface ResponseInterface
{
    /**
     * Send response.
     */
    public function send(): void;
}
