namespace Quasar\Component\Http;

class Response
{
    public function __construct(
        private string $content = "",
        private HttpStatusCodeEnum $statusCode = HttpStatusCodeEnum::OK
    )
    {}
}