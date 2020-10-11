namespace Quasar\Component\DependencyInjection\Exception;

use type LogicException;

class DefinitionException extends LogicException
{
    public function __construct(string $message) {
        parent::__construct($message);
    } 
}