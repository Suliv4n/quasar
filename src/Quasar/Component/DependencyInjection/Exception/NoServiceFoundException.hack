namespace Quasar\Component\DependencyInjection\Exception;

use type LogicException;
use namespace HH\Lib\Str;

class NoServiceFoundException extends LogicException
{
    public function __construct(string $serviceId) {
        parent::__construct(Str\format('No service with id %s was found in container.', $serviceId));
    }
}
