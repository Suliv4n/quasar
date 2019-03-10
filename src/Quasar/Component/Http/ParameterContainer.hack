namespace Quasar\Component\Http;

use namespace HH\Lib\C;

class ParameterContainer
{
    public function __construct(
        private dict<string, mixed> $parameters
    )
    {}

    public function get(string $key, ?string $default = null): mixed
    {
        if (! $this->has($key))
        {
            return $default;
        }

        return $this->parameters[$key];
    }

    public function has(string $key): bool
    {
        return C\contains_key($this->parameters, $key);
    }
}