namespace Quasar\Component\Http;

use namespace HH\Lib\Str;

/**
 * Response with string content.
 */
class Response implements ResponseInterface
{
    /**
     * Contructor.
     *
     * @param string $content Response body content.
     * @param HttpStatusCodeEnum $statusCode Response status code.
     * @param dict<string, mixed> Map of response headers.
     */
    public function __construct(
        private string $content = "",
        private HttpStatusCodeEnum $statusCode = HttpStatusCodeEnum::OK,
        private dict<string, mixed> $headers = dict[]
    )
    {}

    /**
     * Return the response content.
     *
     * @return string The response content.
     */
    public function getContent(): string
    {
        return $this->content;
    }

    /**
     * Set the response content.
     */
    public function setContent(string $content): void
    {
        $this->content = $content;
    }

    /**
     * @inheritDoc
     */
    public function send(): void
    {
        $this->sendHeaders();
        \http_response_code($this->statusCode as int);
        echo $this->getContent();
    }

    /**
     * Send response headers.
     */
    private function sendHeaders(): void
    {

        if (\headers_sent())
        {
            return;
        }

        foreach ($this->headers as $name => $value)
        {
            $header = Str\format('%s: %s', $name, \strval($value));
            \header($header);
        }
    }
}
