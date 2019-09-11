namespace Quasar\Component\Http;

type ControllerCallback = shape(
    "class" => classname<mixed>,
    "method" => string
);

class Request
{

    private ?ControllerCallback $controllerCallback;

    public function __construct(
        private ParameterContainer $get,
        private ParameterContainer $post,
        private ParameterContainer $cookies,
        private ParameterContainer $files,
        private ParameterContainer $server,
        private ?string $content = null
    )
    {}

    public function getMethod(): HttpMethodEnum
    {
        return HttpMethodEnum::assert($this->server->get("REQUEST_METHOD"));
    }

    public function get(): ParameterContainer
    {
        return $this->get;
    }

    public function post(): ParameterContainer
    {
        return $this->post;
    }

    public function getPath(): string
    {
        return (string) $this->server->get("REQUEST_URI");
    }

    public function setControllerCallback(ControllerCallback $controllerCallback): void
    {
        $this->controllerCallback = $controllerCallback;
    }

    public function getControllerCallback(): ?ControllerCallback
    {
        return $this->controllerCallback;
    }
}